import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../Components/Buttons"

Item {
    id: smDialogs
    property StackView view
    property alias finishCorrectNumbers: correctNumbers.text
    property alias finishErrorNumbers: errorNumbers.text
    property alias finishAccuracy: accuracy.text
    property alias finishDialog: finish

    signal againTest

    function openFinishDialog() { finish.open() }

    /// 测速结束对话框
    Dialog {
        id: finish
        width: 350
        height: 350
        y: Screen.height
        x: Screen.width / 2 - width / 2
        modal: true
        focus: true

        background: Rectangle {
            color: "#ffffff"
            radius: 10
            border.width: 3
            border.color: "#99caed"
        }

        contentItem: ColumnLayout {
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                Label {
                    text: qsTr("正确单词")
                    font {
                        letterSpacing: 5
                        pixelSize: 25
                    }
                    color: "#99caed"
                }
                Label {
                    id: correctNumbers
                    font {
                        letterSpacing: 5
                        pixelSize: 35
                    }
                    color: "#3395db"
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                Label {
                    text: qsTr("错误单词")
                    font {
                        letterSpacing: 5
                        pixelSize: 25
                    }
                    color: "#99caed"
                }
                Label {
                    id: errorNumbers
                    font {
                        letterSpacing: 5
                        pixelSize: 35
                    }
                    color: "#3395db"
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                Label {
                    text: qsTr("正确率")
                    font {
                        letterSpacing: 5
                        pixelSize: 25
                    }
                    color: "#99caed"
                }
                Label {
                    id: accuracy
                    font {
                        letterSpacing: 5
                        pixelSize: 35
                    }
                    color: "#3395db"
                }
            }
        }

        footer: RowLayout {
            height: 100
            GameButton {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 100
                Layout.preferredHeight: 55
                color: hovered ? "#3395db" : "#23bf76"
                radius: 5
                text: qsTr("返回菜单")
                font {
                    pointSize: 12
                }

                onPressed: view.pop()
            }
            GameButton {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 100
                Layout.preferredHeight: 55
                color: hovered ? "#3395db" : "#23bf76"
                radius: 5
                text: qsTr("重新测试")
                font {
                    pointSize: 12
                }

                onPressed: {
                    smDialogs.againTest()
                    finish.close()
                }
            }
        }

        enter: Transition {
            NumberAnimation {
                properties: "y"
                to: Screen.height / 2.0 - finish.height / 2.0
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
