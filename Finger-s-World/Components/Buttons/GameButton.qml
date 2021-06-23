import QtQuick

Item {
    id: btn
    height: 80
    width: 200

    property alias text: txt.text
    property alias font: txt.font
    property alias radius: rec.radius
    property alias color: rec.color
    property alias hovered: mouseHover.hovered

    signal pressed

    Rectangle {
        id: rec
        anchors.fill: parent
        radius: parent.height / 2.0
        color: mouseHover.hovered ? "#849DFF" : "#23bf76"
        scale: mouseHover.hovered ? 1.1 : 1
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
