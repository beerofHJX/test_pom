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
    <title>员工管理</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
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
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>

    <!--webuploader 上传图片-->
    <link rel="stylesheet" type="text/css" href="resources/widget/webuploader/webuploader.css">
    <script type="text/javascript" src="resources/widget/webuploader/webuploader.min.js"></script>

    <!-- 引入dialog的js -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>

    <!-- 引入时间插件的js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>

    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>

    <script type="text/javascript">

        function  openSomeselect_resc(eid) {
            $("#re_eid").val(eid);

            $.get("${pageContext.request.contextPath}/role/getAll",{eid:eid},function (data) {
                var html = "<ul>";
                for (var i = 0;i<data.length;i++){
                    html +="<li>";
                    if (data[i].flag){
                        html +="<input type='checkbox' value='"+data[i].id+"' name='rid' checked='checked'>";
                    }else {
                        html +="<input type='checkbox' value='"+data[i].id+"' name='rid' >";
                    }

                    html += data[i].rolename+"</li> ";
                }
                html += "</ul>";
                $("#role_put").html(html);

                $("#role_dialog").dialog({
                    title:"新增部门",
                    width:300,
                    height:200,
                    modal:true
                });
            },"json")
        }

        function openDialog() {
            $("#dialog_id").dialog({
                title:"新增部门",
                width:600,
                height:500,
                modal:true
            });
        }

        /*ztree*/
        function query_deps_ajax(){
            $.ajax({
                url:"${pageContext.request.contextPath}/dep/queryall",
                success:function(data){
                    //初始化ztree
                    var settings = {
                        data:{
                            key:{
                                name:"dname"
                            },
                            simpleData:{
                                enable:true,
                                pIdKey:"pid"
                            }
                        },
                        view:{
                            showIcon:false
                        },
                        callback:{
                            onClick:function(event, treeId, treeNode){
                                //ztree点击事件 treeNode - 代表当前被点击的节点json对象
                                $("#select_pdep_id").html(treeNode.dname);
                                $("#pid").val(treeNode.id);
                                $("#ztree_dialog").dialog("close");
                            }
                        }
                    };
                    var zNodes = data;
                    var ele = $("#ztree");

                    //初始化ztree
                    var ztreeObject = $.fn.zTree.init(ele, settings, zNodes);
                    ztreeObject.expandAll(true);

                    //弹出dialog
                    $("#ztree_dialog").dialog({
                        title:"选择父部门",
                        width:300,
                        height:200,
                        modal:false
                    });

                },
                dataType:"json"
            });
        }
            //修改职工的数据
            function update_emp(eid){
                //使用ajax通过职工id获取到该职工的信息
                debugger
                $.get("${pageContext.request.contextPath}/emp/queryById",{eid:eid},function(data){
                    //将职工信息填充到dialog上
                    $("#id").val(data.id);//id

                    //处理照片
                    if(data.image != null && data.image != ""){
                        $("#header").attr("src", "${pageContext.request.contextPath}/img/getImg?path=" + data.image);
                        $("#image").val(data.image);
                    } else {
                        $("#header").attr("src", "resources/images/icons/header.jpg")
                    }

                    //职工姓名
                    $("#name_id").val(data.name);

                    //邮箱
                    $("#email_id").val(data.email);

                    //密码
                    $("#password_id").val(data.password);

                    //性别
                    $("input[name='sex'][value='" + data.sex + "']").attr("checked","checked");

                    //电话
                    $("#phone_id").val(data.phone);

                    //所属部门
                    //<input type="button" value="xx"/>
                    //<button>xxxxx</button>
                    $("#select_dep_id").html(data.did);
                    $("#did").val(data.did);


                    //个人简介
                    $("#einfo_id").val(data.einfo);


                    //通过js将时间进行转换
                    var birthday = new Date(data.birthday);
                    //生日
                    $("#birthday_id").val(birthday.getFullYear() + "-" + (birthday.getMonth() + 1) + "-" + birthday.getDate());

                    //入职时间
                    var entrytime = new Date(data.entrytime);
                    $("#entrytime_id").val(entrytime.getFullYear() + "-" + (entrytime.getMonth() + 1) + "-" + entrytime.getDate());

                    //弹出dialog
                    $("#emp_dialog").dialog({
                        title:"修改职工",
                        width:600,
                        height:500,
                        modal:true
                    });

                },"test");//修改职工的数据
            }

    </script>
</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">

                <h1>部门管理</h1>
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox" /></th>
                        <th>编号</th>
                        <th>姓名</th>
                        <th>照片</th>
                        <th>性别</th>
                        <th>所属部门</th>
                        <th>入职时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${list}" var="emp">
                        <tr>
                            <td><input type="checkbox" /></td>
                            <td>${emp.id}</td>
                            <td>${emp.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${emp.image == null or emp.image == '' }">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/header.jpg" width="100"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/img/getImg?path=${emp.image}" width="100"/>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                            <td>${emp.sex == 0?"女":"男"}</td>
                            <td>${emp.did}</td>
                            <td><fmt:formatDate value="${emp.entrytime}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <!-- Icons -->
                                <a title="Edit" onclick="update_emp(${emp.id});">
                                    <img src="resources/images/icons/pencil.png"  alt="Edit" />
                                </a>
                                <a href="#" title="Delete">
                                    <img src="resources/images/icons/cross.png" alt="Delete" />
                                </a>
                                <a onclick="openSomeselect_resc(${emp.id});" title="Edit Meta">
                                    <img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta" />
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <shiro:hasPermission name="/emp/insertOne">
                                    <a class="mybutton" onclick="openDialog()">新增员工</a>
                                </shiro:hasPermission>
                            </div>

                            <jsp:include page="page.jsp"/>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>

                </table>
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>

<div style="display: none" id="dialog_id">
    <div class="tab-content default-tab" id="tab2">
        <form action="/emp/insertOne" method="post">
            <fieldset>

                <p>
                    <label>照片</label>
                    <img src="resources/images/icons/header.jpg" width="100" id="img_id"/>
                    <input  type="hidden" id="image_id" name="image" />
                    <div id="filePicker">上传图片</div>
                </p>

                <p>
                    <label>职工姓名</label>
                    <input
                            class="text-input small-input" type="text" id="name_id"
                            name="name" />
                </p>

                <p>
                    <label>邮箱</label>
                    <input
                            class="text-input small-input" type="text" id="email_id"
                            name="email" />
                </p>

                <p>
                    <label>电话</label>
                    <input
                            class="text-input small-input" type="text" id="phone_id"
                            name="phone" />
                </p>

                <p>
                    <label>密码</label>
                    <input
                            class="text-input small-input" type="password" id="password_id"
                            name="password" />
                </p>

                <p>
                    <label>性别</label>
                    <input type="radio" name="sex" value="1" checked/>男<br/>
                    <input type="radio" name="sex" value="0"/>女
                </p>

                <p>
                    <label>选择父部门</label>
                    <button id="select_pdep_id" class="mybutton" type="button" onclick="query_deps_ajax();">无</button>
                    <input type="hidden" id="pid" name="did" value="-1"/>
                </p>
                <p>
                    <label>生日</label> <input
                        class="text-input small-input Wdate" type="text"  id="birthday_id"
                        name="birthday" onClick="WdatePicker()"/>
                </p>

                <p>
                    <label>入职时间</label> <input
                        class="text-input small-input Wdate" type="text"  id="entrytime_id"
                        name="entrytime" onClick="WdatePicker()"/>
                </p>

                <p>
                    <label>个人简介</label>
                    <textarea class="text-input textarea wysiwyg" id="einfo_id"
                              name="einfo" cols="79" rows="15"></textarea>
                </p>
                <p>
                    <input class="mybutton" type="submit" value="提交" />
                </p>
            </fieldset>
            <div class="clear"></div>
            <!-- End .clear -->
        </form>
        <!-- End #tab2 -->
    </div>
    <!-- End .content-box-content -->
</div>
</div>
<!-- 树形结构的弹出框 -->
<div id="ztree_dialog" style="display: none;">
    <div id="ztree" class="ztree"></div>
</div>

<div id="role_dialog" style="display: none;">
    <form action="${pageContext.request.contextPath}/emp/updataRole" method="post">
        <input type="hidden" name="eid" id="re_eid" value="">
        <div id="role_put" ></div>
        <button type="submit" class="mybutton">提交</button>
    </form>
</div>

<script type="text/javascript">
    // 初始化Web Uploader
    var uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: true,
        // swf文件路径
        swf: '${pageContext.request.contextPath}/resources/widget/webuploader/Uploader.swf',
        // 文件接收服务端。
        server: '${pageContext.request.contextPath}/img/upload',
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',
        // 只允许选择图片文件。
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        }
    });

    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {
        var img_id = $("#img_id");
        // 创建缩略图
        // 如果为非图片文件，可以不用调用此方法。
        // thumbnailWidth x thumbnailHeight 为 100 x 100
        uploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                alert("GG")
                return;
            }

            img_id.attr( 'src', src );

        }, 100, 100 );
    });

    uploader.on( 'uploadSuccess', function( file ,response) {
        $("#image_id").val(response.fileuploader);
    });


</script>
<!-- End #main-content -->
</body>
</html>
