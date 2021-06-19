// 游戏模式选择框

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../Components/Buttons"

Item {
    id: dialog
    implicitHeight: 600
    implicitWidth: 550
    y: -Screen.height
    x: Screen.width / 2.0 - width / 2.0

    property Window window
    signal goAmusementView

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: image

            Layout.fillWidth: true
            height: parent.height / 6.0
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/Images/GameTitle/title.png"
        }

        Rectangle {
            Layout.fillWidth: true
            height: parent.height - image.height
            color: "#cfeffc"
            opacity: 0.9
            border.width: 5
            border.color: "#ff9d20"
            radius: 20

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30

                GameButton { text: qsTr("练习模式")}
                GameButton {
                    text: qsTr("娱乐模式")
                    onPressed: {
                        dialog.goAmusementView()
                        dialog.destroy()
                    }
                }
                GameButton { text: qsTr("测试模式") }
                GameButton {
                    text: qsTr("退出游戏")
                    onPressed: window.close()
                }
            }
        }
    }

    /// 对话框的出场效果
    NumberAnimation on y {
        to: Screen.height / 2.0 - dialog.height / 2.0
        easing.type: Easing.OutCubic
        duration: 600
    }

    /// 对话框摇摆效果
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        RotationAnimation {
            target: dialog
            to: 1
            duration: 1300
        }
        RotationAnimation {
            target: dialog
            to: -1
            duration: 1300
        }
    }
}
