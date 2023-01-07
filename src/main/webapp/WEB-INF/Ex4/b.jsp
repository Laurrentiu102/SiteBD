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
    <h1>Să se găsească perechi de contracte juridice (id_cj1, id_cj2) pentru clienți diferiți dar același avocat. O pereche este unică în rezultat.</h1>
</div>
<div class="form-center">
    <form>
        <p>
            <label for="idAvocat">Id avocat:</label>
            <input type="text" name="idAvocat" id="idAvocat">
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
        var an = document.getElementById("idAvocat").value;
        document.getElementById('singurulIframe').src = "${pageContext.request.contextPath}/manageTableS?ex=4b&idAvocat=" + an;
    }
</script>
</body>
</html>
