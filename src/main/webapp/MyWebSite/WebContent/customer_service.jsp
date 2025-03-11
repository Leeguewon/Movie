<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객센터</title>
    <!-- 외부 CSS 파일 링크 -->
    <link rel="stylesheet" type="text/css" href="css/customer_service.css">
</head>
<body>

    <%
	if(mem_id != null){
	%>
		<a id="logo" href="index_USER.jsp">Megaflix</a>
	<%}else{%>
		<a id="logo" href="index.jsp">Megaflix</a>
	<%}%>

    <div class="container">
        <h1>고객센터</h1>
        <p>문의사항을 작성해 주세요. 최대한 빨리 답변 드리겠습니다.</p>

        <form name="contactForm" method="post" action="<%= request.getContextPath() %>/submitInquiry.do">
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="subject">제목:</label>
                <input type="text" id="subject" name="subject" required>
            </div>

            <div class="form-group">
                <label for="message">문의내용:</label>
                <textarea id="message" name="message" rows="5" required></textarea>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">문의하기</button>
            </div>
        </form>
    </div>

</body>
</html>
