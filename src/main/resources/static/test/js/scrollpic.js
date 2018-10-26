var speed=15; //数字越大速度越慢
var tab=document.getElementById("pic");
var tab1=document.getElementById("pic1");
var tab2=document.getElementById("pic2");
tab2.innerHTML=tab1.innerHTML;
function Marquee(){
    if(tab2.offsetWidth-tab.scrollLeft<=0)
        tab.scrollLeft-=tab1.offsetWidth
    else{
        tab.scrollLeft++;
    }
}
var MyMar=setInterval(Marquee,speed);
tab.onmouseover=function() {clearInterval(MyMar)};
tab.onmouseout=function() {MyMar=setInterval(Marquee,speed)};

