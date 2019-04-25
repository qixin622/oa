<%@ page import="cn.edu.huat.oa.common.Contant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="top.jsp"/>
<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 待处理报销单 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel  heading-border">
                <div class="panel-menu">
                    <div class="row">
                        <div class="hidden-xs hidden-sm col-md-3">
                            <div class="btn-group">
                                <ul class="pagination">
                                    <li><a class="btn btn-default light"><i class="fa fa-refresh" onclick="javascript:window.location.href='/claim_voucher/deal';"></i></a></li>
                                    <li><a class="btn btn-default light"><i class="fa fa-plus" onclick="javascript:window.location.href='/claim_voucher/to_add';"></i></a></li>
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
                                        <li><a href="/claim_voucher/deal">首页</a></li>
                                        <li><a href="/claim_voucher/deal?pn=${pageInfo.pageNum-1}"><i class="fa fa-chevron-left"></i></a></li>
                                    </c:if>
                                    <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                                        <c:if test="${pageInfo.pageNum == num}">
                                            <li class="active"><a>${num}</a></li>
                                        </c:if>
                                        <c:if test="${pageInfo.pageNum != num}">
                                            <li><a href="/claim_voucher/deal?pn=${num}">${num}</a></li>
                                        </c:if>
                                    </c:forEach>

                                    <c:if test="${pageInfo.hasNextPage == false}">
                                        <li class="disabled"><a><i class="fa fa-chevron-right"></i></a></li>
                                        <li class="disabled"><a href="#">末页</a></li>
                                    </c:if>
                                    <c:if test="${pageInfo.hasNextPage}">
                                        <li><a href="/claim_voucher/deal?pn=${pageInfo.pageNum+1}"><i class="fa fa-chevron-right"></i></a></li>
                                        <li><a href="/claim_voucher/deal?pn=${pageInfo.pages}">末页</a></li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body pn">
                    <table id="message-table" class="table admin-form theme-warning tc-checkbox-1">
                        <thead>
                        <tr>
                            <th class="hidden-xs text-center">事由</th>
                            <th>状态</th>
                            <th class="hidden-xs">创建人</th>
                            <th class="hidden-xs">金额</th>
                            <th class="text-center">创建时间</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" var="cv">
                        <tr class="message-unread">
                            <td>${cv.cause}</td>
                            <td class="hidden-xs">
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_CREATED}">
                                    <span class="badge badge-primary">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_SUBMIT}">
                                    <span class="badge badge-info">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_APPROVED}">
                                    <span class="badge badge-system">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_BACK}">
                                    <span class="badge badge-danger">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_TERMINATED}">
                                    <span class="badge badge-dark">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_RECHECK}">
                                    <span class="badge badge-warning">${cv.status}</span>
                                </c:if>
                                <c:if test="${cv.status == Contant.CLAIMVOUCHER_PAID}">
                                    <span class="badge badge-success">${cv.status}</span>
                                </c:if>
                            </td>
                            <td>${cv.creater.name}</td>
                            <td class="fw600">${cv.totalAmount}</td>
                            <td class="text-center"><spring:eval expression="cv.createTime"/></td>
                            <td class="text-center">
                                <c:if test="${cv.status==Contant.CLAIMVOUCHER_CREATED || cv.status==Contant.CLAIMVOUCHER_BACK}">
                                    <a href="/claim_voucher/to_update?id=${cv.id}">修改</a>
                                    <a href="/claim_voucher/submit?id=${cv.id}" onclick="return conf();">提交</a>
                                </c:if>
                                <c:if test="${cv.status==Contant.CLAIMVOUCHER_SUBMIT || cv.status==Contant.CLAIMVOUCHER_RECHECK}">
                                    <a href="/claim_voucher/to_check?id=${cv.id}">审核</a>
                                </c:if>
                                <c:if test="${cv.status==Contant.CLAIMVOUCHER_APPROVED}">
                                    <a href="/claim_voucher/to_check?id=${cv.id}">打款</a>
                                </c:if>
                                <a href="/claim_voucher/detail?id=${cv.id}">详细信息</a>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <div class="row m20">
                        <div class="col-md-2">
                            <span>报销单状态图示：</span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-primary mr10"><%=Contant.CLAIMVOUCHER_CREATED%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-info mr10"><%=Contant.CLAIMVOUCHER_SUBMIT%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-system mr10"><%=Contant.CLAIMVOUCHER_APPROVED%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-danger mr10"><%=Contant.CLAIMVOUCHER_BACK%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-dark mr10"><%=Contant.CLAIMVOUCHER_TERMINATED%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-warning mr10"><%=Contant.CLAIMVOUCHER_RECHECK%></span>
                        </div>
                        <div class="col-xs-3 col-md-1">
                            <span class="badge badge-success mr10"><%=Contant.CLAIMVOUCHER_PAID%></span>
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
        if(confirm("确认提交吗？")){
            return true;
        } else {
            return false;
        }
    }

</script>
</body>
</html>