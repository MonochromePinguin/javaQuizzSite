<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
    succefully passed automaticaly-corrected quizz page for candidate. just give them access to other pages.
• accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_localy used:
    quizzName
    successPercentage
--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>${fn:escapeXml(requestScope.pageTitle)}</title>
    <meta name="description" content="quizzSchool Web learning – quizz page">
    <meta name="keywords" content="school, learning, quizz">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/buttons.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
</head>

<body>
    <%@include file="/WEB-INF/views/common/header.jsp"%>

    <aside class="about-part border-margin-1rem">
        <h3 class="about-title">
            You had a <span class="about-em">${successPercentage}%</span> success rate on the quizz "${fn:escapeXml(requestScope.quizzName)}".
        </h3>
    </aside>

    <main>
        <p>
            One of these day, you'll see here a "see correction button" and a "register" button too. Once I have the time ;-).
        </p>
    </main>

</body>
</html>