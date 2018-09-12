<%--
  Created by IntelliJ IDEA.
  User: ken
  Date: 2018/8/28
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>发送邮件</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen"/>

    <!--                       Javascripts                       -->
    <!-- jQuery
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>-->
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>


    <!-- 富文本编辑框 -->
    <link rel="stylesheet" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
    <link href="resources/widget/dist/summernote.css" rel="stylesheet"/>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js"></script>
    <script src="resources/widget/dist/summernote.js"></script>
    <script src="resources/widget/dist/lang/summernote-zh-CN.js"></script>


    <!-- 收件人提示 -->
    <link rel="stylesheet" href="resources/widget/alter/dist/jquery.typeahead.min.css">
    <script src="resources/widget/alter/dist/jquery.typeahead.min.js"></script>

    <script type="text/javascript">
        $(function () {
            //多媒体编辑框
            $('.summernote').summernote({
                height: 400,
                tabsize: 2,
                lang: 'zh-CN'
            });

        });


        function select_value(ele) {
            var keyword = ele.value;
            $.post("${pageContext.request.contextPath}/emp/querybykeyword", {keyword: keyword}, function (data) {
                //收件人的自动完成提示
                $('.js-typeahead').typeahead({
                    order: "asc",
                    source: {
                        groupName: {
                            // Array of Objects / Strings
                            data: data
                        }
                    },
                    callback: {
                        onClickBefore: function (data) {
                        }
                    }
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
                <form action="${pageContext.request.contextPath}/mail/sendmail" id="formid" method="post" enctype="multipart/form-data">
                    <fieldset>
                        <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                        <p>
                            <label>标题</label>
                            <input
                                    class="text-input small-input" type="text" id="title_id"
                                    name="title"/>
                        </p>
                        <p>
                            <label>接收方</label>
                            <%-- <input
                                     class="text-input small-input" type="text" id="to_id"
                                     name="to" />--%>
                        <input name="to" type="hidden" id="to_id"/>
                        <div class="typeahead__container">
                            <div class="typeahead__field">
                            <span class="typeahead__query">
                            <input class="js-typeahead"
                                   name="q"
                                   type="search"
                                   id="searchid"
                                   autocomplete="off"
                                   onkeyup="select_value(this);"/>
                            </span>
                            </div>
                        </div>
                        </p>
                        <p>
                            <label>附件</label>
                            <input
                                    class="text-input small-input" type="file" id="file_id"
                                    name="file"/>
                        </p>
                        <p>
                            <label>内容</label>
                            <%--<textarea class="text-input textarea wysiwyg" id="content_id"
                                      name="content" cols="79" rows="15"></textarea>--%>
                            <div class="summernote"></div>
                            <input name="content" type="hidden" id="content_id"/>
                        </p>
                        <p>
                            <input class="mybutton" type="button" onclick="sendMail();" value="发送"/>
                        </p>
                    </fieldset>
                    
                    <script type="text/javascript">
                        //发送邮件
                        function sendMail(){
                            //文本控件中html -> 隐藏域
                            $("#content_id").val($('.summernote').summernote('code'));

                            //接收人
                            var tovalue = $("#searchid").val();//姓名(邮箱)
                            var begin = tovalue.indexOf("(");
                            var end = tovalue.indexOf(")");
                            var toemail = tovalue.substring(begin + 1, end);
                            $("#to_id").val(toemail);

                            //提交表单
                            $("#formid").submit();
                        }
                    </script>
                    
                    <div class="clear"></div>
                    <!-- End .clear -->
                </form>
                <!-- End #tab2 -->
                <!-- End .content-box-content -->
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->


</body>
</html>