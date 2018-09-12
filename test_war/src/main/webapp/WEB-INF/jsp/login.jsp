<%--
  Created by IntelliJ IDEA.
  User: 60207
  Date: 2018/9/3
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
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
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen" />
    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.3.2.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- Facebox jQuery Plugin -->
    <script type="text/javascript" src="resources/scripts/facebox.js"></script>
    <!-- jQuery WYSIWYG Plugin -->
    <script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
</head>
<body id="login">
<div id="login-wrapper" class="png_bg">
    <div id="login-top">
        <h1>假的OA办公自动化系统</h1>
        <!-- Logo (221px width) -->
        <a href="#"><img id="logo" src="resources/images/logo.png"
                         alt="Simpla Admin logo" /></a>
    </div>
    <!-- End #logn-top -->
    <div id="login-content">
        <form action="${pageContext.request.contextPath }/login"
              method="post">
            <div class="notification information png_bg">
                <div>用户名或者密码错误</div>
            </div>
            <p>
                <label>邮箱</label> <input class="text-input" name="email"
                                         type="text" />
            </p>
            <div class="clear"></div>
            <p>
                <label>密码</label> <input class="text-input" name="password"
                                         type="password" />
            </p>
            <div class="clear"></div>
            <p id="remember-password">
                <input type="checkbox" /> 记住我
            </p>
            <div class="clear"></div>
            <p>
                <input class="mybutton" type="submit" value="登录" />
            </p>
        </form>
    </div>
    <!-- End #login-content -->
</div>
<!-- End #login-wrapper -->
</body>
</html>


