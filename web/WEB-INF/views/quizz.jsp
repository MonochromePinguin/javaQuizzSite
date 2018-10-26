<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
quizz page. used as well for entrance exam than for other tests.
• accepted attributes :
_ forwarded to header.jsp:
    titleIntro?
    title
    subtitle?
_localy used:
    pageTitle       used as page title

    aboutTitle      page description § title
    rawAboutText    the raw html source for the page description §

    questionList    a list of Question, each of them containing a list of Answer objects
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

    <%--list of questions, each containing a list of possible answers--%>
    <main class="border-margin-1rem">

        <c:forEach items="${questionList}" var="question">

            <div class="list">
                <p class="list-title">${fn:escapeXml(question.label)}</p>

                <div class="list-container">

                    <%--inner question-list loop--%>
                    <c:forEach items="${question.answerList}" var="answer">
                        <div class="list-item">
                            <label class="list-answer">
                                <input type="checkbox" value="${answer.answerId}"/>
                                ${fn:escapeXml(answer.label)}
                            </label>
                        </div>
                    </c:forEach>

                    <%--in case of empty answers list--%>
                    <c:if test="${empty question.answerList}">
                        <div class="warning list-item ">
                            <p>
                                This question has no answer? What's The Bug!?
                            </p>
                        </div> <%--div.warning.list-item--%>

                    </c:if>

                </div> <%--div.list-container--%>
            </div> <%--div.list--%>

        </c:forEach>

        <%--in case of empty question list--%>
        <c:if test="${empty questionList}">
            <div class="list">
                <p class="list-title warning">Sorry...</p>
                <div class="list-about warning">
                    <p>There is no question inside this quizz!? Oups.</p>
                    <p>Perhaps there is a problem in our servers.</p>
                    <p>Please try later.</p>
                </div>
            </div>
        </c:if>

    </main>

</body>
</html>
