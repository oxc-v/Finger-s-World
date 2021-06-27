import QtQuick 2.15
import QtQuick.Particles 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15

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
    function startDestroyComponent() {
        bomb.play()
        animation.stop()
        rec.opacity = 0
        burstEmitter.burst(100)
        timer.start()
    }

    Rectangle {
        id: rec
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
    YAnimator on y {
        id: animation
        from: -word_item.height
        to: Screen.height
        duration: 6000
    }

    /// 组件销毁特效
    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {
            id: imageParticle
            groups: ["stage"]
            source: "qrc:/Images/Icon/green.png"
            entryEffect: ImageParticle.Scale
            rotation: 60
            rotationVariation: 30
            rotationVelocity: 45
            rotationVelocityVariation: 15
        }

        /// 粒子发射器
        Emitter {
            id: burstEmitter
            anchors.centerIn: parent
            group: "stage"
            lifeSpan: 700
            size: 50; endSize: 15; sizeVariation:10
            enabled: false
            velocity: CumulativeDirection {
                AngleDirection {angleVariation: 360; magnitudeVariation: 260;}
            }
        }
    }

    /// 销毁组件
    Timer {
        id: timer
        interval: 1000
        onTriggered: word_item.destroy()
    }

    /// 组件销毁音效
    SoundEffect {
        id: bomb
        source: "qrc:/Music/bomb.wav"
    }

    /// 当组件超出屏幕时销毁组件
    onYChanged: {
        if (word_item.y === Screen.height) {
            word_item.outOfRange(word_item)
            startDestroyComponent()
        }
    }
}
