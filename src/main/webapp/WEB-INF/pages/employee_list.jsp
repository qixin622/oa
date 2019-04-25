<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 员工列表 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel  heading-border">
                <div class="panel-menu">
                    <div class="row">
                        <div class="hidden-xs hidden-sm col-md-3">
                            <div class="btn-group">
                                <ul class="pagination">
                                    <li><a class="btn btn-default light"><i class="fa fa-refresh" onclick="javascript:window.location.href='/employee/list';"></i></a></li>
                                    <li><a class="btn btn-default light"><i class="fa fa-trash" id="delete_all"></i></a></li>
                                    <li><a class="btn btn-default light"><i class="fa fa-plus" onclick="javascript:window.location.href='/employee/to_add';"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-9 text-right">
                            <div class="btn-group">
                                <ul class="pagination">
                                    <c:if test="${pageInfo.hasPreviousPage == false}">
                                        <li class="disabled"><a href="#">首页</a></li>
                                        <li class="disabled"><a><i class="fa fa-chevron-left"></i></a></li>
                                    </c:if>
                                    <c:if test="${pageInfo.hasPreviousPage}">
                                        <li><a href="/employee/list">首页</a></li>
                                        <li><a href="/employee/list?pn=${pageInfo.pageNum-1}"><i class="fa fa-chevron-left"></i></a></li>
                                    </c:if>
                                    <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                        <c:if test="${pageInfo.pageNum == num}">
                                            <li class="active"><a>${num}</a></li>
                                        </c:if>
                                        <c:if test="${pageInfo.pageNum != num}">
                                            <li><a href="/employee/list?pn=${num}">${num}</a></li>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${pageInfo.hasNextPage == false}">
                                        <li class="disabled"><a><i class="fa fa-chevron-right"></i></a></li>
                                        <li class="disabled"><a href="#">末页</a></li>
                                    </c:if>
                                    <c:if test="${pageInfo.hasNextPage}">
                                        <li><a href="/employee/list?pn=${pageInfo.pageNum+1}"><i class="fa fa-chevron-right"></i></a></li>
                                        <li><a href="/employee/list?pn=${pageInfo.pages}">末页</a></li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body pn">
                    <table id="message-table" class="table admin-form theme-warning tc-checkbox-1">
                        <thead>
                        <tr class="">
                            <th class="text-center hidden-xs">
                                <label class="option block mn">
                                    <input type="checkbox" id="check_all"/>
                                    <span class="checkbox mn"></span>
                                </label>
                            </th>
                            <th>职工编号</th>
                            <th>职工姓名</th>
                            <th class="hidden-xs">所属部门</th>
                            <th>行政职务</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" var="emp">
                        <tr class="message-unread">
                            <td class="hidden-xs">
                                <label class="option block mn">
                                    <input type="checkbox" class="check_item">
                                    <span class="checkbox mn"></span>
                                </label>
                            </td>
                            <td>${emp.sn}</td>
                            <td>${emp.name}</td>
                            <td class="hidden-xs fw600">${emp.department.name}</td>
                            <td>
                                <span class="badge badge-warning mr10 fs11">${emp.post}</span>
                            </td>
                            <td>
                                <a href="/employee/to_update?sn=${emp.sn}">编辑</a>
                                <a href="/employee/remove?sn=${emp.sn}" onclick="return conf();">删除</a>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="col-md-4" style="line-height: 40px;">
                            当前第 <span class="badge"> ${pageInfo.pageNum} </span> 页,
                            共 <span class="badge"> ${pageInfo.pages} </span> 页,
                            共 <span class="badge"> ${pageInfo.total} </span> 条记录
                        </div>
                        <div class="col-md-8 text-right">
                            <form class="form-inline" action="/employee/list">
                                <div class="form-group">
                                    <select id="type" name="type" class="form-control">
                                        <option value="sn">职工号</option>
                                        <option value="name">姓名</option>
                                        <option value="dname">部门名称</option>
                                    </select>
                                    <input type="text" class="form-control" id="searchText" name="searchText" placeholder="支持模糊查询...">
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </form>
                        </div>
                    </div>
                </div>
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
    function conf(){
        if(confirm("确认删除这条记录吗？")){
            return true;
        } else {
            return false;
        }
    }

    //完成全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#delete_all").click(function(){
        if($(".check_item:checked").length===0)
        {
            alert("请选择要删除的数据!");
            return;
        }
        var empNames = "";
        var del_sns = "";
        $.each($(".check_item:checked"),function(){
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_sns += $(this).parents("tr").find("td:eq(1)").text()+",";
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length-1);
        //去除删除的id多余的-
        del_sns = del_sns.substring(0, del_sns.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            window.location.href="/employee/remove?sn=" + del_sns;
        }
    });
</script>
</body>
</html>


