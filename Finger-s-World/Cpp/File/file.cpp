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
    QString text = in.readAll();

    /// 检测中文字符
    for(int i = 0; i < text.size(); i++) {
        QChar ch = text.at(i);
        ushort uNum = ch.unicode();
        if((uNum >= 0x4E00 && uNum <= 0x9FA5) ||
            QString(ch) == "？" ||
            QString(ch) == "、" ||
            QString(ch) == "》" ||
            QString(ch) == "《" ||
            QString(ch) == "。" ||
            QString(ch) == "，" ||
            QString(ch) == "】" ||
            QString(ch) == "【" ||
            QString(ch) == "—"  ||
            QString(ch) == "——" )
            return QString();
    }

    file.close();

    return text;
}

