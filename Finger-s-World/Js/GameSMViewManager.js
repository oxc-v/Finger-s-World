var fileUrl = [":/WordLists/SpeedMode/list1.txt",
               ":/WordLists/SpeedMode/list2.txt",
               ":/WordLists/SpeedMode/list3.txt",
               ":/WordLists/SpeedMode/list4.txt"
              ]

function initSMMainVeiw() {
    smMainView.forceActiveFocus()
    textArea.textEdit.clear()
    textArea.textEdit.text = load(fileUrl[randomNum(0, fileUrl.length - 1)])
    smMainView.index = 0
    smMainView.errorNumbers = 0
    smMainView.correctNumbers = 0
    spriteAnim.opacity = 1
    spriteAnim.restart()
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
