<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder" %>
<%@ page import="java.sql.*, java.util.ArrayList" %>
<%@ page import="web.content.RegisterDTO, web.content.RegisterDAO, web.content.TicketDTO, web.content.TicketDAO" %>
<%@ include file="admin_top.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="css/mypage.css">
</head>
<body>
	<%
	if(mem_id != null){%>
		<a id="logo" href="index_USER.jsp">Megaflix</a>
	<%}else{%>
		<a id="logo" href="index.jsp">Megaflix</a>
	<%}%>

	<%
	if(mem_id != null){   %>
		<h1><%=mem_id%> 님</h1><br> 		
	<%}else{%>
		<h1>로그인 하신 후 이용해 주세요</h1>
	<%} %>
	
	
	<%
		RegisterDAO dao = new RegisterDAO();
        ArrayList<TicketDTO> ticketList = dao.selectTicketList();
        int count = 0;
        String Rank = "GUEST";
     %>
    <table>
        <thead>
            <tr>
                <th>MY RANK</th>
                <th>MY COUPON</th>
                <th>MY POINT</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <% for(TicketDTO RankList : ticketList) {
            		if(RankList.getMemberid().equals(mem_id)) {
            			count++;
            		}           		
            	}
            	if(count >= 5) {
            		Rank = "BRONZ";
            		if(count >= 10)	{
            			Rank = "SILVER";
            			if (count >= 20) {
            				Rank = "GOLD";
            				if(count >= 50) {
            					Rank = "VIP";
            				}
            			}
            		}
            	}%>
            	<% if(mem_id == null){ %>
            		<td>0</td>
            	<%} else { %>
            		<td><%= Rank %></td>
            	<%} %>                
                <td>5장</td>
                <td><%=  count*500 %> 점</td>
            </tr>
        </tbody>
    </table>
		
		<!-- ----------------------------------------- -->	
	 <table class="res">
        <thead >
            <tr >
                <th colspan="6">최근 예매 내역</th>
            </tr>
        </thead>
        <tbody >
        <tr>
        	<td>영화 제목</td>
        	<td>영화관</td>
        	<td>날짜</td>
        	<td>시간</td>
        	<td>좌석</td>
        	<td>예매 취소</td>
         </tr>
            <%            	
                for (TicketDTO info : ticketList) {//sql의 id와 로그인 한 id가 같은 것만
          	      	String[] a = info.getSeat();
                	String Seat = String.join("/",a);
                	if(info.getMemberid().equals(mem_id)){
            %>            
            	<tr>          
                    <td><%= info.getMovieName() %></td>
                    <td><%= info.getPlace() %></td>
                    <td><%= info.getDate() %></td>
                    <td><%= info.getTime() %></td>
                    <td><%= Seat %>
 					 <td> <!-- 가입 거부 버튼 -->                      
                        <form method="post" action="<%= request.getContextPath() %>/Cancel.do">                           
                            <input type="hidden" name="memberid" value="<%= info.getMemberid() %>">
                            <input type="hidden" name="movie" value="<%= info.getMovieName() %>">   
                            <input type="hidden" name="place" value="<%= info.getPlace() %>">
                            <input type="hidden" name="date" value="<%= info.getDate() %>">
                            <input type="hidden" name="time" value="<%= info.getTime() %>">
                            <input type="hidden" name="seat" value="<%= Seat %>">                         
                            <input type="submit" value="취소" class="btn" style="background-color: #f44336;"> <!-- 빨간색 버튼 -->
                        </form>
                    </td>
                </tr>
           
          <%   }  	   
             } %>
        </tbody>
    </table>
</body>
</html>
