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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
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

    <!-- 引入dialog的js -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>

    <!-- 引入时间插件的js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>

    <!-- ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>

    <script type="text/javascript">



        function openDialog() {
            $("#dialog_id").dialog({
                title:"新增权限",
                width:600,
                height:500,
                modal:true
            });
        }

        /*ztree*/
        function selectpid() {
            //查询所有权限 - ajax
            //dialog弹出ztree
            $.get("${pageContext.request.contextPath}/resc/queryall", function (data) {
                //初始化ztree
                var settings = {
                    data: {
                        key: {
                            name: "rname"
                        },
                        simpleData: {
                            enable: true,//启用简单json模式
                            pIdKey: "pid"
                        }
                    },
                    view: {
                        showIcon: false//隐藏图标
                    },
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            //ztree点击事件 treeNode - 代表当前被点击的节点json对象
                            $("#select_resc_id").html(treeNode.rname);
                            $("#pid_id").val(treeNode.id);
                            //关闭弹出框
                            $("#ztree_dialog").dialog("close");
                        },
                        beforeClick: function(treeId, treeNode){
                            if(treeNode.rstate == 1){
                                $("#rstate_id").html("二级权限");
                                $("#rstate_id_hidden").val(2);
                            } else if(treeNode.rstate == 2){
                                $("#rstate_id").html("三级权限");
                                $("#rstate_id_hidden").val(3);
                            } else if(treeNode.rstate == 3){
                                alert("三级权限下不能再有子权限！！！");
                                return false;
                            }
                            return true;
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
                    title: "选择父权限",
                    width: 300,
                    height: 200,
                    modal: false
                });


            }, "json");
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
                        <th>名称</th>
                        <th>描述</th>
                        <th>权限路径</th>
                        <th>权限类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                       <c:forEach items="${list}" var="resc">
                        <tr>
                            <td><input type="checkbox" /></td>
                            <td>${resc.id}</td>
                            <td>${resc.rname}</td>
                            <td>${resc.rdesc}</td>
                            <td>${resc.rpath}</td>
                            <td>
                                <c:if test="${resc.rstate == 1}">
                                    一级权限
                                </c:if>
                                <c:if test="${resc.rstate == 2}">
                                    二级权限
                                </c:if>
                                <c:if test="${resc.rstate == 3}">
                                    三级权限
                                </c:if>
                            </td>
                            <td>
                                <!-- Icons -->
                                <a href="#" title="Edit"><img
                                        src="resources/images/icons/pencil.png" alt="Edit"/></a>
                                <a
                                        href="#" title="Delete"><img
                                        src="resources/images/icons/cross.png" alt="Delete"/>
                                </a>
                                <a onclick="" title="Edit Meta"><img  src="resources/images/icons/hammer_screwdriver.png"
                                        alt="Edit Meta"/></a>
                            </td>
                        </tr>
                           </c:forEach>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <div class="bulk-actions align-left">
                                <a class="mybutton" onclick="openDialog()">新增权限</a>
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
            <form action="/resc/insertOne" method="post">
                <fieldset>
                    <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                    <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                    <p>
                        <label>权限名称</label>
                        <input
                                class="text-input small-input" type="text" id="rname_id"
                                name="rname"/>
                    </p>
                    <p>
                        <label>权限路径</label>
                        <input
                                class="text-input small-input" type="text" id="rpath_id"
                                name="rpath"/>
                    </p>
                    <p>
                        <label>选择父权限</label>
                        <button type="button" class="mybutton" id="select_resc_id" onclick="selectpid();">
                            无
                        </button>
                        <input type="hidden" id="pid_id" name="pid" value="-1">
                        <input type="hidden" id="rstate_id_hidden" name="rstate" value="1">
                    </p>
                    <p>
                        <label>权限描述</label>
                        <textarea class="text-input textarea wysiwyg" id="rdesc_id"
                                  name="rdesc" cols="60" rows="12"></textarea>
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
<!-- End #main-content -->
</body>
</html>
