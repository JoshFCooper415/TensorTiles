#include "socket_client.h"
#include <sstream>
#include <fstream>
#include <iomanip>

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

// Function to create and send a ServerCommand JSON
void sendServerCommand(
    const std::string& command,
    const std::string& parameters
) {
    std::stringstream commandJson;
    commandJson << "{";
    commandJson << "\"command\": \"" << command << "\",";
    commandJson << "\"parameters\": " << parameters;
    commandJson << "}";

    std::string validJSONString =
        "{"
        "\"schemaType\": \"ServerCommand\","
        "\"JSON_data\": " + commandJson.str() +
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

std::string readImageFile(const std::string& imagePath) {
    std::ifstream imageFile(imagePath, std::ios::binary);
    if (!imageFile) {
        std::cerr << "Error: Could not open image file" << std::endl;
        return "";
    }

    // Read the image file into a string buffer
    std::string imageBuffer((std::istreambuf_iterator<char>(imageFile)), std::istreambuf_iterator<char>());
    return imageBuffer;
}

void sendImageToServer(const std::string& imagePath) {
    // Read the image file as binary data
    std::string imageBuffer = readImageFile(imagePath);

    if (imageBuffer.empty()) {
        return; // Handle the error as needed
    }

    // Encode the image data as base64
    std::string base64ImageData = base64Encode(imageBuffer);

    // Construct your JSON data including the image
    std::string jsonData =
        "{"
        "\"schemaType\": \"Image\","
        "\"image\": {"
        "\"format\": \"JPEG\","
        "\"data\": \"" + base64ImageData + "\""
        "}"
        "}";

    // Send the JSON data to the server
    sendValidJSONToServer(jsonData);
}

std::string base64Encode(const std::string& data) {
    static const std::string base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::string encoded;
    int i = 0;
    int j = 0;
    uint8_t char_array_3[3];
    uint8_t char_array_4[4];

    for (char c : data) {
        char_array_3[i++] = static_cast<uint8_t>(c);
        if (i == 3) {
            char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
            char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
            char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
            char_array_4[3] = char_array_3[2] & 0x3f;

            for (i = 0; i < 4; i++) {
                encoded += base64_chars[char_array_4[i]];
            }
            i = 0;
        }
    }

    if (i > 0) {
        for (j = i; j < 3; j++) {
            char_array_3[j] = 0;
        }

        char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
        char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
        char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);

        for (j = 0; j < i + 1; j++) {
            encoded += base64_chars[char_array_4[j]];
        }

        while (i++ < 3) {
            encoded += '=';
        }
    }

    return encoded;
}



int main() {
    // Call the functions to send different schema types to the server
    sendMLModelSchema(64, 128, 3, true, 0.2, 0.001, 100);
    std::vector<std::string> droppedFeatures = {"feature1", "feature2"};
    sendAIConfigurationsSchema("Regression", 0.001, 10, 100, "output", droppedFeatures, "random forest", "data set");
    sendServerCommand("train_ml_model", "{\"model_type\": \"CNN\", \"epochs\": 10, \"learning_rate\": 0.001}");

    return 0;
}
