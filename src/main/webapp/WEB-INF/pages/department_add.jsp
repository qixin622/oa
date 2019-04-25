<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="top.jsp"/>
<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 添加部门 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <form:form action="/department/add" modelAttribute="department"  id="admin-form" name="addForm">
                    <div class="panel-body bg-light">
                        <div class="section-divider mt20 mb40">
                            <span> 基本信息 </span>
                        </div>
                        <div class="section row">
                            <div class="col-md-6">
                                <label for="sn" class="field prepend-icon">
                                    <form:input path="sn" cssClass="gui-input" placeholder="部门编号..." onblur="validate_sn();"/>
                                    <span class="help-block"></span>
                                    <label for="sn" class="field-icon">
                                        <i class="fa fa-user"></i>
                                    </label>
                                </label>
                            </div>
                            <div class="col-md-6">
                                <label for="name" class="field prepend-icon">
                                    <form:input path="name" cssClass="gui-input" placeholder="部门名称..." onblur="validate_name();"/>
                                    <span class="help-block"></span>
                                    <label for="name" class="field-icon">
                                        <i class="fa fa-user"></i>
                                    </label>
                                </label>
                            </div>
                        </div>
                        <div class="section">
                            <label for="address" class="field prepend-icon">
                                <form:input path="address" cssClass="gui-input" placeholder="部门地址..." onblur="validate_address();"/>
                                <span class="help-block"></span>
                                <label for="address" class="field-icon">
                                    <i class="fa fa-lock"></i>
                                </label>
                            </label>
                        </div>
                        <div class="panel-footer text-right">
                            <button type="submit" class="button" onclick="return validate_add_form();"> 保存 </button>
                            <button type="button" class="button" onclick="javascript:window.history.go(-1);"> 返回 </button>
                        </div>
                    </div>
                </form:form>
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
<script>

    //校验表单数据
    function validate_sn(){
        //1、拿到要校验的数据，使用正则表达式
        var sn = $("#sn").val();
        var regSn = /(^[0-9]{3}$)/;
        if(!regSn.test(sn)){
            show_validate_msg("#sn", "error", "部门编号为3位数字");
            return false;
        }else{
            show_validate_msg("#sn", "success", "");
        };
        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"/department/checkSn",
            data:"sn="+sn,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#sn","success","部门编号可用");
                    return true;
                }else{
                    show_validate_msg("#sn","error",result.data.va_msg);
                    return false;
                }
            }
        });
        return true;
    }

    function validate_name(){

        //2、校验部门名称
        var name = $("#name").val();
        if(name.length===0){
            //应该清空这个元素之前的样式
            show_validate_msg("#name", "error", "请输入部门名称");
            return false;
        }else{
            show_validate_msg("#name", "success", "");
            return true;
        }
    }

    function validate_address(){

        //3、校验部门地址
        var address = $("#address").val();
        if(address.length===0){
            //应该清空这个元素之前的样式
            show_validate_msg("#address", "error", "请输入部门名称");
            return false;
        }else{
            show_validate_msg("#address", "success", "");
            return true;
        }
    }

    function validate_add_form(){
        if(validate_sn() && validate_name() && validate_address()) {
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