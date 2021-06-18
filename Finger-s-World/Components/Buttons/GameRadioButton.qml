// 游戏单选框

import QtQuick
import QtQuick.Controls

Item {
    implicitHeight: 20
    implicitWidth: 100

    property alias checked: control.checked
    property alias text: control.text
    property alias rabtn: control

    RadioButton {
        id: control
        anchors.fill: parent
        indicator: Rectangle {
            implicitWidth: 30
            implicitHeight: 30
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            radius: 15
            color: "transparent"
            border.width: 2
            border.color: control.down ? "#17a81a" : "#21be2b"

            Rectangle {
                width: 20
                height: 20
                anchors.centerIn: parent
                radius: 10
                color: control.down ? "#17a81a" : "#21be2b"
                visible: control.checked
            }
        }

        contentItem: Text {
            anchors.centerIn: parent
            text: control.text
            font.pointSize: 12
            font.bold: true
            color: control.down ? "#17a81a" : "#21be2b"
            verticalAlignment: Text.AlignVCenter
            leftPadding: control.indicator.width + control.spacing
        }
    }
}
