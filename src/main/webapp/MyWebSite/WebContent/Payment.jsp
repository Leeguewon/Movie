<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject, java.sql.*, java.util.ArrayList" %>
<%@ page import="web.content.RegisterDTO, web.content.RegisterDAO, web.content.TicketDTO, web.content.TicketDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/Payment.css">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>
<title> 8조 백엔드 메인페이지 </title>
<style>
    body {
        position: relative;
        background-image: url('https://assets.nflxext.com/ffe/siteui/vlv3/9737377e-a430-4d13-ad6c-874c54837c49/945eec79-6856-4d95-b4c6-83ff5292f33d/KR-ko-20220111-popsignuptwoweeks-perspective_alpha_website_large.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        height: 100vh;
         font-family: Arial, sans-serif; 
         text-align: center; 
         margin-top: 50px;
    }

    body::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5); /* 반투명 검정 오버레이 */
        filter: blur(10px); /* 블러 효과 */
        pointer-events: none; /* 마우스 이벤트가 배경에 영향을 미치지 않도록 */
        z-index: -1; /* 배경 이미지를 가리지 않도록 */
    }
     .success { 
         color: green;
         font-weight: bold; 
     }
     .error { 
         color: red; 
         font-weight: bold;
     }
</style>

</head>
<body>
  <header>
    <section id="top">
    <a id="logo" href="index_USER.jsp">
    Megaflix
</a>

      <nav id="top_menu">
        <ul>
          <li style="color: white; font-weight: bold; font-size: 15pt;"><%= mem_id %>님</li> 
          <li class="green"><a href="<%= request.getContextPath() %>/logout.do"><i class="fa-solid fa-lock-open">로그 아웃</i></a></li> 
          <li class="green"><a href="mypage_USER.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          <li class="green"><a href="customer_service.jsp"><i class="fa-solid fa-headset">고객센터</i></a></li>
          <%if (mem_role.equals("관리자")) {%>
          			<li class="green"><a href="admin_Approve.jsp"><i class="fa-solid fa-cloud">관리자</i></a></li>
          <% } %>
        </ul>
      </nav> <!-- top_menu -->

      <div class="clear"></div>
     </section> <!-- section top -->

      <ndav id="main_menu">
      <h2><ul>
          <li><a href="movie.jsp">영화</a></li>
          <li><a href="Date.jsp">예매</a></li>
          <li><a href="theater.jsp">극장</a></li>
          <li><a href="event.jsp">이벤트</a></li>
          <li><a href="store.jsp">스토어</a></li>
          <li><a href="drama.jsp">드라마</a></li>        
        </ul></h2>
      </nav>
  </header> <!--header -->

<section id="main">
    <div style="border: 2px solid #fff; padding: 20px; border-radius: 10px; background-color: rgba(0, 0, 0, 0.5);">
        <h1 style="font-weight: bold; color: white;">
            예약이 완료되었습니다!
            <% 
                String selectedSeats = request.getParameter("selectedSeats");
                String[] SelectedSeats = selectedSeats.split("/");
               
                int count = SelectedSeats.length;
                int discount = 0;
                int total = (5000*count) - discount;
                String AP;
                RegisterDAO dao = new RegisterDAO();
                ArrayList<TicketDTO> ticketList = dao.selectTicketList();
                               
              	String movie = (String) session.getAttribute("Movie");
              	String date = (String) session.getAttribute("Date");
              	String theater = (String) session.getAttribute("Theater");
              	String time = (String) session.getAttribute("Time");
				String moviePoster = (String)	session.getAttribute("posterURL");
				//String Movieposter = (String)	session.getAttribute("posterUrl");
				
				if(time.equals("10:30") || time.equals("12:45") ){
					AP = "AM";
				} else{ AP = "PM";}
				
                if (SelectedSeats == null || SelectedSeats.length == 0) { 
            %>
                <h2 style="font-weight: bold; color: white;">예약할 좌석을 선택하지 않았습니다</h2>
                <a href='Seat.jsp' style="font-weight: bold; color: white;">좌석 선택 화면으로 돌아가기</a>
            <% } else { %>
            	<div class="container">
			        <div class="summary">
			            <h3>결제내역</h3><hr><br>
			            <p>결제하실 금액: <strong><%= 5000*count %></strong></p>
			            <p>총 할인 금액: <strong>0원</strong></p><br><hr>
			            <p>남은 결제 금액: <strong><%= total %></strong></p>
			        </div>
			
			        <div class="ticket-info">
			        	<img src="<%= moviePoster %>"/>
			            <div class="ticket-details">
			                <p><%= movie %></p>
			                <p>영화관 : <%= theater %></p>
			                <p>일시: <%= date %>,  <%= time %><%= AP %></p>
			                <p>인원: <%= count %></p>
			                <p>좌석번호: <%   for (int i = 0; i < SelectedSeats.length; i++) {
					                            out.print(SelectedSeats[i]);
					                            if (i < SelectedSeats.length - 1) {
					                                out.print(", "); // 좌석 사이에 쉼표 추가
					                            }
					                        } %>
					        </p>
			            </div>
			        </div>			     
			    </div>
        
                <a href="index_USER.jsp" onclick="alert('결제가 완료되었습니다!')" style="font-weight: bold; color: white; display: inline-block; padding: 10px 20px; background-color: #4CAF50; border-radius: 5px; text-align: center; text-decoration: none; font-size: 16px; font-weight: bold;">HOME</a>
            <% } %>
        </h1>
    </div>
    <div class="clear"></div>
</section> <!-- section main -->



      <footer>
          <section id="footer_menu_box">
            <nav id="footer_menu">
            <ul>
              <li><a href="#">홈</a></li>
              <li><a href="#">회사소개</a></li>
              <li><a href="#">이용약관</a></li>
              <li><a href="#">개인정보취급방침</a></li>
              <li><a href="#">적립금</a></li>
              <li><a href="#">이용안내</a></li>
            </ul>
          </nav>
        </section> <!-- section footer_menu_box -->
        
        <section id="footer_address">
            <p>Copyright ⓒ 2024 백엔드8조 All rights reserved.</br>
            전화 : 010-1234-5678 근무시간: 오전 10:00 ~ 오후 05:00</br>
            Contact every_day_with_you@nate.com for more information</br>
            법인명(상호):Megaflix </br>
            사업자 등록번호 안내 [123-45-6789] / 통신판매업 신고 제 2024-서울-2024호 [사업자정보확인]</br>
            개인정보관리책임자 :홍길동 소분 제2024-1234567호(every_day_with_you@nate.com) / 대표자(성명):홍길동</p>
        </section> <!-- section footer_address -->
      </footer>
</body>