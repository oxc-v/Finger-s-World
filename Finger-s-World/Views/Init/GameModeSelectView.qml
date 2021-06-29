// 游戏模式选择框

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Window 2.15

import "../../Components/Buttons"
import "../TeachingMode"
import "../PracticeMode"

Item {
    id: dialog
    implicitHeight: 620
    implicitWidth: 470
    y: -Screen.height
    x: Screen.width / 2.0 - width / 2.0

    property Window window
    property StackView view

    signal goEMPlayMethodView(string viewUrl)
    signal goSMTimeSelectionView(string viewUrl)

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

                GameButton {
                    text: qsTr("新手教学")
                    onPressed: view.push(tmMainView)
                }
                GameButton {
                    text: qsTr("练习模式")
                    onPressed: view.push(pmMainView)
                }
                GameButton {
                    text: qsTr("娱乐模式")
                    onPressed: {
                        dialog.goEMPlayMethodView("qrc:/Views/EntertainmentMode/EMPlayMethodView.qml")
                        dialog.destroy()
                    }
                }
                GameButton {
                    text: qsTr("测速模式")
                    onPressed: {
                        dialog.goSMTimeSelectionView("qrc:/Views/SpeedMode/SMTimeSelectionView.qml")
                        dialog.destroy()
                    }
                }
                GameButton {
                    text: qsTr("退出游戏")
                    onPressed: window.close()
                }
            }
        }
    }

    /// 新手教学页面
    Component {
        id: tmMainView
        TMMainView {
            view: dialog.view
        }
    }

    /// 练习模式页面
    Component {
        id: pmMainView
        PMMainView {
            view: dialog.view
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
