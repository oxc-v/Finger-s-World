import QtQuick

Item {
    id: btn
    height: 80
    width: 200

    property alias text: txt.text
    property alias font: txt.font
    signal pressed

    Rectangle {
        anchors.fill: parent
        radius: parent.height / 2.0
        color: mouseHover.hovered ? "#ff9d20" : "#23bf76"

        Text {
            id: txt
            anchors.fill: parent
            font.pointSize: 15
            font.bold: true

            color: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        HoverHandler { id: mouseHover }
        TapHandler { onTapped: btn.pressed() }
    }
}
