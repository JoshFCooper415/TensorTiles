#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

int main() {
    // Create a socket
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (clientSocket == -1) {
        std::cout << "Failed to create connection to client socket connection" << std::endl;
        return -1;
    }
    // Define the server side address
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(8080);
    serverAddress.sin_addr.s_addr = INADDR_LOOPBACK;

    // Connect to Python Server
    if (connect(clientSocket, (struct sockaddr*)&serverAddress, sizeof(serverAddress)) == -1) {
        std::cout << "Failed to Connect to Server" << std::endl;
        return -1;
    }

    // Send Test Message
    const char* message = "Hello Python Server!";
    ssize_t bytesSent = send(clientSocket, message, strlen(message), 0);

    if (bytesSent == -1) {
        std::cout << "Failed to send message" << std::endl;
        return -1;
    }

    std::cout << "SENT DATA SUCCESSFUL" << std::endl;

    // Receive and display the response from the server
    char buffer[1024];
    ssize_t bytesReceived = recv(clientSocket, buffer, sizeof(buffer), 0);
    if (bytesReceived == -1) {
        std::cout << "Failed to receive response" << std::endl;
    } else {
        buffer[bytesReceived] = '\0'; // Null-terminate the received data
        std::cout << "Received from server: " << buffer << std::endl;
    }

    close(clientSocket);
    return 0;
}
