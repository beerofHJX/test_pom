<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/28 0028
  Time: 下午 7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Simpla Admin</title>
    <!--                       CSS                       -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen" />
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen" />
    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- 引入dialog的js -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- Facebox jQuery Plugin -->
    <script type="text/javascript" src="resources/scripts/facebox.js"></script>
    <!-- jQuery WYSIWYG Plugin -->
    <script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
    <%--引入融云--%>
    <script src="http://cdn.ronghub.com/RongIMLib-2.3.3.min.js"></script>
    <style>
        body {
            overflow-x: hidden;
            overflow-y: hidden;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            $("#homeframe").css("height", $(window).height());
        });
        
        $(function () {
            RongIMLib.RongIMClient.init("8w7jv4qb82tby");

            // 设置连接监听状态 （ status 标识当前连接状态 ）
            // 连接状态监听器
            RongIMClient.setConnectionStatusListener({
                onChanged: function (status) {
                    switch (status) {
                        case RongIMLib.ConnectionStatus.CONNECTED:
                            console.log('链接成功');
                            break;
                        case RongIMLib.ConnectionStatus.CONNECTING:
                            console.log('正在链接');
                            break;
                        case RongIMLib.ConnectionStatus.DISCONNECTED:
                            console.log('断开连接');
                            break;
                        case RongIMLib.ConnectionStatus.KICKED_OFFLINE_BY_OTHER_CLIENT:
                            console.log('其他设备登录');
                            break;
                        case RongIMLib.ConnectionStatus.DOMAIN_INCORRECT:
                            console.log('域名不正确');
                            break;
                        case RongIMLib.ConnectionStatus.NETWORK_UNAVAILABLE:
                            console.log('网络不可用');
                            break;
                    }
                }});

            // 消息监听器
            RongIMClient.setOnReceiveMessageListener({
                // 接收到的消息
                onReceived: function (message) {
                    // 判断消息类型
                    switch(message.messageType){
                        case RongIMClient.MessageType.TextMessage:
                            // message.content.content => 消息内容
                            console.log("接收到消息："+message.content.content);
                            console.log("谁发送给我消息的："+message.senderUserId);
                            var toid = $("#toid").val();
                            if(toid == message.senderUserId){
                                //正在和这个人聊天
                                var content = message.content.content;
                                var toname = $("#toname").val();
                                var time = new Date().getFullYear() + "-" + (new Date().getMonth() + 1) + "-" + new Date().getDate();
                                $("#msg_content_id").append(toname + " " +  time + "<br/> " + content + "<br/><br/>");

                            } else {
                                //并没有和这个人再聊天
                                var length = $("#number_" + message.senderUserId).length;
                                if(length > 0){
                                    var number = $("#number_" + message.senderUserId).html();
                                    number++;
                                    $("#number_" + message.senderUserId).html(number);
                                } else {
                                    var username = $("#user_" + message.senderUserId).html();
                                    username = username + "(<span id='number_" + message.senderUserId + "'>1</span>)";
                                    $("#user_" + message.senderUserId).html(username);
                                }
                            }
                            break;

                        default:
                        // do something...
                    }
                }
            });

            var token = "${emp.token}";

            RongIMClient.connect(token, {
                onSuccess: function(userId) {
                    console.log("Connect successfully." + userId);
                },
                onTokenIncorrect: function() {
                    console.log('token无效');
                },
                onError:function(errorCode){
                    var info = '';
                    switch (errorCode) {
                        case RongIMLib.ErrorCode.TIMEOUT:
                            info = '超时';
                            break;
                        case RongIMLib.ConnectionState.UNACCEPTABLE_PAROTOCOL_VERSION:
                            info = '不可接受的协议版本';
                            break;
                        case RongIMLib.ConnectionState.IDENTIFIER_REJECTED:
                            info = 'appkey不正确';
                            break;
                        case RongIMLib.ConnectionState.SERVER_UNAVAILABLE:
                            info = '服务器不可用';
                            break;
                    }
                    console.log(errorCode);
                }
            });
        })

        function itemclick(ele){
            $("#homeframe").attr("src", ele.name);
            $(".current").removeClass("current");
            $(ele).addClass("current");
        }

        //下面是点击显示好友列表的
        $("#friend_id").html("");
        function select_friend_id() {
            $.ajax({
                 url:"${pageContext.request.contextPath}/emp/nome",
                success:function (data) {
                    $("#friend_id").append("<ul>");
                    for (var i = 0;i<data.length;i++){
                        $("#friend_id").append("");
                        $("#friend_id").append("<li><a id='user_" + data[i].id + "' ondblclick='openMsgDialog(" + data[i].id + ", \"" + data[i].name + "\");' >" + data[i].name + "</a></li>");
                        $("#friend_id").append("");
                    }
                    $("#friend_id").append("</ul>");
                },
                dataType:"json"
            });

            $("#dialog_id").dialog({
                title:"同事",
                width:60,
                height:500,
                modal:true
            });
        //    下面是点击好友名称打开对话框的

        }
        function openMsgDialog(toid,toname) {
            $("#toid").val(toid);
            $("#toname").val(toname);
            $("#talk_id").dialog({
                title:"与"+toname+"对话",
                width:800,
                height:600,
                modal:true
            });
        }
    //    下面是点击对话框的发送按钮，将语句发送到对话框和里面
        function sendMsg() {
            debugger
            var toid = $("#toid").val();
            var toname = $("#toname").val();
            var time = new Date().getFullYear() + "-" + (new Date().getMonth() + 1) + "-" + new Date().getDate();
            var content = $("#content").val();

            $("#msg_content").append("<br/>"+time+"<br/>"+toname+":<br/>"+content);

            $.ajax({
               type:"POST",
                url:"${pageContext.request.contextPath}/talk/foryour"

            });
        }
    </script>
</head>
<body>
<div id="body-wrapper">
    <!-- Wrapper for the radial gradient background -->
    <div id="sidebar">
        <div id="sidebar-wrapper">
            <!-- Sidebar with logo and menu -->
            <h1 id="sidebar-title">
                <a href="#">Simpla Admin</a>
            </h1>
            <!-- Logo (221px wide) -->
            <a href="#"><img id="logo" src="resources/images/logo.png"
                             alt="Simpla Admin logo" /></a>
            <!-- Sidebar Profile links -->
            <div id="profile-links">
                你好, <a title="Edit your profile">
                <shiro:user>
                    <shiro:principal property="name"/>
                </shiro:user>
                        </a>, 你有 <a>0 条消息</a><br />
                <br /> <a title="我的同事" onclick="select_friend_id();">我的同事</a> |
                <a href="${pageContext.request.contextPath}/oa/logout"  title="Sign Out">注销</a>
            </div>
            <div id="dialog_id" style="display: none">
                <div id="friend_id"></div>
            </div>
            <div id="talk_id" style="display: none">
                <div id="spack_id">
                    <input type="hidden" name="toid" id="toid" value="-1"/>
                    <input type="hidden" name="toname" id="toname" value=""/>
                    <div  id="msg_content"
                         style="width: 730px; height: 300px ; border: #7d7d7d solid 1px; margin-bottom: 20px; padding: 20px 20px 20px 20px"></div>
                    <textarea class="text-input textarea" id="content"
                              name="content" cols="60" rows="10"></textarea>
                    <button class="mybutton" onclick="sendMsg();">发送</button>
                </div>
            </div>

            <!-- 引入菜单 -->
            <ul id="main-nav">
                <li><a onclick="itemclick(this);" name="/index/home"
                       class="nav-top-item no-submenu"> 主页 </a></li>

                        <%--<li><a onclick="itemclick(this);" name="dep/deplist">部门管理</a></li>--%>
                        <%--<li><a onclick="itemclick(this);" name="emp/emplist">职工管理</a></li>--%>
                        <%--<li><a onclick="itemclick(this);" name="role/rolelist">角色管理</a></li>--%>
                        <%--<li><a onclick="itemclick(this);" name="resc/resclist">权限管理</a></li>--%>
                        <c:forEach items="${emp.rescs}" var="resc">
                            <c:if test="${resc.rstate == 1}">
                                <li><a class="nav-top-item"> ${resc.rname} </a>
                                    <ul>
                                        <c:forEach items="${emp.rescs}" var="resc2">
                                            <c:if test="${resc2.rstate == 2 && resc2.pid == resc .id}">
                                               <li><a onclick="itemclick(this);" name="${resc2.rpath}">${resc2.rname}</a></li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:if>
                        </c:forEach>

            </ul>
        </div>
    </div>
    <!-- End #sidebar -->
    <iframe id="homeframe" name="homeframe" src="/index/home"
            width="100%" scrolling="auto" />
</div>

</body>
<!-- Download From www.exet.tk-->
</html>

