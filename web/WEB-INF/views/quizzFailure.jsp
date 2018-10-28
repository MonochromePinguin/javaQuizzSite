<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
quizz fail page – used to tell the candidate/student they fail.
• accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_localy used:
    quizzName,
    winMinPercentage    minimum required percentage of correctly answered questions to pass the test.
    successPercentage   percentage of correctly answered questions.
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

<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>

<aside class="about-part border-margin-1rem">
    <p class="about-text">
        You had a <span class="about-em">${successPercentage}%</span>
        success rate, which is not enough to pass the quizz "${fn:escapeXml(requestScope.quizzName)},"
        while ${minWinPercentage}% is required.
    </p>
    <p class="about-text">
        Train more, and try again later!
    </p>
</aside>

</body>
</html>