#include "modeldatasetselectionbackend.h"
#include <iostream>

ModelDatasetSelectionBackend::ModelDatasetSelectionBackend(QObject *parent) :
    QObject(parent)
{
}

bool ModelDatasetSelectionBackend::ready()
{
    return m_ready;
}

QString ModelDatasetSelectionBackend::test() {
    return m_test;
}


void ModelDatasetSelectionBackend::setReady(const bool &ready)
{
    std::cout << ready << std::endl;
    if (ready == m_ready)
        return;

    m_ready = ready;
    emit readyChanged();
}

void ModelDatasetSelectionBackend::setTest(const QString &test)
{
    if (test == m_test)
        return;

    m_test = test;
    emit testChanged();
}

void ModelDatasetSelectionBackend::doStuff(const QString &stuff) {
    std::cout << stuff.toStdString() << std::endl;
}
