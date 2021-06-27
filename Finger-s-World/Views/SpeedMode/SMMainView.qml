import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtMultimedia 5.15

import "../../Components/TextEidt"
import "../../Js/ToolFunc.js" as Tool
import "../../Js/GameSMViewManager.js" as Manager

Item {
    id: smMainView
    property StackView view
    property int testTime

    property int index: 0
    property int errorNumbers: 0
    property int correctNumbers: 0
    property string text: ""
    property bool keyEnable: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        /// 返回按钮
        Button {
            id: goBack
            Layout.preferredHeight: 50
            Layout.preferredWidth: 70
            Layout.alignment: Qt.AlignRight
            background: Rectangle {
                color: hoverBack.hovered ? "#3395db" : "#23bf76"
                radius: 10
            }
            icon.source: "qrc:/Images/Icon/goBack.png"
            icon.color: "#ffffff"

            HoverHandler {id: hoverBack}
            onPressed: view.pop()
        }

        /// 时间进度条
        ProgressBar {
            id: control
            from: 100
            to: 0
            clip: true
            Layout.fillWidth: true
            value: 100

            contentItem: Item {
                implicitWidth: 200
                implicitHeight: 5

                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    radius: 5
                    color: "#849DFF"
                }
            }
        }

        /// 文本区域
        GameTextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height - goBack.height - control.height
        }
    }

    /// 对话框
    SMDialogs {
        id: dialogs
        view: smMainView.view
        finishCorrectNumbers: correctNumbers
        finishErrorNumbers: errorNumbers
        finishAccuracy: correctNumbers !== 0 ? (1 - (errorNumbers / correctNumbers).toFixed(2)) * 100 + "%" : 0 + "%"

        Component.onCompleted: againTest.connect(Manager.initSMMainVeiw)
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

    /// 进度条动画
    NumberAnimation {
        id: numAnima
        target: control
        property: "value"
        from: 100
        to: 0
        duration: testTime * 1000

        onFinished: {
            keyEnable = false
            dialogs.openFinishDialog()
        }
    }

    /// 倒计时特效
    AnimatedSprite {
        id: spriteAnim
        anchors.centerIn: parent
        running: true
        source: "qrc:/Images/Sprite/countDown.png"
        frameWidth: 400
        frameHeight: 400
        frameCount: 4
        frameDuration: 1000
        loops: 1
        interpolate: false
        finishBehavior: AnimatedSprite.FinishAtFinalFrame
        onFinished: {
            opacity = 0
            keyEnable = true
            numAnima.start()
        }
    }

    /// 索引值改变
    onIndexChanged: {
        if (index === textArea.textEdit.text.length - 1) {
            numAnima.stop()
            keyEnable = false
            dialogs.openFinishDialog()
        }
    }

    /// 组件初始化
    Component.onCompleted: {
        background.play()
        keyEnable = false
        smMainView.forceActiveFocus()
        textArea.textEdit.text = load(Manager.fileUrl[Manager.randomNum(0, Manager.fileUrl.length - 1)])
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
        source: "qrc:/Music/SM_background_music.wav"
        loops: SoundEffect.Infinite
    }

    /// 监听键盘事件
    Keys.enabled: keyEnable
    Keys.onPressed: (event) => {
        var str = textArea.textEdit.getText(index, index + 1)
        if (str === "\n" || str === "\r") {
            if (event.key === Qt.Key_Enter
                || event.key === Qt.Key_Return) {
                correctNumbers++
                index++
                textArea.textEdit.select(0, index)
            }
            type_correct.play()
        } else if ((event.text === str) || (str === "\n" && (event.key === Qt.Key_Enter || event.key === Qt.Key_Return))) {
            correctNumbers++
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
