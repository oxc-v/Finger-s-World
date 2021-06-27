import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtMultimedia 5.15

import "../../Components/TextEidt"
import "../../Js/GameTMViewManager.js" as Manager

Item {
    id: tmMainview

    property int index: 0
    property url imageUrl
    property string text: "we"

    property StackView view

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        /// 返回按钮
        Button {
            id: btn
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: 50
            Layout.preferredWidth: 70
            background: Rectangle {
                color: hover.hovered ? "#3395db" : "#23bf76"
                radius: 10
            }
            icon.source: "qrc:/Images/Icon/goBack.png"
            icon.color: "#ffffff"

            HoverHandler {id: hover}
            onPressed: view.pop()
        }

        /// 文本区域
        GameTextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 3 * 1.1
            textEdit.text: tmMainview.text
        }

        /// 提示图片
        Image {
            id: image
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: parent.height - textArea.height - btn.height
            Layout.preferredWidth: parent.width / 3 * 2
            fillMode: Image.PreserveAspectFit
            source: imageUrl
        }
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

    /// 结束对话框
    TMOverDialog {
        id: dialog
        view: tmMainview.view
    }

    /// 索引改变时改变图片
    onIndexChanged: {
        if (index === tmMainview.text.length) {
            dialog.openTMOverDialog()
        }

        imageUrl = Manager.getImageUrl(textArea.textEdit.getText(index, index + 1))
    }

    /// 组件初始化
    Component.onCompleted: {
        background.play()
        forceActiveFocus()
        tmMainview.text = load(":/WordLists/TeachingMode/list1.txt")
        dialog.initTMMainView.connect(Manager.initTMMainVeiw)
        imageUrl = Manager.getImageUrl(textArea.textEdit.getText(0, 1))
    }

    /// 打字音效
    SoundEffect {
        id: type_error
        source: "qrc:/Music/type_error.wav"
    }
    SoundEffect {
        id: type_correct
        source: "qrc:/Music/type_correct.wav"
    }

    /// 背景音效
    SoundEffect {
        id: background
        source: "qrc:/Music/TM_background_music.wav"
    }

    /// 监听键盘事件
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
            textArea.border.color = "red"
            shake.start()
            type_error.play()
        }
    }
}
