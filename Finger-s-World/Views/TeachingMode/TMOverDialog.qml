import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls

Item {
    id: item

    function openTMOverDialog() { dialog.open() }

    property StackView view

    signal initTMMainView

    Dialog {
        id: dialog
        width: 300
        height: 250
        y: Screen.height
        x: Screen.width / 2.0 - dialog.width / 2.0
        modal: true
        focus: true

        background: Rectangle {
            color: "#ffffff"
            radius: 10
            border.width: 3
            border.color: "#99caed"
        }

        header: Label {
            height: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("完成新手教学任务")
            color: "#23bf76"
            font {
                letterSpacing: 5
                pointSize: 15
                bold: true
            }
        }

        contentItem: Rectangle {
            height: 100
            Text {
                id: txt
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("想必你已经初步掌握打字的要领，快去试试其他玩法，提高自己的打字速度！")
                font {
                    letterSpacing: 5
                    pointSize: 13
                    bold: true
                }
                color: "#3395db"
                wrapMode: Text.WrapAnywhere
            }
        }

        footer: RowLayout {
            height: 100
            Button {
                id: btn
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 90
                Layout.preferredHeight: 60
                background: Rectangle { color: hover.hovered ? "#3395db" : "#23bf76"; radius: 5 }

                Label {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("返回菜单")
                    color: "#ffffff"
                    font {
                        pointSize: 12
                        bold: true
                    }
                }

                HoverHandler {id: hover}
                onPressed: view.pop()
            }
            Button {
                id: btn2
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 90
                Layout.preferredHeight: 60
                background: Rectangle { color: hover2.hovered ? "#3395db" : "#23bf76"; radius: 5 }

                Label {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("再来一遍")
                    color: "#ffffff"
                    font {
                        pointSize: 12
                        bold: true
                    }
                }

                HoverHandler {id: hover2}
                onPressed: {
                    dialog.close()
                    item.initTMMainView()

                }
            }
        }

        enter: Transition {
            NumberAnimation {
                properties: "y"
                to: Screen.height / 2.0 - dialog.height / 2.0
                easing.type: Easing.OutCubic
                duration: 500
            }
        }

        exit: Transition {
            NumberAnimation {
                properties: "y"
                to: Screen.height
                easing.type: Easing.OutCubic
                duration: 500
            }
        }

        closePolicy: Popup.NoAutoClose
    }
}
