<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.format.FormatStyle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="formatter" value="${DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM)}" scope="application"/>

<%--
• quizz list page – quizzes are grouped by theme
• accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_localy used:
    pageTitle       used as page title

    aboutTitle      page description § title
    rawAboutText    the raw html source for the page description §

    themeList    a list of Theme, each of them containing a list of Quizz objects
--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>${fn:escapeXml(requestScope.pageTitle)}</title>
    <meta name="description" content="quizzSchool Web learning – entry quizz selection">
    <meta name="keywords" content="school, learning, quizz, inscription, test">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/buttons.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/list.css">
</head>

<body>
    <%@include file="/WEB-INF/views/common/header.jsp"%>

    <aside class="about-part border-margin-1rem">
        <h3 class="about-title">
            ${fn:escapeXml(requestScope.aboutTitle)}
        </h3>

        <div class="about-text">
            <%--TODO: replace it with serveral escaped-content paragraphs--%>
            ${rawAboutText}
        </div>
    </aside>

    <%--list of categories, each containing a list of quizzes--%>
    <main class="border-margin-1rem">

        <c:forEach items="${themeList}" var="theme">

            <div class="list">
                <p class="list-title">${fn:escapeXml(theme.name)}</p>

                <c:if test="${not empty theme.description}">
                    <p class="list-about">${fn:escapeXml(theme.description)}</p>
                </c:if>

                <div class="list-container">

                    <%--inner quizz-list loop--%>
                    <c:forEach items="${theme.quizzList}" var="quizz">
                        <div class="list-item">
                            <a class="btn btn-secondary" href="/entryQuizz/${fn:escapeXml(quizz.slug)}"
                                title="go to quizz «${fn:escapeXml(quizz.name)}" >GO</a>

                            <div class="list-content-vertic">
                                <p class="list-item-title">${fn:escapeXml(quizz.name)}</p>
                                <p class="list-about">last edit ${quizz.lastEditUtc.format(formatter)}</p>
                            </div>
                        </div>
                    </c:forEach>

                    <%--in case of empty list--%>
                    <c:if test="${empty theme.quizzList}">
                        <div class="warning list-item ">
                            <p>
                                There is no quizz inside this category.
                            </p>
                        </div> <%--div.warning.list-item--%>

                    </c:if>

                </div> <%--div.list-container--%>
            </div> <%--div.list--%>

        </c:forEach>

        <%--in case of empty theme list--%>
        <c:if test="${empty themeList}">
            <div class="list">
                <p class="list-title warning">Sorry...</p>
                <div class="list-about warning">
                    <p>It seems no quizz is present. No one.</p>
                    <p>Perhaps there is a problem in our servers.</p>
                    <p>Please try later.</p>
                </div>
            </div>
        </c:if>

    </main>

</body>
</html>
