#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <vector>
#include <cstdlib>

int clientSocket; // Declare a global client socket for connection

// Function to connect to the server
bool connectToServer(const std::string& serverAddress, int port) {
    struct sockaddr_in serverAddr;

    // Create a socket
    clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (clientSocket == -1) {
        std::cerr << "Error: Could not create socket" << std::endl;
        return false;
    }

    // Configure server address
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);
    serverAddr.sin_addr.s_addr = inet_addr(serverAddress.c_str());

    // Connect to the server
    if (connect(clientSocket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) == -1) {
        std::cerr << "Error: Could not connect to server" << std::endl;
        return false;
    }

    std::cout << "Connected to server." << std::endl;
    return true;
}

// Function to send JSON message to the server
void sendJSONMessage(const char* messageJson) {
    send(clientSocket, messageJson, strlen(messageJson), 0);
}

// Function to receive and handle the server's response
std::string receiveServerResponse() {
    char buffer[1024];
    memset(buffer, 0, sizeof(buffer));
    
    // Receive the server's response
    int bytesRead = recv(clientSocket, buffer, sizeof(buffer), 0);
    if (bytesRead <= 0) {
        std::cerr << "Error: Failed to receive server response" << std::endl;
        return "";
    }
    
    // Handle the server's response here (e.g., print it)
    std::cout << "Server response: " << buffer << std::endl;
    return buffer;
}

// Function to disconnect from the server
void disconnectFromServer() {
    const char* disconnectMessage = "{\"action\": \"disconnect\"}";
    sendJSONMessage(disconnectMessage);
    close(clientSocket);
    std::cout << "Disconnected from server." << std::endl;
}

// Function to send validJSON to the server
void sendValidJSONToServer(const std::string& validJSONString) {
    // Convert the C++ string to a C-style string
    const char* validJSON_cstr = validJSONString.c_str();

    // Send the validJSON message to the server using sendJSONMessage function
    if (connectToServer("127.0.0.1", 8080)) {
        sendJSONMessage(validJSON_cstr);
        receiveServerResponse(); 
        
        // Call the function to disconnect from the server
        disconnectFromServer();
    }
}

// Function to configure and send MLModel schema
void sendMLModelSchema(
    int in_channels, int out_channels, int kernel_size,
    bool use_bn, double dropout_rate,
    double learning_rate, int num_epochs
) {
    std::string schemaType = "MLModel";
    std::string jsonData =
        "{"
        "\"layer_specs\": {"
        "\"in_channels\": " + std::to_string(in_channels) + ","
        "\"out_channels\": " + std::to_string(out_channels) + ","
        "\"kernel_size\": " + std::to_string(kernel_size) + ","
        "\"use_bn\": " + (use_bn ? "true" : "false") + ","
        "\"dropout_rate\": " + std::to_string(dropout_rate) +
        "},"
        "\"hyper_parameters\": {"
        "\"learning_rate\": " + std::to_string(learning_rate) + ","
        "\"num_epochs\": " + std::to_string(num_epochs) +
        "}"
        "}";
    
    std::string validJSONString =
        "{"
        "\"schemaType\": \"" + schemaType + "\","
        "\"JSON_data\": " + jsonData +
        "}";
    
    sendValidJSONToServer(validJSONString);
}


// Function to configure and send AIConfigurations schema
void sendAIConfigurationsSchema(
    const std::string& argType,
    double learning_rate, int depth, int n_estimators,
    const std::string& target, const std::vector<std::string>& droppedFeatures,
    const std::string& specificType,
    const std::string& dataSet
) {
    std::string schemaType = "AIConfigurations";
    std::string jsonData =
        "{"
        "\"args\": ["
        "\"" + argType + "\","
        "{"
        "\"learning_rate\": " + std::to_string(learning_rate) + ","
        "\"depth\": " + std::to_string(depth) + ","
        "\"n_estimators\": " + std::to_string(n_estimators) + ","
        "\"target\": \"" + target + "\","
        "\"dropedFeatures\": [";

    // Add dropped features to the JSON
    for (size_t i = 0; i < droppedFeatures.size(); ++i) {
        jsonData += "\"" + droppedFeatures[i] + "\"";
        if (i < droppedFeatures.size() - 1) {
            jsonData += ",";
        }
    }

    jsonData +=
        "]"
        "},"
        "\"" + specificType + "\","
        "\"" + dataSet + "\""
        "]"
        "}";

    std::string validJSONString =
        "{"
        "\"schemaType\": \"" + schemaType + "\","
        "\"JSON_data\": " + jsonData +
        "}";

    sendValidJSONToServer(validJSONString);
}

int main() {
    // Call the functions to send different schema types to the server
    sendMLModelSchema(64, 128, 3, true, 0.2, 0.001, 100);
    std::vector<std::string> droppedFeatures = {"feature1", "feature2"};
    sendAIConfigurationsSchema("Regression", 0.001, 10, 100, "output", droppedFeatures, "random forest", "data set");

    return 0;
}
