<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
Localy used attributes:
    titleIntro?
    title
    subtitle?
--%>

<header class="header">

    <navbar>
        <ul class="main-navbar menubar">
            <li>
                <p>TODO: Put here the navbar content : links, buttons</p>
            </li>
        </ul>
    </navbar>

    <h1 class="main-title border-margin-1rem">
        <c:if test="${not empty titleIntro}">
            <span class="main-title-intro">${titleIntro}</span>
            <br>
        </c:if>
        ${title}
    </h1>

    <c:if test="${not empty subtitle}">
        <h2 class="main-subtitle border-margin-1rem">${subtitle}</h2>
    </c:if>

</header>