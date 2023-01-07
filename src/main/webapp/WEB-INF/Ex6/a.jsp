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
    <h1>Să se găsească pentru fiecare nume de avocat valoarea medie a salariului pe anul 2022.</h1>
</div>
<div class="form-center">
    <form>
        <p>
            <label for="an">Anul:</label>
            <input type="text" name="an" id="an">
        </p>
        <p>
            <label for="functia">Functia:</label>
            <select name="functia" id="functia">
                <option value="angajat">angajat</option>
                <option value="avocat">avocat</option>
            </select>
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
        var an = document.getElementById("an").value;
        var functia = document.getElementById("functia").value;
        document.getElementById('singurulIframe').src = "${pageContext.request.contextPath}/manageTableS?ex=6a&functia=" + functia + "&an=" + an;
    }
</script>

</body>
</html>
