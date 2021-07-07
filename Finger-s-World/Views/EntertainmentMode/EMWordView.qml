import QtQuick
import QtQuick.Particles
import QtQuick.Window
import QtMultimedia

Item {
    id: word_item
    implicitWidth: Screen.width / 13
    implicitHeight: width * 1.2

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

    Image {
        id: rec
        anchors.fill: parent
        source: "qrc:/Images/Word/balloon.png"
        Text {
            id: txt
            anchors.fill: parent
            color: "#ffffff"
            font.bold: true
            font.pixelSize: 45
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    /// 组件上升动画
    YAnimator on y {
        id: animation
        from: Screen.height
        to: -word_item.height
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
            size: 30; endSize: 0; sizeVariation:10
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
        console.log(word_item.y, word_item.height)
        if (Math.abs(word_item.y + word_item.height) <= 0.0001) {
            word_item.outOfRange(word_item)
            startDestroyComponent()
        }
    }
}
