#include "file.h"
#include <QDebug>

File::File(QObject *parent):QObject(parent)
{

}

/// 加载文件
QString File::load(QUrl filePath)
{
    QFile file;
    if (filePath.isLocalFile())
        file.setFileName(filePath.toLocalFile());
    else
        file.setFileName(filePath.path());

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return QString();

    QTextStream in(&file);
    in.setAutoDetectUnicode(true);
    QString text = in.readAll();
    file.close();

    return text;
}
