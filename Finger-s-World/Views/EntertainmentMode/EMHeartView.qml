import QtQuick
import QtQuick.Controls

Item {
    id: heart
    height: 30
    width: 30

    property alias source: image.source

    Image {
        id: image
        anchors.fill: parent
    }

    state: "show"

    states: [
        State {
            name: "hide"
            PropertyChanges { target: heart; scale: 0 }
        },
        State {
            name: "show"
            PropertyChanges { target: heart; scale: 1 }
        }
    ]

    transitions: [
        Transition {
            from: "show"
            to: "hide"
            NumberAnimation {
                target: heart
                property: "scale"
                duration: 200
                easing.type: Easing.InOutBack
            }
        },
        Transition {
            from: "hide"
            to: "show"
            NumberAnimation {
                target: heart
                property: "scale"
                duration: 200
                easing.type: Easing.InOutBack
            }
        }
    ]
}
