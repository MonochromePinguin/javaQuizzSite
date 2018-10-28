<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
quizz incoherency page: shown when someone send POST data to quizz judged as "incoherent"
 (lacking related objects by example). Just show the title of the quizz, a small message and a link.
• accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_ localy used:
    goBackUrl   URL to embed into the "go back" button.
--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>quizzSchool – a technical problem has been detected</title>
    <meta name="description" content="quizzSchool Web learning – ugly error detected in a quizz">
    <meta name="keywords" content="school, learning, quizz">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/buttons.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
</head>

<body>
    <%@include file="/WEB-INF/views/common/header.jsp"%>

    <aside class="about-part border-margin-1rem">
        <div class="about-text warning">
            <p>Your submit can't just be corrected. Please try with another quizz, or try again later.</p>
        </div>
    </aside>

    <main>
        <a class="btn btn-primary big" href="${goBackUrl}">Go back to the quizz selection page</a>
    </main>

</body>
</html>
