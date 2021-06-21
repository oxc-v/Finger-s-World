// 娱乐模式的分数显示框

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    implicitHeight: 150
    implicitWidth: 200
    y: -height

    property alias pause_btn: pause_btn
    property alias score: bingo_word.text
    property int heart_number: hearts.length
    property var hearts: [heart_1, heart_2, heart_3, heart_4, heart_5]

    /// 隐藏心形图片
    function destroyHeart()
    {
        if (heart_number !== 0) {
            heart_number--
            hearts[heart_number].state = "hide"
        }
    }

    /// 显示心形图片
    function displayHeart()
    {
        for (let i in hearts)
            hearts[i].state = "show"
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: "#cfeffc"
        opacity: 0.8
        border.width: 5
        border.color: "#23bf76"
        radius: 10

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            /// 显示答对的单词数
            RowLayout {
                spacing: 30
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
                Label {
                    text: qsTr("单词")
                    font.bold: true
                    font.pointSize: 20
                    color: "#23bf76"
                }
                Label {
                    id: bingo_word
                    font.bold: true
                    font.pointSize: 25
                    color: "#ff9d20"
                }
            }

            /// 心形图案，表示可失败数
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter
                Image {
                    id: heart_1
                    source: "qrc:/Images/Heart/heart.png"
                    state: "show"
                    states: [
                        State {
                            name: "hide"
                            PropertyChanges { target: heart_1; scale: 0 }
                        },
                        State {
                            name: "show"
                            PropertyChanges { target: heart_1; scale: 1 }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "show"
                            to: "hide"
                            NumberAnimation {
                                target: heart_1
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        },
                        Transition {
                            from: "hide"
                            to: "show"
                            NumberAnimation {
                                target: heart_1
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        }
                    ]
                }
                Image {
                    id: heart_2
                    source: "qrc:/Images/Heart/heart.png"
                    state: "show"
                    states: [
                        State {
                            name: "hide"
                            PropertyChanges { target: heart_2; scale: 0 }
                        },
                        State {
                            name: "show"
                            PropertyChanges { target: heart_2; scale: 1 }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "show"
                            to: "hide"
                            NumberAnimation {
                                target: heart_2
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        },
                        Transition {
                            from: "hide"
                            to: "show"
                            NumberAnimation {
                                target: heart_2
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        }
                    ]
                }
                Image {
                    id: heart_3
                    source: "qrc:/Images/Heart/heart.png"
                    state: "show"
                    states: [
                        State {
                            name: "hide"
                            PropertyChanges { target: heart_3; scale: 0 }
                        },
                        State {
                            name: "show"
                            PropertyChanges { target: heart_3; scale: 1 }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "show"
                            to: "hide"
                            NumberAnimation {
                                target: heart_3
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        },
                        Transition {
                            from: "hide"
                            to: "show"
                            NumberAnimation {
                                target: heart_3
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        }
                    ]
                }
                Image {
                    id: heart_4
                    source: "qrc:/Images/Heart/heart.png"
                    state: "show"
                    states: [
                        State {
                            name: "hide"
                            PropertyChanges { target: heart_4; scale: 0 }
                        },
                        State {
                            name: "show"
                            PropertyChanges { target: heart_4; scale: 1 }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "show"
                            to: "hide"
                            NumberAnimation {
                                target: heart_4
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        },
                        Transition {
                            from: "hide"
                            to: "show"
                            NumberAnimation {
                                target: heart_4
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        }
                    ]
                }
                Image {
                    id: heart_5
                    source: "qrc:/Images/Heart/heart.png"
                    state: "show"
                    states: [
                        State {
                            name: "hide"
                            PropertyChanges { target: heart_5; scale: 0 }
                        },
                        State {
                            name: "show"
                            PropertyChanges { target: heart_5; scale: 1 }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "show"
                            to: "hide"
                            NumberAnimation {
                                target: heart_5
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        },
                        Transition {
                            from: "hide"
                            to: "show"
                            NumberAnimation {
                                target: heart_5
                                property: "scale"
                                duration: 300
                                easing.type: Easing.InOutBack
                            }
                        }
                    ]
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                Layout.margins: 5
                Button {
                    id: pause_btn
                    background: Rectangle {opacity: 0}
                    icon.source: "qrc:/Images/Icon/stop.png"
                    icon.color: btn_hover.hovered ? "#23bf76" : "red"
                    icon.height: 40
                    icon.width: 40
                    scale: btn_hover.hovered ? 1.3 : 1

                    HoverHandler {id: btn_hover}
                }
            }
        }
    }

    /// 对话框下落特效
    NumberAnimation on y {
        to: 50
        duration: 1000
        easing.type: Easing.InOutBack
    }
}
