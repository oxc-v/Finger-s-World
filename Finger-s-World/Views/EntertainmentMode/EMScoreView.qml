// 娱乐模式的分数显示框

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Item {
    implicitHeight: 150
    implicitWidth: 200
    y: -height

    property alias score: bingo_word.text
    property int heart_number: hearts.length
    property var hearts: [heart_1, heart_2, heart_3, heart_4, heart_5]

    property StackView view

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

                EMHeartView { id: heart_1; source: "qrc:/Images/Heart/heart.png" }
                EMHeartView { id: heart_2; source: "qrc:/Images/Heart/heart.png" }
                EMHeartView { id: heart_3; source: "qrc:/Images/Heart/heart.png" }
                EMHeartView { id: heart_4; source: "qrc:/Images/Heart/heart.png" }
                EMHeartView { id: heart_5; source: "qrc:/Images/Heart/heart.png" }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                Button {
                    id: pause_btn
                    background: Rectangle {opacity: 0}
                    icon.source: "qrc:/Images/Icon/exit.png"
                    icon.color: btn_hover.hovered ? "#23bf76" : "#f9a535"
                    icon.height: 40
                    icon.width: 40
                    scale: btn_hover.hovered ? 1.3 : 1

                    HoverHandler {id: btn_hover}
                    onPressed: view.pop()
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
