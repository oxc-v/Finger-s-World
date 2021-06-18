/// 秒转换为分秒
function toTime(s){
    var time = ""
    if(s > -1){
        var min = Math.floor((s/60)%60);
        var sec = s % 60;
        if(min < 10){
            time += "0";
        }
        console.log(time)
        time += min + ":";
        if(sec < 10){
            time += "0";
        }
        time += sec.toFixed(0);
    }
    console.log(time)
    return time;
}
