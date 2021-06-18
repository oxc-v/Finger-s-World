import QtQuick

Item {
    id: word_item
    implicitWidth: Screen.width / 13
    implicitHeight: implicitWidth
    y: -implicitHeight

    signal outOfRange(var item)

    property alias text: txt.text
    property alias ani: animation
    property alias duration: animation.duration

    /// 开始销毁组件
    function startDestroyComponent() { scale.start() }

    Rectangle {
        anchors.fill: parent
        radius: parent.width / 2
        color: "#23bf76"

        Text {
            id: txt
            anchors.fill: parent
            color: "#ffffff"
            font.bold: true
            font.pointSize: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    /// 组件下落动画
    NumberAnimation on y {
        id: animation
        to: Screen.height
        duration: 6000
    }

    /// 组件销毁动画
    NumberAnimation {
        id: scale
        target: word_item
        property: "scale"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutBack

        onFinished: word_item.destroy()
    }

    /// 当组件超出屏幕时销毁组件
    onYChanged: {
        if (word_item.y === Screen.height) {
            word_item.outOfRange(word_item)
            word_item.destroy()
        }
    }
}
