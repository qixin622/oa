<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="top.jsp"/>
<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 添加通知 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <form:form action="/inform/add" modelAttribute="inform"  id="admin-form" name="addForm">
                    <div class="panel-body bg-light">
                        <div class="section-divider mt20 mb40">
                            <span> 通知信息 </span>
                        </div>
                        <div class="section">
                            <label for="informContent" class="field prepend-icon">
                                <form:input path="informContent" cssClass="gui-input" placeholder="请输入通知信息..." onblur="validate_content();"/>
                                <span class="help-block"></span>
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

    function validate_content(){

        var informContent = $("#informContent").val();
        if(informContent.length===0){
            //应该清空这个元素之前的样式
            show_validate_msg("#informContent", "error", "请输入通知内容");
            return false;
        }else{
            show_validate_msg("#informContent", "success", "");
            return true;
        }
    }


    function validate_add_form(){
        if(validate_content()) {
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