<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 个人信息 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block" style="padding-bottom: 175px;">
            <div class="panel heading-border">
                <div class="panel-body bg-light">
                    <div class="section-divider mt20 mb40">
                        <span> 基本信息 </span>
                    </div>
                    <div class="section row">
                        <div class="col-md-4 text-center">
                            <img src="/avatars/${employee.imgUrl}" alt="avatars" class="img-thumbnail avatars"/>
                        </div>
                        <div class="col-md-8">
                            <div class="section row">
                                <div class="col-md-6">
                                    职工编号：${employee.sn}
                                </div>
                                <div class="col-md-6">
                                    职工姓名：${employee.name}
                                </div>
                            </div>
                            <div class="section row">
                                <div class="col-md-6">
                                    所属部门：${employee.department.name}
                                </div>
                                <div class="col-md-6">
                                    行政职务：${employee.post}
                                </div>
                            </div>
                            <div class="section row">
                                <div class="col-md-6">
                                    出生日期：<spring:eval expression="employee.birthday"/>
                                </div>
                                <div class="col-md-6">
                                    性别：${employee.sex}
                                </div>
                            </div>
                            <div class="section row">
                                <div class="col-md-6">
                                    角色：
                                    <c:if test="${employee.role == '1'}">
                                        系统管理员
                                    </c:if>
                                    <c:if test="${employee.role == '0'}">
                                        普通用户
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    最高学历：${employee.qualification}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="bottom.jsp"/>