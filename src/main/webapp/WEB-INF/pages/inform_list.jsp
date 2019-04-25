<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 通知列表 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel  heading-border">
                <div class="panel-menu">
                    <div class="row">
                        <div class="hidden-xs hidden-sm col-md-3">
                            <div class="btn-group">
                                <ul class="pagination">
                                    <li><a class="btn btn-default light"><i class="fa fa-refresh" onclick="javascript:window.location.href='/inform/list';"></i></a></li>
                                    <li><a class="btn btn-default light"><i class="fa fa-trash" id="delete_all"></i></a></li>
                                    <li><a class="btn btn-default light"><i class="fa fa-plus" onclick="javascript:window.location.href='/inform/to_add';"></i></a></li>
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
                                        <c:if test="${text!=null}">
                                            <li><a href="/inform/list?searchText=${text}">首页</a></li>
                                            <li><a href="/inform/list?pn=${pageInfo.pageNum-1}&searchText=${text}"><i class="fa fa-chevron-left"></i></a></li>
                                        </c:if>
                                        <c:if test="${text==null}">
                                            <li><a href="/inform/list">首页</a></li>
                                            <li><a href="/inform/list?pn=${pageInfo.pageNum-1}"><i class="fa fa-chevron-left"></i></a></li>
                                        </c:if>
                                    </c:if>
                                    <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                        <c:if test="${pageInfo.pageNum == num}">
                                            <li class="active"><a>${num}</a></li>
                                        </c:if>
                                        <c:if test="${pageInfo.pageNum != num}">
                                            <c:if test="${text!=null}">
                                                <li><a href="/inform/list?pn=${num}&searchText=${text}">${num}</a></li>
                                            </c:if>
                                            <c:if test="${text==null}">
                                                <li><a href="/inform/list?pn=${num}">${num}</a></li>
                                            </c:if>

                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${pageInfo.hasNextPage == false}">
                                        <li class="disabled"><a><i class="fa fa-chevron-right"></i></a></li>
                                        <li class="disabled"><a href="#">末页</a></li>
                                    </c:if>
                                    <c:if test="${pageInfo.hasNextPage}">
                                        <c:if test="${text!=null}">
                                            <li><a href="/inform/list?pn=${pageInfo.pageNum+1}&searchText=${text}"><i class="fa fa-chevron-right"></i></a></li>
                                            <li><a href="/inform/list?pn=${pageInfo.pages}&searchText=${text}">末页</a></li>
                                        </c:if>
                                        <c:if test="${text==null}">
                                            <li><a href="/inform/list?pn=${pageInfo.pageNum+1}"><i class="fa fa-chevron-right"></i></a></li>
                                            <li><a href="/inform/list?pn=${pageInfo.pages}">末页</a></li>
                                        </c:if>

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
                            <th>编号</th>
                            <th>创建人</th>
                            <th>所属部门</th>
                            <th>创建时间</th>
                            <th>通知内容</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" var="inform">
                        <tr class="message-unread">
                            <td class="hidden-xs">
                                <label class="option block mn">
                                    <input type="checkbox" class="check_item">
                                    <span class="checkbox mn"></span>
                                </label>
                            </td>
                            <td>${inform.id}</td>
                            <td>${inform.creater.name}</td>
                            <td>${inform.department.name}</td>
                            <td><spring:eval expression="inform.createTime"/></td>
                            <td title="${inform.informContent}">
                                <c:set var="datenow" value="<%=System.currentTimeMillis()%>" />
                                <c:if test="${(datenow-inform.createTime.time)<=86400000}">
                                    <span class="badge badge-danger mr10">new</span>
                                </c:if>
                                <c:if test="${fn:length(inform.informContent)>20}">
                                    ${fn:substring(inform.informContent, 0, 20)}...
                                </c:if>
                                <c:if test="${fn:length(inform.informContent)<=20}">
                                    ${inform.informContent}
                                </c:if>
                            </td>
                            <td class="text-center">
                                <a href="/inform/to_update?id=${inform.id}">编辑</a>
                                <a href="/inform/remove?id=${inform.id}" onclick="return conf();">删除</a>
                                <a href="/inform/detail?id=${inform.id}">通知详情</a>
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
                            <form class="form-inline" action="/inform/list">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="searchText" name="searchText" placeholder="请输入要查询的内容，支持模糊查询...">
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
        var del_ids = "";
        $.each($(".check_item:checked"),function(){
            //组装通知id字符串
            del_ids += $(this).parents("tr").find("td:eq(1)").text()+",";
        });
        //去除删除的id多余的,
        del_ids = del_ids.substring(0, del_ids.length-1);
        if(confirm("确认删除所选记录吗？")){
            window.location.href="/inform/remove?id=" + del_ids;
        }
    });
</script>
</body>
</html>


