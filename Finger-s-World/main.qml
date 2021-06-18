import QtQuick
import QtQuick.Controls
import QtQuick.Window

import "./Views"

Window {
    id: window
    visible: true
    visibility: Window.FullScreen
    title: qsTr("指上谈兵")

    StackView {
        id: stack_view
        anchors.fill: parent
        initialItem: GameBeginView { window: window; view: stack_view }

        pushEnter: Transition {
            id: pushEnter
            SequentialAnimation {
                PropertyAction { property: "x"; value: stack_view.width}
                NumberAnimation { property: "x";  to: 0; duration: 600; easing.type: Easing.OutBack }
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
            NumberAnimation { property: "y";  to: 0; duration: 600; easing.type: Easing.OutBack}
        }
    }

}
