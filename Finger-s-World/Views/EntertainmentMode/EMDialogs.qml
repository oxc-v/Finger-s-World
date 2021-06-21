import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../Components/Buttons"

Item {
    id: item

    property StackView view

    property alias score_txt: score_txt.text
    property alias time_txt: time_txt.text

    signal continueGame
    signal againGame

    function openPauseDialog() { pause.open() }
    function openEndDialog() { end.open(); end_an.start() }

    /// 游戏暂停对话框
    Dialog {
        id: pause
        height: 250
        width: 300
        x: Screen.width / 2 - pause.width / 2
        y: Screen.height / 2 - pause.height / 2
        modal: true
        closePolicy: Popup.NoAutoClose

        background: Rectangle { opacity: 0 }

        ColumnLayout {
            anchors.fill: parent
            Image {
                Layout.fillWidth: true
                height: 60
                source: "qrc:/Images/GameTitle/title3.png"
            }
            Rectangle {
                Layout.fillWidth: true
                height: 100
                radius: 10
                color: "#cfeffc"
                opacity: 0.9
                border.width: 3
                border.color: "#34c483"

                RowLayout {
                    anchors.centerIn: parent
                    spacing: 30
                    GameButton {
                        height: 50
                        width: 100
                        text: "返回菜单"
                        font.pointSize: 10
                        onPressed: view.pop()
                    }
                    GameButton {
                        id: continue_btn
                        height: 50
                        width: 100
                        text: "继续游戏"
                        font.pointSize: 10
                        onPressed: {
                            item.continueGame()
                            pause.close()
                        }
                    }
                }
            }
        }
    }

    /// 游戏结束对话框
    Dialog {
        id: end
        x: Screen.width / 2 - end.width / 2
        height: 400
        width: 300
        modal: true
        closePolicy: Popup.NoAutoClose
        background: Rectangle { opacity: 0 }

        ColumnLayout {
            anchors.fill: parent
            spacing: 20
            Image {
                Layout.fillWidth: true
                height: 60
                source: "qrc:/Images/GameTitle/title4.png"
            }
            Rectangle {
                Layout.fillWidth: true
                height: 300
                radius: 10
                color: "#cfeffc"
                opacity: 0.9
                border.width: 3
                border.color: "#34c483"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10
                    RowLayout {
                        Layout.alignment: Qt.AlignCenter
                        Layout.fillWidth: true
                        spacing: 50
                        Label {
                            text: qsTr("时间")
                            color: "#34c484"
                            font.pointSize: 25
                        }
                        Label {
                            id: time_txt
                            font.pointSize: 25
                            color: "#ffffff"
                        }
                    }
                    RowLayout {
                        Layout.alignment: Qt.AlignCenter
                        Layout.fillWidth: true
                        spacing: 50
                        Label {
                            text: qsTr("单词")
                            color: "#34c484"
                            font.pointSize: 25
                        }
                        Label {
                            id: score_txt
                            font.pointSize: 25
                            color: "#ffffff"
                        }
                    }
                    RowLayout {
                        Layout.alignment: Qt.AlignCenter
                        Layout.fillWidth: true
                        spacing: 30
                        GameButton {
                            height: 50
                            width: 100
                            text: "不玩儿了"
                            font.pointSize: 10
                            onPressed: view.pop()
                        }
                        GameButton {
                            id: again_btn
                            height: 50
                            width: 100
                            text: "再来一局"
                            font.pointSize: 10
                            onPressed: {
                                item.againGame()
                                end.close()
                            }
                        }
                    }
                }
            }
        }

        /// 对话框的出场效果
        ParallelAnimation {
            id: end_an
            PropertyAction { target: end; property: "y"; value: -end.height}
            NumberAnimation {
                target: end
                property: "y"
                to: Screen.height / 2.0 - end.height / 2.0
                easing.type: Easing.InOutBack
                duration: 800
            }
        }
    }
}
