// 动态创建组件
function createComponent(view, parent, properties)
{
    var component = Qt.createComponent(view)
    var incubator = component.incubateObject(parent, properties)
    return incubator
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
    createComponent("qrc:/Components/Cloud/WhiteCloud.qml",
                     begin,
                     {y: cloudYs[randomNum(0, 2)],
                      source: cloudUrls[randomNum(0, 7)]
                     }
                   )
}

/// 创建游戏模式对话框
function createGameModelDialog()
{
    var incubator = createComponent("qrc:/Components/Dialogs/GameModelSelectDialog.qml",
                        begin,
                        {window: window}
                    )
    if (incubator.status === Component.Ready) {
        incubator.object.goAmusementView.connect(createAmusementModelDialog)
    } else {
        incubator.onStatusChanged = function(status) {
            if (status === Component.Ready) {
                incubator.object.goAmusementView.connect(createAmusementModelDialog)
            }
        }
    }
}

/// 创建娱乐模式对话框
function createAmusementModelDialog()
{
    var incubator = createComponent("qrc:/Components/Dialogs/AmusementModelSelectDialog.qml",
                                    begin,
                                    {view: view}
                                   )
    if (incubator.status === Component.Ready) {
        incubator.object.goGameModelView.connect(createGameModelDialog)
    } else {
        incubator.onStatusChanged = function(status) {
            if (status === Component.Ready) {
                incubator.object.goGameModelView.connect(createGameModelDialog)
            }
        }
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


