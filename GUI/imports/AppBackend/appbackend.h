#ifndef APPBACKEND_H
#define APPBACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>

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
    Q_INVOKABLE void sendAIConfigurations(const QString regressionName, const double learningRate, const int depth, const int n_estimators, const QString target, const QStringList droppedFeatures, const QString specificType, const QString dataSet) {
    Q_INVOKABLE void runInference(const QString url);

signals:
    void readyChanged();
    void testChanged();

private:
    bool m_ready;
    QString m_test;
};

#endif // APPBACKEND_H
