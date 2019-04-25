<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 查看通知 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <form:form id="admin-form" name="addForm" action="/read" modelAttribute="informRecord">
                    <form:hidden path="informId"/>
                    <div class="panel-body bg-light">
                        <div class="section-divider mt20 mb40">
                            <span> 通知信息 </span>
                        </div>
                        <div class="section row">
                            <div class="col-md-4 text-center">
                                <img src="/avatars/inform.png" width="128" alt="avatars" class="img-thumbnail avatars"/>
                            </div>
                            <div class="col-md-8">
                                <div class="section row">
                                    <div class="col-md-6">
                                        发布人：${informRecord.inform.creater.name}
                                    </div>
                                    <div class="col-md-6">
                                        所属部门：${informRecord.inform.department.name}
                                    </div>
                                </div>
                                <div class="section row">
                                    <div class="col-md-12">
                                        发布时间：<spring:eval expression="informRecord.inform.createTime"/>
                                    </div>
                                </div>
                                <div class="section row">
                                    <div class="col-md-12">
                                        通知内容：<br/><br/>${informRecord.inform.informContent}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <c:if test="${informRecord.id==null}">
                            <button type="submit" class="button">确认查看</button>
                        </c:if>
                        <button type="button" class="button" onclick="javascript:window.history.go(-1);"> 返回 </button>
                    </div>
                </form:form>
            </div>

        </div>
    </div>
</section>

<jsp:include page="bottom.jsp"/>