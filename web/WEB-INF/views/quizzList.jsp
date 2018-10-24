<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- accepted attributes :
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
    <main class="list-containe border-margin-1rem">

        <c:forEach items="${themeList}" var="theme">

            <div class="list-of-theme">
                <p class="theme-title">${fn:escapeXml(theme.name)}</p>

                <c:if test="${not empty theme.name}">
                    <p class="theme-about">${fn:escapeXml(theme.description)}</p>
                </c:if>

                <%--inner quizz-list loop--%>
                <c:forEach items="${theme.quizzList}" var="quizz">
                    <div class="list-of-item">
                        <a class="btn btn-secondary" href="/entryQuizz/${fn:escapeXml(quizz.slug)}"
                            title="go to quizz «${fn:escapeXml(quizz.name)}" >GO!</a>

                        <p class="item-title">${fn:escapeXml(quizz.name)}</p>
                    </div>
                </c:forEach>

            </div>

        </c:forEach>
    </main>

</body>
</html>
