<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>欢迎使用OA系统</title>
    <meta name="keywords" content="HTML5 Bootstrap 3 Admin Template UI Theme" />
    <meta name="description" content="AbsoluteAdmin - A Responsive HTML5 Admin UI Framework">
    <meta name="author" content="AbsoluteAdmin">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="assets/skin/default_skin/css/theme.css">
    <link rel="stylesheet" type="text/css" href="assets/admin-tools/admin-forms/css/admin-forms.css">
    <link rel="shortcut icon" href="assets/img/favicon.ico">
</head>
<body class="external-page external-alt sb-l-c sb-r-c">
<div id="main" class="animated fadeIn">
    <section id="content_wrapper">
        <section id="content">
            <div class="admin-form theme-info mw500" id="login">
                <div class="content-header">
                    <h1> OA系统 V1.0 </h1>
                    <p class="lead">欢迎使用办公自动化管理系统</p>
                </div>
                <div class="panel mt30 mb25">
                    <form method="post" action="login" id="login_form">
                        <div class="panel-body bg-light p25 pb15">
                            <div class="section">
                                <label for="sn" class="field-label text-muted fs18 mb10">员工编号</label>
                                <label for="sn" class="field prepend-icon">
                                    <input type="text" name="sn" id="sn" class="gui-input" placeholder="请输入员工编号" onblur="checkSn();" value="200001">
                                    <label for="sn" class="field-icon">
                                        <i class="fa fa-user"></i>
                                    </label>
                                </label>
                            </div>
                            <div class="section">
                                <label for="password" class="field-label text-muted fs18 mb10">员工密码</label>
                                <label for="password" class="field prepend-icon">
                                    <input type="password" name="password" id="password" class="gui-input" placeholder="请输入员工密码" onblur="checkPassword();" value="000000">
                                    <label for="password" class="field-icon">
                                        <i class="fa fa-lock"></i>
                                    </label>
                                </label>
                            </div>
                            <div class="section">
                                <label for="code" class="field-label text-muted fs18 mb10">验证码</label>
                                <input type="text" id="code"  name="code" class="form-control" placeholder="验证码" onblur="checkCode()" >
                            </div>
                            <div class="section">
                                <img id="captchaImg" style="CURSOR: pointer" onclick="changeCaptcha()"
                                     title="看不清楚？请点击刷新验证码!" align='absmiddle' src="captchaServlet"
                                     height="18" width="55">
                                <a href="javascript:;"
                                   onClick="changeCaptcha()" style="color: #666;">看不清楚</a> <span id="code_span" style="color: red"></span>
                            </div>
                            <div class="section">
                                <span style="color: red" id="errMsg">${error}</span>
                            </div>
                        </div>
                        <div class="panel-footer clearfix">
                            <button type="submit" class="button btn-primary mr10 pull-right" onclick="return normal_login();">登陆</button>
                            <label class="switch ib switch-primary mt10">
                                <input type="checkbox" name="remember" id="remember" checked="true">
                                <label for="remember" data-on="是" data-off="否"></label>
                                <span>记住我</span>
                            </label>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </section>
</div>
<script src="vendor/jquery/jquery-1.11.1.min.js"></script>
<script src="vendor/jquery/jquery_ui/jquery-ui.min.js"></script>
<script src="assets/js/utility/utility.js"></script>
<script src="assets/js/demo/demo.js"></script>
<script src="assets/js/main.js"></script>
<script>
    //校验用户名
    function checkSn() {
        $("#errMsg").text("");
        var sn = $("#sn").val();
        if(sn.replace(/^\s+|\s+$/g,"") == ""){
            $("#errMsg").text("请输入用户名！").css("color","red");
            return false;
        }else{
            $("#errMsg").text("").css("color","green");
            return true;
        }
    }
    //校验密码
    function checkPassword() {
        $("#errMsg").text("");
        var password = $("#password").val();
        if (password.replace(/^\s+|\s+$/g, "") == "") {
            $("#errMsg").text("请输入密码！").css("color", "red");
            return false;
        }
        if (password.length < 6) {
            $("#errMsg").text("密码长度少于6位，请重新输入！").css("color", "red");
            return false;
        }

        $("#errMsg").text("").css("color", "green");
        return true;
    }
    //更换验证码
    function changeCaptcha() {
        $("#captchaImg").attr('src', 'captchaServlet?t=' + (new Date().getTime()));
    }

    //验证码校验
    var flag_c = false;
    function checkCode() {
        $("#errMsg").text("");
        var code = $("#code").val();
        code = code.replace(/^\s+|\s+$/g,"");
        if(code == ""){
            $("#code_span").text("请输入验证码！").css("color","red");
            flag_c = false;
        }else{
            $.ajax({
                type: 'post',
                url: 'login_checkCode',
                data: {"code": code},
                dataType: 'json',
                success: function (data) {
                    var val = data['message'];
                    if (val == "success") {
                        $("#code_span").text("√").css("color","green");
                        flag_c = true;
                    }else {
                        $("#code_span").text("验证码错误！").css("color","red");
                        flag_c = false;
                    }
                }
            });

        }
        return flag_c;
    }

    function normal_login() {
        if(checkSn() && checkPassword() && checkCode()) {
            return true;
        } else {
            return false;
        }
    }
</script>
</body>
</html>
