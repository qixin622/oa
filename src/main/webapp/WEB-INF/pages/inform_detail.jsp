<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="top.jsp"/>

<section id="content" class="table-layout animated fadeIn">
    <div class="tray tray-center">
        <div class="content-header">
            <h2> 通知详情 </h2>
            <p class="lead"></p>
        </div>
        <div class="admin-form theme-primary mw1000 center-block">
            <div class="panel heading-border">
                <div class="panel-body bg-light">
                    <div class="section-divider mt20 mb40">
                        <span> 通知信息 </span>
                    </div>
                    <div class="section row">
                        <div class="col-md-4 text-center">
                            <img src="/avatars/${employee.imgUrl}" alt="avatars" class="img-thumbnail avatars"/>
                        </div>
                        <div class="col-md-8">
                            <div class="section row">
                                <div class="col-md-6">
                                    发布人：${informInfo.inform.creater.name}
                                </div>
                                <div class="col-md-6">
                                    所属部门：${informInfo.inform.creater.department.name}
                                </div>
                            </div>
                            <div class="section row">
                                <div class="col-md-12">
                                    发布时间：<spring:eval expression="informInfo.inform.createTime"/>
                                </div>
                            </div>
                            <div class="section row">
                                <div class="col-md-12">
                                    通知内容：<br/><br/>${informInfo.inform.informContent}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="section-divider mt20 mb40">
                        <span> 查看记录 </span>
                    </div>
                    <div class="section row">
                        <table id="message-table" class="table admin-form theme-warning tc-checkbox-1">
                            <thead>
                            <tr>
                                <th class="text-center">编号</th>
                                <th class="text-center">姓名</th>
                                <th class="text-center">性别</th>
                                <th class="text-center">所属部门</th>
                                <th class="text-center">阅读时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${informInfo.informRecords}" var="record">
                                <tr class="message-unread">
                                    <td class="text-center">${record.reader.sn}</td>
                                    <td class="text-center">${record.reader.name}</td>
                                    <td class="text-center">${record.reader.sex}</td>
                                    <td class="text-center">${informInfo.inform.department.name}</td>
                                    <td class="text-center"><spring:eval expression="record.readTime"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="panel-footer">

                    <div class="section row text-center">
                        <button type="button" class="button" onclick="javascript:window.history.go(-1);"> 返回 </button>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<jsp:include page="bottom.jsp"/>