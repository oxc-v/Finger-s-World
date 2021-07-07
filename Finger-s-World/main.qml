import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtMultimedia

import "./Views/Init"

Window {
    id: window
    visible: true
    visibility: Window.FullScreen
    title: qsTr("指上谈兵")

    StackView {
        id: stack_view
        anchors.fill: parent
        initialItem: InitView { window: window; view: stack_view }

        pushEnter: Transition {
            id: pushEnter
            SequentialAnimation {
                PropertyAction { property: "x"; value: stack_view.width }
                NumberAnimation { property: "x";  to: 0; duration: 500; easing.type: Easing.OutBack }
            }
        }
        popExit: Transition {
            id: popExit
            PropertyAction { property: "x"; value: popExit.ViewTransition.item.pos + stack_view.offset}
        }

        pushExit: Transition {
            id: pushExit
            PropertyAction { property: "y"; value: -stack_view.height }
        }
        popEnter: Transition {
            id: popEnter
            NumberAnimation { property: "y";  to: 0; duration: 500; easing.type: Easing.OutBack }
        }

        /// 音效控制
        onDepthChanged: {
            cut_view.play()
            if (depth != 1)
                background_music.stop()
            else
                background_music.play()
        }
    }

    /// 背景音效
    SoundEffect {
        id: background_music
        source: "qrc:/Music/Init_background_music.wav"
        loops: SoundEffect.Infinite
    }

    /// 页面切换音效
    SoundEffect {
        id: cut_view
        source: "qrc:/Music/cut_view.wav"
    }
}
