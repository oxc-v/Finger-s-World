// 云朵组件

import QtQuick

Item {
    implicitHeight: 100
    implicitWidth: 200
    x: -width

    property alias source: image.source

    Image {
        id: image
        anchors.fill: parent
    }

    /// 组件水平向右移动
    XAnimator on x {
        to: Screen.width
        duration: 15000
    }

    /// 销毁组件
    onXChanged: {
        if (x === Screen.width)
            destroy()
    }
}
