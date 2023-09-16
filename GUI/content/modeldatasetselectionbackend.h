#ifndef MODELDATASETSELECTIONBACKEND_H
#define MODELDATASETSELECTIONBACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>

class ModelDatasetSelectionBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool ready READ ready WRITE setReady NOTIFY readyChanged)
    Q_PROPERTY(QString test READ test WRITE setTest NOTIFY testChanged)
    QML_ELEMENT

public:
    explicit ModelDatasetSelectionBackend(QObject *parent = nullptr);

    bool ready();
    QString test();
    void setReady(const bool &ready);
    void setTest(const QString &test);
    Q_INVOKABLE void doStuff(const QString &model, const QString &dataset);

signals:
    void readyChanged();
    void testChanged();

private:
    bool m_ready;
    QString m_test;
};

#endif // MODELDATASETSELECTIONBACKEND_H
