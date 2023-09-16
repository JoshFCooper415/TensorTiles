#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <cstdlib>

// Function to send a JSON message to the server
void sendJSONMessage(int clientSocket, const std::string& messageJson) {
    send(clientSocket, messageJson.c_str(), messageJson.size(), 0);
}

int main() {
    struct sockaddr_in serverAddr;
    char buffer[1024];

    // Create a socket
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
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

    while (true) {
        // Read input from the terminal
        std::cout << "Enter a message (JSON format): ";
        std::string message;
        std::getline(std::cin, message);

        if (message == "exit") {
            break;
        }

        // Create a JSON object for the user message
        std::string messageJson = "{\"type\":\"user_message\",\"content\":\"" + message + "\"}";

        // Send the user message as JSON to the server using the external function
        sendJSONMessage(clientSocket, messageJson);

        // Receive and display the server's response
        memset(buffer, 0, sizeof(buffer));
        recv(clientSocket, buffer, sizeof(buffer), 0);
        std::cout << "Server response: " << buffer << std::endl;
    }

    // Close the socket
    close(clientSocket);

    return 0;
}
