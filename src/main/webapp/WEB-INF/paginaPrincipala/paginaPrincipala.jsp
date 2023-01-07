<%--
  Created by IntelliJ IDEA.
  User: LAUR
  Date: 03-Jan-23
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SiteBD</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Resurse/stylePaginaPrincipala.css">
    <style>

    </style>
</head>
<body>
<div class="sidenav">
    <div class="profile">
        <img src="${pageContext.request.contextPath}/Resurse/user_icon_default.png"
             alt="profile_picture">
        <h3>${email}</h3>
        <p>${functie}</p>
    </div>
    <button class="dropdown-btn"><i class="fa fa-bars" aria-hidden="true" style="padding-right: 4px"></i>Cerinta 3
        <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-container">
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul a</a>
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul b</a>
    </div>
    <button class="dropdown-btn"><i class="fa fa-bars" aria-hidden="true" style="padding-right: 4px"></i>Cerinta 4
        <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-container">
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul a</a>
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul b</a>
    </div>
    <button class="dropdown-btn"><i class="fa fa-bars" aria-hidden="true" style="padding-right: 4px"></i>Cerinta 5
        <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-container">
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul a</a>
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul b</a>
    </div>
    <button class="dropdown-btn"><i class="fa fa-bars" aria-hidden="true" style="padding-right: 4px"></i>Cerinta 6
        <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-container">
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul a</a>
        <a href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>Subpunctul b</a>
    </div>
</div>
<iframe id="singurulIframe" src="${pageContext.request.contextPath}/manageTableS?ex=nimic"  scrolling="no" style="position: fixed;overflow: hidden;border: none;margin-left: 11.71%;width: 88.29%;height: 100%" ></iframe>

<script>
    const links = ["${pageContext.request.contextPath}/exercitiiS?ex=3a", "${pageContext.request.contextPath}/exercitiiS?ex=3b",
                   "${pageContext.request.contextPath}/exercitiiS?ex=4a", "${pageContext.request.contextPath}/exercitiiS?ex=4b",
                   "${pageContext.request.contextPath}/exercitiiS?ex=5a","${pageContext.request.contextPath}/exercitiiS?ex=5b",
                   "${pageContext.request.contextPath}/exercitiiS?ex=6a","${pageContext.request.contextPath}/exercitiiS?ex=6b"];
    const linkGol ="${pageContext.request.contextPath}/manageTableS?ex=nimic";
    /* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
    var dropdown = document.getElementsByClassName("dropdown-btn");
    var i;

    for (i = 0; i < dropdown.length; i++) {
        dropdown[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var dropdownContent = this.nextElementSibling;
            if (dropdownContent.style.display === "block") {
                dropdownContent.style.display = "none";
            } else {
                dropdownContent.style.display = "block";
            }
        });
    }

    var link = document.getElementsByTagName("a");

    for (i = 0; i < link.length; i++) {
        link[i].setAttribute("link",links[i]);
        link[i].addEventListener("click", function() {
            for (i = 0; i < link.length; i++) {
                link[i].style.backgroundColor = "#054468FF";
                link[i].style.color = "white";
                link[i].style.borderRight = "2px solid rgb(5, 68, 104";
            }


            if(this.classList.contains("apasat")){
                this.classList.toggle("apasat");
                go(linkGol);
                this.style.backgroundColor = "#054468FF";
                this.style.color = "white";
                this.style.borderRight = "2px solid rgb(5, 68, 104";
            }else{
                for (i = 0; i < link.length; i++)
                    link[i].classList.remove("apasat");
                go(this.getAttribute("link"));
                this.classList.toggle("apasat");
                this.style.backgroundColor = "white";
                this.style.color = "#054468FF";
                this.style.borderRight = "2px solid white";
            }

        });
    }


    function go(loc) {
        document.getElementById('singurulIframe').src = loc;
    }
</script>

</body>
</html>
