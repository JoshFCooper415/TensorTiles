#include "appbackend.h"
#include "socket_client.h"
#include <sstream>

AppBackend::AppBackend(QObject *parent) :
    QObject(parent)
{
}

bool AppBackend::ready()
{
    return m_ready;
}

QString AppBackend::test() {
    return m_test;
}


void AppBackend::setReady(const bool &ready)
{
    std::cout << ready << std::endl;
    if (ready == m_ready)
        return;

    m_ready = ready;
    emit readyChanged();
}

void AppBackend::setTest(const QString &test)
{
    if (test == m_test)
        return;

    m_test = test;
    emit testChanged();
}

void AppBackend::doStuff(const QString data, const QString model, const QString dataset, const int noEpochs, const double learningRate) {
    setReady(false);
    std::string input = data.toStdString();

    // Initialize a vector of vectors to store the 2D array.
    std::vector<std::vector<double>> array2D;

    // Create a string stream to parse the input string.
    std::istringstream ss(input);

    // Split the input string by semicolon to get rows.
    std::string row;
    while (std::getline(ss, row, ';')) {
        std::vector<double> rowValues;
        std::istringstream rowStream(row);
        std::string element;

        // Split the row by comma to get individual elements.
        while (std::getline(rowStream, element, ',')) {
            // Parse the element and add it to the row vector.
            double value;
            std::istringstream(element) >> value;
            rowValues.push_back(value);
        }

        // Add the row to the 2D array.
        array2D.push_back(rowValues);
    }

    // Now, you have the 2D array in the vector of vectors 'array2D'.

    // Printing the 2D array for verification.
    for (const std::vector<double>& row : array2D) {
        for (double value : row) {
            std::cout << value << ' ';
        }
        std::cout << '\n';
    }

    std::string dset = dataset.toStdString();
    int in_channels[array2D.size()];
    in_channels[0] = 3;
    int out_channels[array2D.size()];
    bool use_bns[array2D.size()];
    int kernel_sizes[array2D.size()];
    double dropout_rates[array2D.size()];
    for (int i = 0; i < array2D.size(); i++) {
        std::vector<double> row = array2D.at(i);
        if (i > 0) {
            in_channels[i] = out_channels[i-1];
        }
        if (i < array2D.size()-1) {
            out_channels[i] = row.at(0);
        }
        use_bns[i] = true;
        kernel_sizes[i] = row.at(1);
        dropout_rates[i] = row.at(2);
    }
    out_channels[array2D.size()-1] = 32;
    sendMLModelSchema(in_channels, out_channels, kernel_sizes, use_bns, dropout_rates, learningRate, noEpochs, dset, (int)array2D.size());
    sendServerCommand("start-training", "{}");
}
