#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <cstdlib>
#include "nlohmann/json.hpp"

using json = nlohmann::json;

int clientSocket; // Declare the socket as a global variable

// Function to send a JSON message to the server
void sendJSONMessage(const json& messageJson) {
    std::string jsonMessage = messageJson.dump();
    send(clientSocket, jsonMessage.c_str(), jsonMessage.size(), 0);
}

int main() {
    struct sockaddr_in serverAddr;
    char buffer[1024];

    // Create a socket
    clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (clientSocket == -1) {
        std::cerr << "Error: Could not create socket" << std::endl;
        return 1;
    }

    // Configure server address
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(8080); // Replace with your server's port
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1"); // Replace with your server's IP address

    // Connect to the server
    if (connect(clientSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) == -1) {
        std::cerr << "Error: Could not connect to server" << std::endl;
        return 1;
    }

    std::cout << "Connected to server. Type 'exit' to quit." << std::endl;

    // Create a connection JSON object
    json connectionJson;
    connectionJson["type"] = "connection";
    connectionJson["client_name"] = "YourClientName"; // Replace with your client name or identifier

    // Send the connection JSON to the server
    sendJSONMessage(connectionJson);

    while (true) {
        // Read input from the terminal
        std::cout << "Enter a message (JSON format): ";
        std::string message;
        std::getline(std::cin, message);

        if (message == "exit") {
            break;
        }

        // Create a JSON object for the user message
        json messageJson;
        messageJson["type"] = "user_message";
        messageJson["content"] = message;

        // Send the user message as JSON to the server using the external function
        sendJSONMessage(messageJson);

        // Receive and display the server's response
        memset(buffer, 0, sizeof(buffer));
        recv(clientSocket, buffer, sizeof(buffer), 0);
        std::cout << "Server response: " << buffer << std::endl;
    }

    // Close the socket
    close(clientSocket);

    return 0;
}
