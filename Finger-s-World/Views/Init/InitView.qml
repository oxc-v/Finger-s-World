import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

import "../../Js/GameInitViewManager.js" as Manager

Item {
    id: begin

    property StackView view
    property Window window

    /// 背景图片
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/Images/Background/background-1.png"
    }

    /// 动态创建云朵
    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: Manager.createWhiteCloud()
    }

    /// 创建游戏模式选择对话框
    Component.onCompleted: Manager.createGameModeSelectView()
}
