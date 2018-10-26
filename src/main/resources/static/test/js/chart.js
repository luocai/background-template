var bzt2 = echarts.init(document.getElementById("chart1"),'vintage');
bzt2.setOption({
    title:{
        text:"专业人数分布"
    },
    tooltip : {
        trigger: 'item',
        formatter: " {b}:{c}人 ({d}%)"
    },
    itemStyle:{
        emphasis:{
            shadowBlur:200,
            shadowColor:"rgba(0,0,0,0.8)"
        }
    },
    series:[
        {
            name: '访问来源',
            type: 'pie',
            radius: '55%',
            data:[
                {value:350, name:'计算机学院'},
                {value:259, name:'文学与新闻学院'},
                {value:310, name:'临床医学院'},
                {value:270, name:'商学院'},
                {value:265, name:'法学院'},
                {value:283, name:'化学院'},
                {value:120, name:'物理学院'}
            ]
        }
    ],
    legend: {
        orient: 'vertical',
        left: 'right',
        data: ['计算机学院','文学与新闻学院','临床医学院','商学院','法学院','化学院','物理学院']
    },


});



var chart2 = echarts.init(document.getElementById("chart2"),'vintage');
chart2.setOption({
    series: [{
        type: 'map',
        map: 'china'
    }],
    title: {
        text: '新生省份统计',
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b}<br/>{c} (人)'
    },
    toolbox: {
        show: true,
        orient: 'vertical',
        left: 'center'
    },
    visualMap: {
        min: 30,
        max: 590,
        text:['High','Low'],
        realtime: false,
        calculable: true
       /* inRange: {
            color: ['lightskyblue','yellow', 'orangered']
        }*/
    },
    series: [
        {
            name: '新生省份统计',
            type: 'map',
            mapType: 'china', // 自定义扩展图表类型
            itemStyle:{
                normal:{label:{show:true}},
                emphasis:{label:{show:true}}
            },
            data:[
                {name: '内蒙古', value: 149},
                {name: '北京', value: 200},
                {name: '天津', value: 152},
                {name: '上海', value: 124},
                {name: '重庆', value: 290},
                {name: '河北', value: 408},
                {name: '山西', value: 135},
                {name: '辽宁', value: 243},
                {name: '吉林', value: 200},
                {name: '黑龙江', value: 158},
                {name: '江苏', value: 300},
                {name: '浙江', value: 379},
                {name: '安徽', value: 234},
                {name: '福建', value: 217},
                {name: '山东', value: 321},
                {name: '河南', value: 401},
                {name: '湖北', value: 310},
                {name: '湖南', value: 270},
                {name: '广东', value: 254},
                {name: '海南', value: 126},
                {name: '四川', value: 585},
                {name: '贵州', value: 254},
                {name: '云南', value: 297},
                {name: '陕西', value: 322},
                {name: '甘肃', value: 200},
                {name: '青海', value: 180},
                {name: '台湾', value: 58},
                {name: '广西', value: 231},
                {name: '西藏', value: 115},
                {name: '宁夏', value: 201},
                {name: '新疆', value: 125},
                {name: '香港', value: 48},
                {name: '澳门', value: 29},
                {name: '江西', value: 264}
            ]

        }]
});




