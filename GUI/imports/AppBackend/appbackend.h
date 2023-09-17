#ifndef APPBACKEND_H
#define APPBACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>

#include "socket_client.h"

class AppBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool ready READ ready WRITE setReady NOTIFY readyChanged)
    Q_PROPERTY(QString test READ test WRITE setTest NOTIFY testChanged)
    QML_ELEMENT

public:
    explicit AppBackend(QObject *parent = nullptr);

    bool ready();
    QString test();
    void setReady(const bool &ready);
    void setTest(const QString &test);
    Q_INVOKABLE void doStuff(const QString data, const QString model, const QString dataset, const int noEpochs, const double learningRate);

signals:
    void readyChanged();
    void testChanged();

private:
    bool m_ready;
    QString m_test;
};

#endif // APPBACKEND_H
