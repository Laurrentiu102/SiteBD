<%--
  Created by IntelliJ IDEA.
  User: LAUR
  Date: 04-Jan-23
  Time: 22:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>titlu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Resurse/styleExercitii.css">
</head>
<body>
<div class="header-center">
    <h1>Să se găsească contractele de muncă cu același comision ca și alte contracte de muncă.</h1>
</div>
<div class="form-center">
    <button id="button" onclick="displayIframe()">Afiseaza</button>
</div>
<br>
<iframe id="singurulIframe" src="${pageContext.request.contextPath}/manageTableS?ex=nimic" scrolling="no"></iframe>

<script>
    function displayIframe() {
        document.getElementById('singurulIframe').src = "${pageContext.request.contextPath}/manageTableS?ex=5a";
    }
</script>
</body>
</html>
