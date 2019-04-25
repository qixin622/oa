<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="top.jsp"/>
<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 添加职工信息 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <form:form action="/employee/add" modelAttribute="employee"  id="admin-form" name="addForm">
                    <div class="panel-body bg-light">
                        <div class="section-divider mt20 mb40">
                            <span> 基本信息 </span>
                        </div>
                        <div class="section row">
                            <div class="col-md-2 text-center">
                                <img src="/avatars/1.jpg" alt="avatars" class="img-thumbnail avatars"/>
                            </div>
                            <div class="col-md-10">
                                <div class="section row">
                                    <div class="col-md-6">
                                        <label for="sn" class="field prepend-icon">
                                            <form:input path="sn" cssClass="gui-input" placeholder="职工编号..." onblur="validate_sn();"/>
                                            <span class="help-block"></span>
                                            <label for="sn" class="field-icon">
                                                <i class="fa fa-user"></i>
                                            </label>
                                        </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="name" class="field prepend-icon">
                                            <form:input path="name" class="gui-input" placeholder="职工姓名..." onblur="validate_name();"/>
                                            <span class="help-block"></span>
                                            <label for="name" class="field-icon">
                                                <i class="fa fa-user"></i>
                                            </label>
                                        </label>
                                    </div>
                                </div>
                                <div class="section row">
                                    <div class="col-md-6">
                                        <label for="departmentSn" class="field select">
                                            <form:select path="departmentSn" items="${dlist}" itemLabel="name" itemValue="sn" cssClass="gui-input" placeholder="所属部门..."/>
                                            <i class="arrow double"></i>
                                        </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="birthday" class="field prepend-icon">
                                            <input id="birthday" name="birthday" class="gui-input" placeholder="出生日期..." data-provide="datepicker" readonly="true"/>
                                            <label for="birthday" class="field-icon">
                                                <i class="fa fa-user"></i>
                                            </label>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="section row">
                            <div class="col-md-4">
                                <label for="sex" class="field select">
                                    <form:select path="sex" cssClass="gui-input" placeholder="性别...">
                                        <form:option value="男">男</form:option>
                                        <form:option value="女">女</form:option>
                                    </form:select>
                                    <i class="arrow double"></i>
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label for="post" class="field select">
                                    <form:select path="post" items="${plist}" cssClass="gui-input" placeholder="行政职务..."/>
                                    <i class="arrow double"></i>
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label for="qualification" class="field select">
                                    <form:select path="qualification" items="${qlist}" cssClass="gui-input" placeholder="最高学历..."/>
                                    <i class="arrow double"></i>
                                </label>
                            </div>
                        </div>
                        <div class="section row">
                            <div class="col-md-4">
                                <label for="imgUrl" class="field select">
                                    <form:select path="imgUrl" items="${imglist}" cssClass="gui-input" placeholder="头像..."/>
                                    <i class="arrow double"></i>
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label for="role" class="field select">
                                    <form:select path="role" cssClass="gui-input" placeholder="角色...">
                                        <form:option value="0">角色：普通用户</form:option>
                                        <form:option value="1">角色：系统管理员</form:option>
                                    </form:select>
                                    <i class="arrow double"></i>
                                </label>
                            </div>
                        </div>
                        <div class="panel-footer text-right">
                            <button type="submit" class="button" id="emp_save_btn" onclick="return validate_add_form();"> 保存 </button>
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
<script src="/vendor/plugins/datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="/vendor/plugins/datepicker/js/locales/bootstrap-datepicker.zh-CN.min.js" charset="UTF-8"></script>
<script src="/assets/js/utility/utility.js"></script>
<script src="/assets/js/demo/demo.js"></script>
<script src="/assets/js/main.js"></script>
<script type="text/javascript" src="/js/pages.js"></script>
<script>
    $(document).ready(function(){
        $("#birthday").datepicker({
            language: 'zh-CN',
            startDate: '-3d',
            autoclose: true,
            todayHighlight: true,
            endDate : new Date(),
            startDate: new Date('1900-1-1')
        });
        $("#imgUrl").change(
            function() {
                $(".avatars").attr("src","/avatars/"+$(this).val());
            }
        );
    });
    //校验表单数据
    function validate_sn(){
        //1、拿到要校验的数据，使用正则表达式
        var sn = $("#sn").val();
        var regSn = /(^[0-9]{6}$)/;
        if(!regSn.test(sn)){
            show_validate_msg("#sn", "error", "职工编号为6位数字");
            return false;
        }else{
            show_validate_msg("#sn", "success", "");
        };
        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"/employee/checkSn",
            data:"sn="+sn,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#sn","success","职工编号可用");
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

        //2、校验职工姓名
        var name = $("#name").val();
        var regName = /(^[\u2E80-\u9FFF]{2,5}$)/;
        if(!regName.test(name)){
            //应该清空这个元素之前的样式
            show_validate_msg("#name", "error", "职工姓名是2-5位中文");
            return false;
        }else{
            show_validate_msg("#name", "success", "");
            return true;
        }
    }

    function validate_add_form(){
        if(validate_sn() && validate_name()) {
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