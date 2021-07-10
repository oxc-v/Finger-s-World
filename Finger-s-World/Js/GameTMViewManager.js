var urlDict = {"a" : "qrc:/Images/KeyImages/LowerCase/a.png",
               "b" : "qrc:/Images/KeyImages/LowerCase/b.png",
               "c" : "qrc:/Images/KeyImages/LowerCase/c.png",
               "d" : "qrc:/Images/KeyImages/LowerCase/d.png",
               "e" : "qrc:/Images/KeyImages/LowerCase/e.png",
               "f" : "qrc:/Images/KeyImages/LowerCase/f.png",
               "g" : "qrc:/Images/KeyImages/LowerCase/g.png",
               "h" : "qrc:/Images/KeyImages/LowerCase/h.png",
               "i" : "qrc:/Images/KeyImages/LowerCase/i.png",
               "j" : "qrc:/Images/KeyImages/LowerCase/j.png",
               "k" : "qrc:/Images/KeyImages/LowerCase/k.png",
               "l" : "qrc:/Images/KeyImages/LowerCase/l.png",
               "m" : "qrc:/Images/KeyImages/LowerCase/m.png",
               "n" : "qrc:/Images/KeyImages/LowerCase/n.png",
               "o" : "qrc:/Images/KeyImages/LowerCase/o.png",
               "p" : "qrc:/Images/KeyImages/LowerCase/p.png",
               "q" : "qrc:/Images/KeyImages/LowerCase/q.png",
               "r" : "qrc:/Images/KeyImages/LowerCase/r.png",
               "s" : "qrc:/Images/KeyImages/LowerCase/s.png",
               "t" : "qrc:/Images/KeyImages/LowerCase/t.png",
               "u" : "qrc:/Images/KeyImages/LowerCase/u.png",
               "v" : "qrc:/Images/KeyImages/LowerCase/v.png",
               "w" : "qrc:/Images/KeyImages/LowerCase/w.png",
               "x" : "qrc:/Images/KeyImages/LowerCase/x.png",
               "y" : "qrc:/Images/KeyImages/LowerCase/y.png",
               "z" : "qrc:/Images/KeyImages/LowerCase/z.png",
               "A" : "qrc:/Images/KeyImages/Capital/A.png",
               "B" : "qrc:/Images/KeyImages/Capital/B.png",
               "C" : "qrc:/Images/KeyImages/Capital/C.png",
               "D" : "qrc:/Images/KeyImages/Capital/D.png",
               "E" : "qrc:/Images/KeyImages/Capital/E.png",
               "F" : "qrc:/Images/KeyImages/Capital/F.png",
               "G" : "qrc:/Images/KeyImages/Capital/G.png",
               "H" : "qrc:/Images/KeyImages/Capital/H.png",
               "I" : "qrc:/Images/KeyImages/Capital/I.png",
               "J" : "qrc:/Images/KeyImages/Capital/J.png",
               "K" : "qrc:/Images/KeyImages/Capital/K.png",
               "L" : "qrc:/Images/KeyImages/Capital/L.png",
               "M" : "qrc:/Images/KeyImages/Capital/M.png",
               "N" : "qrc:/Images/KeyImages/Capital/N.png",
               "O" : "qrc:/Images/KeyImages/Capital/O.png",
               "P" : "qrc:/Images/KeyImages/Capital/P.png",
               "Q" : "qrc:/Images/KeyImages/Capital/Q.png",
               "R" : "qrc:/Images/KeyImages/Capital/R.png",
               "S" : "qrc:/Images/KeyImages/Capital/S.png",
               "T" : "qrc:/Images/KeyImages/Capital/T.png",
               "U" : "qrc:/Images/KeyImages/Capital/U.png",
               "V" : "qrc:/Images/KeyImages/Capital/V.png",
               "W" : "qrc:/Images/KeyImages/Capital/W.png",
               "X" : "qrc:/Images/KeyImages/Capital/X.png",
               "Y" : "qrc:/Images/KeyImages/Capital/Y.png",
               "Z" : "qrc:/Images/KeyImages/Capital/Z.png",
               ";" : "qrc:/Images/KeyImages/Other/semicolon.png",
               "'" : "qrc:/Images/KeyImages/Other/singlequotes.png",
               "," : "qrc:/Images/KeyImages/Other/comma.png",
               "." : "qrc:/Images/KeyImages/Other/period.png",
               "/" : "qrc:/Images/KeyImages/Other/slash.png",
               " " : "qrc:/Images/KeyImages/Other/space.png",
               "?" : "qrc:/Images/KeyImages/Other/question.png",
               "\n": "qrc:/Images/KeyImages/Other/enter.png"
              }

/// 根据字母获取图片URL
function getImageUrl(letter)
{
    return urlDict[letter]
}

/// 初始化View数据
function initTMMainVeiw()
{
    /// 重置索引
    tmMainview.index = 0
    textArea.textEdit.cursorPosition = 0

    /// 清空Selection
    textArea.textEdit.deselect()

    /// 捕获焦点
    tmMainview.forceActiveFocus()
}
