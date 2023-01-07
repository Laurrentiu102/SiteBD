<%--
  Created by IntelliJ IDEA.
  User: LAUR
  Date: 05-Jan-23
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Resurse/styleExercitii.css">
    <style>
    </style>
</head>
<body>
<table>
    <thead>
    <tr>
        <c:forEach items="${rows[0]}" var="column">
            <th><c:out value="${column.key}"/></th>
        </c:forEach></tr>
    </thead>
    <tbody>
    <c:forEach items="${rows}" var="columns">
        <tr>
            <c:forEach items="${columns}" var="column">
                <td><c:out value="${column.value}"/></td>
            </c:forEach></tr>
    </c:forEach></tbody>
</table>
</body>
</html>
