#ifndef SOCKET_CLIENT_H
#define SOCKET_CLIENT_H

#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <vector>
#include <cstdlib>

bool connectToServer(const std::string& serverAddress, int port);
void sendJSONMessage(const char* messageJson);
std::string receiveServerResponse();
void disconnectFromServer();
void sendValidJSONToServer(const std::string& validJSONString);
void sendMLModelSchema(
    int in_channels, int out_channels, int kernel_size,
    bool use_bn, double dropout_rate,
    double learning_rate, int num_epochs
    );
void sendAIConfigurationsSchema(
    const std::string& argType,
    double learning_rate, int depth, int n_estimators,
    const std::string& target, const std::vector<std::string>& droppedFeatures,
    const std::string& specificType,
    const std::string& dataSet
    );
void sendServerCommand(
    const std::string& command,
    const std::string& parameters
    );
int main();
std::string base64Encode(const std::string &data);
#endif // SOCKET_CLIENT_H
