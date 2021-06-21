import QtQuick
import QtQuick.Controls

import "../../Components/Buttons"
import "../../Js/GameEMViewManager.js" as Manager
import "../../Js/ToolFunc.js" as ToolFunc

Item {
    id: item
    focus: true

    property StackView view

    /// 消灭的单词数
    property int score: 0

    /// 游戏时间
    property int game_time: 0

    /// 能量值
    property int heart: 5

    /// 游戏难度、单词类型
    property string factor: factors[0]
    property string word_type: word_types[1]
    property var factors: ["easy", "medium", "difficulty", "devil"]
    property var word_types: ["top", "medium", "buttom", "number", "all"]

    /// 单词创建时间间隔、单词下落总时间
    property int time_space: 3000
    property int time_word: 6000

    /// 单词组件的大小、间距、坐标
    property real wordSpacing: Screen.width / 13 * 5 / 9
    property real wordSize: Screen.width / 13
    property var wordXs: [wordSpacing, wordSize + wordSpacing * 2,
                          wordSize * 2 + wordSpacing * 3, wordSize * 3 + wordSpacing * 4,
                          wordSize * 4 + wordSpacing * 5, wordSize * 5 + wordSpacing * 6,
                          wordSize * 6 + wordSpacing * 7, wordSize * 7 + wordSpacing * 8
                         ]

    /// 背景图片
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/Images/Background/background-2.png"
    }

    /// 控制创建单词的开始时间
    Timer {
        interval: 1600
        running: true
        onTriggered: {
            time.start()
            timer_word.start()
        }
    }

    /// 动态创建单词
    Timer {
        id: timer_word
        interval: time_space
        repeat: true
        triggeredOnStart: true
        onTriggered: Manager.createWord()
    }

    /// 计时
    Timer {
        id: time
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: game_time++
    }

    /// 动态创建云朵
    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: Manager.createWhiteCloud()
    }

    Component.onCompleted: {
        /// 如果不调用此函数，那么当不点击RadioButton时
        /// 当前页面的Keys失效
        forceActiveFocus()

        switch (factor) {
            case factors[0]:
                time_space = 1200
                time_word = 4000
                break
            case factors[1]:
                time_space = 800
                time_word = 3000
                break
            case factors[2]:
                time_space = 600
                time_word = 2500
                break
            case factors[3]:
                time_space = 400
                time_word = 2000
                break
            default:
                break
        }
    }

    /// 分数显示框
    EMScoreView {
        id: amusement_score_dialog
        anchors.right: parent.right
        anchors.rightMargin: 50
        score: item.score

        pause_btn.onPressed: {
            Manager.stopAllComponentAnimation()
            dialogs.openPauseDialog()
        }

        onHeart_numberChanged: {
            if (heart_number === 0) {
                Manager.stopAllComponentAnimation()
                Manager.destroyAllComponents()
                dialogs.openEndDialog()
            }
        }
    }

    EMDialogs {
        id: dialogs
        view: item.view
        score_txt: item.score
        time_txt: ToolFunc.toTime(game_time)

        Component.onCompleted: {
            againGame.connect(Manager.init)
            continueGame.connect(Manager.restartAllComponentAnimation)
        }
    }

    /// 监听键盘事件
    Keys.onPressed: (event) => {
        if (event.text !== null) {
            var result = Manager.isBingo(event.text)
            if (result[0] === true) {
                Manager.destroyComponent(result[1])
                item.score++;
            }
        }
    }
}
