<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: LAUR
  Date: 04-Jan-23
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Resurse/styleExercitii.css">
</head>
<body>
<div class="header-center">
    <h1>Să se găsească detaliile contractelor de muncă pentru funcțiile ce încep cu litera 'a' în ordine descrescătoare a salariului de bază și crescătoare după funcție.</h1>
</div>
<div class="form-center">
    <form>
        <p>
            <label for="litera">Litera cu care sa inceapa functia:</label>
            <input type="text" name="litera" id="litera">
        </p>
    </form>
</div>
<div class="form-center">
    <button id="button" onclick="displayIframe()">Afiseaza</button>
</div>
<br>
<iframe id="singurulIframe" src="${pageContext.request.contextPath}/manageTableS?ex=nimic" scrolling="no"></iframe>

<script>
    function displayIframe() {
        var litera = document.getElementById("litera").value;
        document.getElementById('singurulIframe').src = "${pageContext.request.contextPath}/manageTableS?ex=3b&litera=" + litera;
    }
</script>
</body>
</html>
