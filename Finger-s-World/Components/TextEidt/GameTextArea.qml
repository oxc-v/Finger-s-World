import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    border.width: 2
    border.color: "#99caed"
    radius: 10

    property alias textEdit: textEdit

    Flickable {
        id: flick
        anchors.fill: parent
        anchors.margins: 10
        contentWidth: parent.width
        contentHeight: parent.height
        clip: true

        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX + width <= r.x+r.width)
                contentX = r.x + r.width - width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY + height <= r.y + r.height)
                contentY = r.y + r.height - height;
        }

        TextEdit {
            id: textEdit
            width: flick.width
            font.letterSpacing: 4
            font.wordSpacing: 5
            font.pointSize: 30
            readOnly: true
            cursorVisible: text.length === 0 ? false : true
            clip: true
            selectionColor: "#23bf76"
            wrapMode: TextEdit.WordWrap
            cursorDelegate: Rectangle {
                id: oxc
                height: 1
                opacity: 0.5
                width: 24
                radius: 5
                color: "#3395db"
            }

            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
        }
    }
}
