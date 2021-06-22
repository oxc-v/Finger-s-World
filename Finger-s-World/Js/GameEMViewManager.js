/// 单词列表
var top_row_word = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
var medium_row_word = ["a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'"]
var buttom_row_word = ["z", "x", "c", "v", "b", "n", "m", ",", ".", "/"]
var number = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
var all_letter = top_row_word.concat(medium_row_word.concat(buttom_row_word))

/// 单词类别
var word_type = ["top", "medium", "buttom", "number", "all"]

/// 单词组件集合
var word_components = []

/// 获取随机单词
function getRandomWord(type)
{
    switch (type) {
        case word_type[0]:
            return top_row_word[randomNum(0, top_row_word.length - 1)]
        case word_type[1]:
            return medium_row_word[randomNum(0, medium_row_word.length - 1)]
        case word_type[2]:
            return buttom_row_word[randomNum(0, buttom_row_word.length - 1)]
        case word_type[3]:
            return number[randomNum(0, number.length - 1)]
        case word_type[4]:
            return all_letter[randomNum(0, all_letter.length - 1)]
        default:
            return ""
    }
}

/// 生成随机数
function randomNum(minNum, maxNum){
    switch(arguments.length){
        case 1:
            return parseInt(Math.random()*minNum+1,10);
        case 2:
            return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10);
        default:
            return 0;
    }
}

/// 动态创建组件
function createComponent(view, parent, properties)
{
    var component = Qt.createComponent(view)
    var incubator = component.incubateObject(parent, properties)
    return incubator
}

/// 创建单词组件
function createWord()
{
    var incubator = createComponent("qrc:/Views/EntertainmentMode/EMWordView.qml",
                        item,
                        {x: wordXs[randomNum(0, 7)],
                         text: getRandomWord(item.word_type),
                         duration: time_word
                        }
                    )
    if (incubator.status === Component.Ready) {
        word_components.push(incubator)
        incubator.object.outOfRange.connect(componentOutRange)
    } else {
        incubator.onStatusChanged = function(status) {
            if (status === Component.Ready) {
                word_components.push(incubator)
                incubator.object.outOfRange.connect(componentOutRange)
            }
        }
    }
}

/// 动态创建云朵
function createWhiteCloud()
{
    var cloudYs = [5, 75, 155]
    var cloudUrls = ["qrc:/Images/Cloud/cloud1.png", "qrc:/Images/Cloud/cloud2.png",
                     "qrc:/Images/Cloud/cloud3.png", "qrc:/Images/Cloud/cloud4.png",
                     "qrc:/Images/Cloud/cloud5.png", "qrc:/Images/Cloud/cloud6.png",
                     "qrc:/Images/Cloud/cloud7.png", "qrc:/Images/Cloud/cloud8.png"
                    ]
    createComponent("qrc:/Components/Cloud/GameCloud.qml",
                     item,
                     {y: cloudYs[randomNum(0, 2)],
                      source: cloudUrls[randomNum(0, 7)]
                     }
                   )
}

/// 根据字符串判断是否存在组件
function isBingo(text)
{
    for (let i in word_components) {
        if (word_components[i].object.text === text)
            return [true, i]
    }

    return [false, null]
}

/// 单词组件超出范围时
function componentOutRange(item)
{
    for (let i in word_components) {
        if (word_components[i].object === item)
            word_components.splice(i, 1)
    }

    amusement_score_dialog.destroyHeart()
}

/// 根据索引删除组件
function destroyComponent(index)
{
    word_components[index].object.startDestroyComponent()
    word_components.splice(index, 1)
}

/// 暂停所有组件的动画
function stopAllComponentAnimation()
{
    timer_word.stop()
    time.stop()
    for (const word of word_components)
        word.object.ani.stop()
}

/// 重启所有组件的动画
function restartAllComponentAnimation()
{
    timer_word.start()
    time.start()
}

/// 删除所有组件
function destroyAllComponents()
{
    for (const word of word_components)
        word.object.startDestroyComponent()

    word_components.splice(0, word_components.length)
}

/// 初始化
function init() {
    amusement_score_dialog.heart_number = 5
    amusement_score_dialog.displayHeart()
    item.score = 0
    item.heart = 5
    item.game_time = 0
    restartAllComponentAnimation()
}

