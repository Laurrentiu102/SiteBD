<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <h1>Să se găsească detaliile pentru contractele de asistență juridică din luna octombrie 2022 ce au onorar cuprins între 900 și 1500 în ordine crescătoare a datei.</h1>
</div>
<div class="form-center">
    <form>
        <p>
            <label for="onorarMin">Onorar minim: </label>
            <input type="text" name="onorarMin" id="onorarMin">
        </p>
        <p>
            <label for="onorarMax">Onorar maxim: </label>
            <input type="text" name="onorarMax" id="onorarMax">
        </p>
        <p>
            <label for="an">Anul:</label>
            <input type="text" name="an" id="an">
        </p>
        <p>
            <label for="luna">Luna:</label>
            <select name="selectLuna" id="luna">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
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
        var onorarMin = document.getElementById("onorarMin").value;
        var onorarMax = document.getElementById("onorarMax").value;
        var an = document.getElementById("an").value;
        var luna = document.getElementById("luna").value;
        document.getElementById('singurulIframe').src = "${pageContext.request.contextPath}/manageTableS?ex=3a&onorarMin=" + onorarMin + "&onorarMax=" + onorarMax + "&an=" + an + "&luna=" + luna;
    }
</script>
</body>
</html>
