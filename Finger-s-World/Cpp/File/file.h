#ifndef FILE_H
#define FILE_H

#include <QFile>
#include <QTextStream>
#include <QUrl>

class File : public QObject
{
    Q_OBJECT

public:
    explicit File(QObject *parent = nullptr);
    Q_INVOKABLE QString load(QUrl path);
};

#endif // FILE_H
