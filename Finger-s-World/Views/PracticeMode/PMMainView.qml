import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtMultimedia 5.15

import "../../Components/TextEidt"
import "../../Js/ToolFunc.js" as Tool
import "../../Js/GamePMViewManager.js" as Manager

Item {
    id: pmMainView
    property StackView view
    property int index: 0
    property int second: 0
    property int errorNumbers: 0
    property bool keys_enabled: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        RowLayout {
            id: btnLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
            spacing: 20

            /// 文件添加按钮
            Button {
                id: addFile
                Layout.preferredWidth: 40
                Layout.preferredHeight: 50

                background: Rectangle {
                    color: hoverAdd.hovered ? "#3395db" : "#23bf76"
                    radius: 20
                }
                icon.source: "qrc:/Images/Icon/add.png"
                icon.color: "#ffffff"

                HoverHandler {id: hoverAdd}
                onPressed: dialogs.openFileDialog()
            }

            /// 返回按钮
            Button {
                id: goBack
                Layout.preferredHeight: 50
                Layout.preferredWidth: 70
                background: Rectangle {
                    color: hoverBack.hovered ? "#3395db" : "#23bf76"
                    radius: 10
                }
                icon.source: "qrc:/Images/Icon/goBack.png"
                icon.color: "#ffffff"

                HoverHandler {id: hoverBack}
                onPressed: view.pop()
            }
        }

        /// 文本区域
        GameTextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height - btnLayout.height
        }
    }

    PMDialogs {
        id: dialogs
        view: pmMainView.view
        finishTime: Tool.toTime(second)
        finishNumber: textArea.textEdit.text.length
        finishAccuracy: (1 - (errorNumbers / textArea.textEdit.text.length).toFixed(2)) * 100 + "%"

        fileDialog.onAccepted: {
            pmMainView.focus = true
            clocker.start()
            textArea.textEdit.text = load(fileDialog.fileUrl)
            keys_enabled = true
        }

        Component.onCompleted: againPratice.connect(Manager.initPMView)
    }

    /// 窗口抖动特效
    SequentialAnimation {
        id: shake

        RotationAnimation {
            target: textArea
            to: 1
            duration: 60
        }
        RotationAnimation {
            target: textArea
            to: -1
            duration: 60
        }
        RotationAnimation {
            target: textArea
            to: 1
            duration: 60
        }
        RotationAnimation {
            target: textArea
            to: 0
            duration: 60
        }

        onFinished: textArea.border.color = "#99caed"
    }

    /// 计时器
    Timer {
        id: clocker
        interval: 1000
        repeat: true
        onTriggered: second++
    }

    /// 监听索引值的改变
    onIndexChanged: {
        if (index === textArea.textEdit.text.length) {
            clocker.stop()
            dialogs.openFinishDialog()
        }
    }

    /// 组件初始化
    Component.onCompleted: forceActiveFocus()

    /// 打字音效
    SoundEffect {
        id: type_error
        source: "qrc:/Music/type_error.wav"
    }
    SoundEffect {
        id: type_correct
        source: "qrc:/Music/type_correct.wav"
    }

    /// 监听键盘事件
    Keys.enabled: keys_enabled
    Keys.onPressed: (event) => {
        var str = textArea.textEdit.getText(index, index + 1)
        if (str === "\n" || str === "\r") {
            if (event.key === Qt.Key_Enter
                || event.key === Qt.Key_Return) {
                index++
                textArea.textEdit.select(0, index)
            }
            type_correct.play()
        } else if ((event.text === str) || (str === "\n" && (event.key === Qt.Key_Enter || event.key === Qt.Key_Return))) {
            index++
            textArea.textEdit.select(0, index)
            type_correct.play()
        } else if (event.key !== Qt.Key_Shift && event.key !== Qt.Key_CapsLock) {
            errorNumbers++
            textArea.border.color = "red"
            shake.start()
            type_error.play()
        }
    }
}
