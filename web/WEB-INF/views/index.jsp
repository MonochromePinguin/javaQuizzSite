<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_ local use:
    winMinPercentage    minimum percentage of good answers to pass the test
--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>quizzSchool</title>
    <meta name="description" content="quizzSchool Web learning">
    <meta name="keywords" content="school, learning, quizz, inscription, test">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/buttons.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
</head>

<body>

    <%@include file="/WEB-INF/views/common/header.jsp"%>

    <aside class="about-part">
        <h3 class="about-title">About Us</h3>

        <div class="about-text">
            <p>We are the quizzSchool, a web-learning organization centered about web cursus and at distance learning.</p>
            <p>
                <span class="about-em">Free entrance!</span>
                <br>
                You just have to have an entry test, corresponding to the cursus you choose.
            <p>
                <span class="about-em">Take it, pass it:</span>
                <br>
                if you have at least ${fn:escapeXml(requestScope.winMinPercentage)}% right answers, you can subscribe and join us!
            </p>
        </div>
    </aside>

    <aside>
        <a class="btn btn-primary big"
            title="go to the tests categories and choose one" href="<%= request.getContextPath()%>/entryQuizz" >
           Go to the Entrance test
        </a>
    </aside>

   <%--TODO: add the "Contact Us" page in a section--%>

</body>
</html>