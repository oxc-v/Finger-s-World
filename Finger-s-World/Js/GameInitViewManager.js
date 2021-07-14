// 动态创建组件
function createComponent(view, parent, properties)
{
    var component = Qt.createComponent(view)
    if (component.status === Component.Null || component.status === Component.Error)
        console.log(component.errorString())
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
    createComponent("qrc:/Components/Cloud/GameCloud.qml",
                     begin,
                     {y: cloudYs[randomNum(0, 2)],
                      source: cloudUrls[randomNum(0, 7)]
                     }
                   )
}

/// 创建游戏模式对话框
function createGameModeSelectView()
{
    var incubator = createComponent("qrc:/Views/Init/GameModeSelectView.qml",
                        begin,
                        {window: window, view: view}
                    )
    if (incubator.status === Component.Ready) {
        incubator.object.goEMPlayMethodView.connect(createOtherView)
        incubator.object.goSMTimeSelectionView.connect(createOtherView)
    } else {
        incubator.onStatusChanged = function(status) {
            if (status === Component.Ready) {
                incubator.object.goEMPlayMethodView.connect(createOtherView)
                incubator.object.goSMTimeSelectionView.connect(createOtherView)
            }
        }
    }
}

/// 创建其他模式对话框
function createOtherView(viewUrl)
{
    var incubator = createComponent(viewUrl,
                                    begin,
                                    {view: view}
                                   )
    if (incubator.status === Component.Ready) {
        incubator.object.goGameModeSelectView.connect(createGameModeSelectView)
    } else {
        incubator.onStatusChanged = function(status) {
            if (status === Component.Ready) {
                incubator.object.goGameModeSelectView.connect(createGameModeSelectView)
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


