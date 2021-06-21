import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../Js/GameTMViewManager.js" as Manager

Item {
    id: tmMainview

    property int index: 0
    property url imageUrl
    property string text: "we"

    property StackView view

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10

        /// 返回按钮
        Button {
            id: btn
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: 70
            background: Rectangle { color: hover.hovered ? "#3395db" : "#23bf76"; radius: 5 }
            icon.source: "qrc:/Images/Icon/goBack.png"
            icon.color: "#ffffff"

            HoverHandler {id: hover}
            onPressed: view.pop()
        }

        /// 文本区域
        Rectangle {
            id: textArea
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 3 * 1.1
            border.width: 2
            border.color: "#99caed"
            radius: 10

            Flickable {
                id: flick
                anchors.fill: parent
                anchors.margins: 10
                contentWidth: parent.width
                contentHeight: parent.height
                clip: true

                function ensureVisible(r)
                {
                    if (contentX >= r.x)
                        contentX = r.x;
                    else if (contentX+width <= r.x+r.width)
                        contentX = r.x+r.width-width;
                    if (contentY >= r.y)
                        contentY = r.y;
                    else if (contentY+height <= r.y+r.height)
                        contentY = r.y+r.height-height;
                }

                TextEdit {
                    id: textEdit
                    width: flick.width
                    text: tmMainview.text
                    cursorVisible: true
                    font.letterSpacing: 18
                    font.wordSpacing: 2
                    font.pointSize: 30
                    readOnly: true
                    clip: true
                    selectionColor: "#23bf76"
                    wrapMode: TextEdit.Wrap
                    cursorDelegate: Rectangle {
                        id: oxc
                        height: 1
                        opacity: 0.5
                        width: 32
                        radius: 5
                        color: "#3395db"
                    }

                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                }
            }
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
            to: 10
            duration: 80
        }
        RotationAnimation {
            target: textArea
            to: -10
            duration: 80
        }
        RotationAnimation {
            target: textArea
            to: 10
            duration: 80
        }
        RotationAnimation {
            target: textArea
            to: 0
            duration: 80
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

        imageUrl = Manager.getImageUrl(textEdit.getText(index, index + 1))
    }

    /// 组件初始化
    Component.onCompleted: {
        forceActiveFocus()
        tmMainview.text = load(":/WordLists/TeachingMode/list1.txt")
        dialog.initTMMainView.connect(Manager.initTMMainVeiw)
        imageUrl = Manager.getImageUrl(textEdit.getText(0, 1))
    }

    /// 监听键盘事件
    Keys.onPressed: (event) => {
        if (event.text === textEdit.getText(index, index + 1)) {
            index++
            textEdit.select(0, index)
        } else if (event.key !== Qt.Key_Shift) {
            textArea.border.color = "red"
            shake.start()
        }
    }
}
