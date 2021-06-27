import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3 as QQD
import QtQuick.Window 2.15

import "../../Components/Buttons"

Item {
    id: pmDialogs
    property StackView view

    property alias fileDialog: file

    property alias finishTime: time.text
    property alias finishNumber: number.text
    property alias finishAccuracy: accuracy.text

    function openFileDialog() { file.open() }
    function openFinishDialog() { finish.open() }

    signal againPratice

    /// 文件对话框
    QQD.FileDialog {
        id: file
        title: "选择文件"
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        nameFilters: [ "文本文件 (*.txt)", "所有文件 (*.*)" ]
    }

    /// 练字结束对话框
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
                    text: qsTr("时间")
                    font {
                        letterSpacing: 5
                        pixelSize: 25
                    }
                    color: "#99caed"
                }
                Label {
                    id: time
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
                    text: qsTr("单词")
                    font {
                        letterSpacing: 5
                        pixelSize: 25
                    }
                    color: "#99caed"
                }
                Label {
                    id: number
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
                text: qsTr("继续练习")
                font {
                    pointSize: 12
                }

                onPressed: {
                    pmDialogs.againPratice()
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
