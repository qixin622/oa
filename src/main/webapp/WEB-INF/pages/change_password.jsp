<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 修改密码 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <form method="post" action="change_password" id="admin-form">
                    <div class="panel-body bg-light">
                        <div class="section-divider mt20 mb40">
                            <span> 基本信息 </span>
                        </div>
                        <div class="section row">
                            <div class="col-md-6">
                                <label for="old" class="field prepend-icon">
                                    <input type="password" name="old" id="old" class="gui-input" placeholder="原始密码..." onblur="validate_old();">
                                    <span class="help-block"></span>
                                    <label for="old" class="field-icon">
                                        <i class="fa fa-lock"></i>
                                    </label>
                                </label>
                            </div>
                        </div>
                        <div class="section row">
                            <div class="col-md-6">
                                <label for="new1" class="field prepend-icon">
                                    <input type="password" name="new1" id="new1" class="gui-input" placeholder="新密码...">
                                    <span class="help-block"></span>
                                    <label for="new1" class="field-icon">
                                        <i class="fa fa-lock"></i>
                                    </label>
                                </label>
                            </div>
                            <div class="col-md-6">
                                <label for="new2" class="field prepend-icon">
                                    <input type="password" name="new2" id="new2" class="gui-input" placeholder="重复新密码...">
                                    <span class="help-block"></span>
                                    <label for="new2" class="field-icon">
                                        <i class="fa fa-lock"></i>
                                    </label>
                                </label>
                            </div>
                        </div>
                        <div class="panel-footer text-right">
                            <button type="submit" class="button" onclick="return validate_pwd_form();"> 修改 </button>
                            <button type="button" class="button" onclick="javascript:window.history.go(-1);"> 返回 </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>


</section>
</div>
<script src="/vendor/jquery/jquery-1.11.1.min.js"></script>
<script src="/vendor/jquery/jquery_ui/jquery-ui.min.js"></script>
<script src="/assets/admin-tools/admin-forms/js/jquery.validate.min.js"></script>
<script src="/assets/admin-tools/admin-forms/js/additional-methods.min.js"></script>
<script src="/assets/admin-tools/admin-forms/js/jquery-ui-datepicker.min.js"></script>
<script src="/assets/js/utility/utility.js"></script>
<script src="/assets/js/demo/demo.js"></script>
<script src="/assets/js/main.js"></script>
<script type="text/javascript" src="/js/pages.js"></script>
<script type="text/javascript" src="/js/items.js"></script>
<script>

    //判断字符是否为空的方法
    function isEmpty(obj){
        if(typeof obj == "undefined" || obj == null || obj == ""){
            return true;
        }else{
            return false;
        }
    }
    //校验表单数据
    function validate_old(){
        //1、拿到要校验的数据，使用正则表达式
        var old = $("#old").val();
        if(isEmpty(old)){
            show_validate_msg("#old", "error", "请输入原始密码");
            return false;
        }else{
            show_validate_msg("#old", "success", "");
        };
        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"/checkOldPassword",
            data:"old="+old,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#old","success","密码正确");
                    return true;
                }else{
                    show_validate_msg("#old","error",result.data.va_msg);
                    return false;
                }
            }
        });
        return true;
    }

    function validate_new1(){

        var new1 = $("#new1").val();
        if(isEmpty(new1)) {
            show_validate_msg("#new1", "error", "请输入新密码");
            return false;
        }
        if(new1.length<6){
            show_validate_msg("#new1", "error", "新密码不少于6位");
            return false;
        }else{
            show_validate_msg("#new1", "success", "");
            return true;
        }
    }

    function validate_new2(){

        var new1 = $("#new1").val();
        var new2 = $("#new2").val();
        if(isEmpty(new1)) {
            show_validate_msg("#new2", "error", "请先输入新密码");
            return false;
        }
        if(new2.length<6) {
            show_validate_msg("#new2", "error", "重复密码不少于6位");
            return false;
        }
        if(new1!=new2){
            show_validate_msg("#new2", "error", "重复密码与新密码不符");
            return false;
        }else{
            show_validate_msg("#new2", "success", "");
            return true;
        }
    }

    function validate_pwd_form(){
        if(validate_old() && validate_new1() && validate_new2()) {
            return true;
        } else {
            return false;
        }
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("state-success state-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("state-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("state-error");
            $(ele).next("span").text(msg);
        }
    }

</script>
</body>
</html>