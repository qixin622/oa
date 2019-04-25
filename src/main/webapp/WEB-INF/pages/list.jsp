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
                                    <li><a class="btn btn-default light"><i class="fa fa-refresh" onclick="javascript:window.location.href='/list';"></i></a></li>
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
                                        <li><a href="/list">首页</a></li>
                                        <li><a href="/list?pn=${pageInfo.pageNum-1}"><i class="fa fa-chevron-left"></i></a></li>
                                    </c:if>
                                    <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                        <c:if test="${pageInfo.pageNum == num}">
                                            <li class="active"><a>${num}</a></li>
                                        </c:if>
                                        <c:if test="${pageInfo.pageNum != num}">
                                            <li><a href="/list?pn=${num}">${num}</a></li>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${pageInfo.hasNextPage == false}">
                                        <li class="disabled"><a><i class="fa fa-chevron-right"></i></a></li>
                                        <li class="disabled"><a href="#">末页</a></li>
                                    </c:if>
                                    <c:if test="${pageInfo.hasNextPage}">
                                        <li><a href="/list?pn=${pageInfo.pageNum+1}"><i class="fa fa-chevron-right"></i></a></li>
                                        <li><a href="/list?pn=${pageInfo.pages}">末页</a></li>
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
                            <th>创建人</th>
                            <th>所属部门</th>
                            <th>创建时间</th>
                            <th>通知内容</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" var="inform">
                            <tr class="message-unread">
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
                                <td>
                                    <a href="/to_read?id=${inform.id}">查看通知</a>
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
</body>
</html>


