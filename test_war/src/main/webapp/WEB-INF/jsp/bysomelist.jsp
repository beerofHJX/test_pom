<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/28 0028
  Time: 下午 7:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>公司男女人口数量</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen"/>
    <!-- 引入dialog的js -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>

    <!-- 引入 ECharts 文件 -->
    <script src="resources/ECherts/echarts.js"></script>


</head>
<body>
<div id="main-content">
    <h2>按部门统计</h2>
    <div class="content-box">
        <!-- End .content-box-header -->
        <div>
            <button class="mybutton" id="shape_id" onclick="shape();">条形图</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="mybutton" id="columnar_id" onclick="columnar();">柱状图</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="mybutton" id="pancake_id" onclick="pancake();">饼状图</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <button class="mybutton" id="table_id" onclick="gettable();">表格</button>&nbsp;&nbsp;&nbsp;&nbsp;
            <br><br><br>
            <h3>请选择图形</h3>
        </div>
        <br><br>
        <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
        <div id="main" style="width: 600px;height:400px;"></div>


    </div>

</div>

<%--弹框--%>
<div id="two" style="display: none;">
    <table  bgcolor="#f0f8ff" border="1">
        <tr>
            <td>部门</td>
            <td>人数</td>
        </tr>

        <c:forEach items="${datas}" var="data">
            <tr>
                <th>${data.dname}</th>
                <th>${data.count}</th>
            </tr>
        </c:forEach>


    </table>
</div>

<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));
    var option;
    var names;
    var count = [];

    $.ajax({
        url: "${pageContext.request.contextPath}/graphical/shape",
        success: function (data) {
            datas = data;
            var name = new Array();
            for (var i = 0; i < data.length; i++) {
                // name.push(data[i].dname);
                var n = data[i].dname;
                name.push(n);
                count[i] = data[i].count;
            }
            names = name;
        },
        dataType: "json"
    });
    function columnar() {
        // alert(data);
        // 基于准备好的dom，初始化echarts实例
        // 指定图表的配置项和数据
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: names,
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '人数',
                    type: 'bar',
                    barWidth: '60%',
                    data: count
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.clear();
        myChart.setOption(option);
    }

    function gettable() {
        $("#two").dialog();
    }

    function shape() {
        option = {
            title: {
                text: '按部门查看人数'
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: names
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            xAxis: {
                type: 'category',
                data: names
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    name: '人数',
                    type: 'line',
                    step: 'start',
                    data: count
                }
            ]
        };


        myChart.clear();
        myChart.setOption(option);
    }


    function pancake() {
        var dos ="[";
        for (var i=0;i<count.length;i++){
                dos += ("{value:"+count[i]+", name:'"+names[i]+"}");
                if (i !=count.length-1){
                    dos +=",";
                }
        }
        dos +="]";

        var n ="[";
        for (var i=0;i<names.length;i++){
            n += ("'"+names[i]+"'");
            if (i !=names.length-1){
                n +=",";
            }
        }
        n +="]";
        alert(n)
        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: names
            },
            series: [
                {
                    name:'人数',
                    type:'pie',
                    radius: ['50%', '70%'],
                    avoidLabelOverlap: false,
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },
                        emphasis: {
                            show: true,
                            textStyle: {
                                fontSize: '30',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data:dos
                }
            ]
        };


        myChart.clear();
        myChart.setOption(option);
    }

</script>

<!-- End #main-content -->
</body>
</html>
