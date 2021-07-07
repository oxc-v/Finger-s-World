import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import "../../Components/Buttons"

Item {
    id: smTimeSelectionItem
    implicitHeight: 480
    implicitWidth: 420
    y: Screen.height
    x: Screen.width / 2.0 - width / 2.0

    property StackView view

    property int testTime: 0

    signal goGameModeSelectView

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Image {
            id: image
            Layout.fillWidth: true
            height: parent.height / 6.0
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/Images/GameTitle/title5.png"
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
                anchors.fill: parent
                spacing: 35
                anchors.margins: 20

                /// 难度选择
                Text {
                    Layout.fillWidth: true
                    text: qsTr("时间")
                    color: "#ff9d20"
                    font.pointSize: 18
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    GameRadioButton {
                        id: one
                        text: qsTr("1:00")
                        font.pointSize: 20
                    }
                    GameRadioButton {
                        id: three
                        text: qsTr("3:00")
                        font.pointSize: 20
                    }
                    GameRadioButton {
                        id: five
                        text: qsTr("5:00")
                        font.pointSize: 20
                    }
                }

                /// 按钮
                RowLayout {
                    spacing: 60
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    GameButton {
                        height: 60
                        width: 130
                        radius: 30
                        text: qsTr("返回")
                        onPressed: {
                            smTimeSelectionItem.goGameModeSelectView()
                            smTimeSelectionItem.destroy()
                        }
                    }
                    GameButton {
                        height: 60
                        width: 130
                        radius: 30
                        text: qsTr("开始")
                        onPressed: view.push(smTimeSelectionView)
                    }
                }
            }
        }
    }

    /// 测速模式主界面
    Component {
        id: smTimeSelectionView
        SMMainView {
            testTime: smTimeSelectionItem.testTime
            view: smTimeSelectionItem.view
        }
    }

    /// 设置一次只能有一个按钮被选
    ButtonGroup {
        id: letter
        buttons: [
            one.rabtn,
            three.rabtn,
            five.rabtn
        ]
        checkedButton: one.rabtn

        onCheckedButtonChanged: {
            switch (checkedButton) {
                case one.rabtn:
                    smTimeSelectionItem.testTime = 60
                    break
                case three.rabtn:
                    smTimeSelectionItem.testTime = 180
                    break
                case five.rabtn:
                    smTimeSelectionItem.testTime = 300
                    break
                default:
                    break
            }
        }
    }

    /// 对话框的出场效果
    NumberAnimation on y {
        to: Screen.height / 2.0 - smTimeSelectionItem.height / 2.0
        easing.type: Easing.OutCubic
        duration: 600
    }

    /// 对话框摇摆效果
    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        RotationAnimation {
            target: smTimeSelectionItem
            to: 1
            duration: 1300
        }
        RotationAnimation {
            target: smTimeSelectionItem
            to: -1
            duration: 1300
        }
    }
}
