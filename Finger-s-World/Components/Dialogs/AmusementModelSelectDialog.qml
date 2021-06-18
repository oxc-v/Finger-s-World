// 娱乐模式选择对话框

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../Components/Buttons"
import "../../Views"

Item {
    id: dialog
    implicitHeight: 600
    implicitWidth: 550
    y: Screen.height
    x: Screen.width / 2.0 - width / 2.0

    /// 导航View
    property StackView view

    /// 游戏难度、单词类型
    property var factors: ["easy", "medium", "difficulty", "devil"]
    property var word_types: ["top", "medium", "buttom", "number", "all"]
    property string factor: factors[0]
    property string word_type: word_types[1]

    signal goGameModelView

    ColumnLayout {
        anchors.fill: parent

        Image {
            id: image
            Layout.fillWidth: true
            height: parent.height / 6.0
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/Images/GameTitle/title2.png"
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
                    text: qsTr("难度")
                    color: "#ff9d20"
                    font.pointSize: 18
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: true
                    GameRadioButton { id: devil; text: qsTr("魔鬼") }
                    GameRadioButton { id: difficulty; text: qsTr("困难") }
                    GameRadioButton { id: medium; text: qsTr("中等") }
                    GameRadioButton { id: easy; text: qsTr("容易") }
                }

                /// 字母选择
                Text {
                    Layout.fillWidth: true
                    text: qsTr("字母列表")
                    font.pointSize: 18
                    color: "#ff9d20"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                GridLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    height: 300
                    columns: 2
                    rows: 3
                    rowSpacing: 40
                    columnSpacing: 80
                    GameRadioButton { id: topRow; text: qsTr("顶部排") }
                    GameRadioButton { id: numbers; text: qsTr("数字") }
                    GameRadioButton { id: homeRow; text: qsTr("中间排") }
                    GameRadioButton { id: allLetters; text: qsTr("所有字母") }
                    GameRadioButton { id: buttomRow; text: qsTr("底部排") }
                }

                /// 按钮
                RowLayout {
                    spacing: 20
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    GameButton {
                        text: qsTr("返回")
                        onPressed: {
                            dialog.goGameModelView()
                            dialog.destroy()
                        }
                    }
                    GameButton {
                        text: qsTr("开始")
                        onPressed: view.push(game_amusement_view)
                    }
                }
            }
        }
    }

    /// 娱乐模式界面
    Component {
        id: game_amusement_view
        GameAmusementView {
            view: dialog.view
            factor: dialog.factor
            word_type: dialog.word_type
        }
    }

//    /// 设置一次只能有一个按钮被选
    ButtonGroup {
        id: letter
        buttons: [
            topRow.rabtn,
            homeRow.rabtn,
            buttomRow.rabtn,
            allLetters.rabtn,
            numbers.rabtn
        ]
        checkedButton: homeRow.rabtn

        onCheckedButtonChanged: {
            switch (checkedButton) {
                case topRow.rabtn:
                    word_type = word_types[0]
                    break
                case homeRow.rabtn:
                    word_type = word_types[1]
                    break
                case buttomRow.rabtn:
                    word_type = word_types[2]
                    break
                case numbers.rabtn:
                    word_type = word_types[3]
                    break
                case allLetters.rabtn:
                    word_type = word_types[4]
                    break
                default:
                    break
            }
        }
    }
    ButtonGroup {
        id: challenge
        buttons: [
            devil.rabtn,
            difficulty.rabtn,
            medium.rabtn,
            easy.rabtn
        ]
        checkedButton: easy.rabtn

        onCheckedButtonChanged: {
            switch (checkedButton) {
                case easy.rabtn:
                    factor = factors[0]
                    break
                case medium.rabtn:
                    factor = factors[1]
                    break
                case difficulty.rabtn:
                    factor = factors[2]
                    break
                case devil.rabtn:
                    factor = factors[3]
                    break
                default:
                    break
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
