<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList" %>
<%@ page import="web.content.RegisterDTO, web.content.RegisterDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 승인</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css"> <!-- CSS 파일 링크 -->
</head>
<body>
    <a id="logo" href="index_USER.jsp">Megaflix</a> <!-- 로고 추가 -->
	<%@ include file="admin_top.jsp" %>
	<h1><%=log%> | <%=mem%> | <%=admin%></h1>
    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>역할</th>
                <th>가입 승인</th>
                <th>가입 거부</th>
            </tr>
        </thead>
        <tbody>
            <%
                // DAO 객체를 생성해 데이터베이스에서 회원 목록 가져오기
                RegisterDAO dao = new RegisterDAO();
                ArrayList<RegisterDTO> memberList = dao.selectMemberList();

                // 회원 목록 출력
                for (RegisterDTO member : memberList) {
                	if(member.getRole().equals("관리자")){
            %>
                <tr>
                    <td><%= member.getMemberid() %></td>
                    <td><%= member.getPassword() %></td>
                    <td><%= member.getName() %></td>
                    <td><%= member.getRole() %></td>
                    <td>
                        <!-- 가입 승인 버튼 -->
                        <form method="POST" action="<%= request.getContextPath() %>/ApproveMember.do">
                            <input type="hidden" name="memberid" value="<%= member.getMemberid() %>">
                            <input type="submit" value="승인" class="btn">
                        </form>
                    </td>
                    <td>
                        <!-- 가입 거부 버튼 -->
                        <form method="post" action="<%= request.getContextPath() %>/RejectMember.do">
                            <input type="hidden" name="memberid" value="<%= member.getMemberid() %>">
                            <input type="submit" value="거부" class="btn" style="background-color: #f44336;"> <!-- 빨간색 버튼 -->
                        </form>
                    </td>
                </tr>
            <%
                	}
                }
            %>
        </tbody>
    </table>
</body>
</html>
