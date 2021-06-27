import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Window 2.15

import "../../Components/Buttons"

Item {
    id: item

    property StackView view

    property alias score_txt: score_txt.text
    property alias time_txt: time_txt.text

    signal continueGame
    signal againGame

    function openEndDialog() { end.open() }

    /// 游戏结束对话框
    Dialog {
        id: end
        implicitHeight: 400
        implicitWidth: 300
        x: Screen.width / 2 - end.width / 2
        y: Screen.height
        modal: true
        closePolicy: Popup.NoAutoClose
        background: Rectangle { opacity: 0 }

        enter: Transition {
            NumberAnimation {
                property: "y"
                to: Screen.height / 2 - 400 / 2
                easing.type: Easing.InOutBack
                duration: 600
            }
        }

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
    }
}
