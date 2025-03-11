<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="web.content.RegisterDTO, web.content.RegisterDAO, web.content.TicketDTO, web.content.TicketDAO" %>
<%@ page import="java.util.*" %>
<%@ include file="admin_top.jsp" %>
<%
    // 예시 데이터
    List<String> eventDates = Arrays.asList("2023-12-05", "2023-12-10", "2023-12-15");
    request.setAttribute("eventDates", eventDates);
    String movie = request.getParameter("movie");
    String MoviePoster = request.getParameter("posterUrl");
   // String poster = request.getParameter("Poster");
    String Movie = request.getParameter("MovieName");
    session.setAttribute("posterURL", MoviePoster); 
    //session.setAttribute("posterUrl", poster);
   // if(movie == null){
    //	movie = Movie;
    //}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flatpickr 달력</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="css/Date.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>
<script>function Alert1(){ alert("로그인 후 이용해주세요.")}
		function Alert2(){ alert("영화를 먼저 선택해세요")}
		function Alert3(){ alert("로그인이 필요한 서비스입니다.")}
		function Alert4(){ alert("원하시는 날짜를 선택해주세요.")}
		function Alert5(){ alert("원하시는 영화관을 선택해주세요.")}
		function Alert6(){ alert("원하시는 시간을 선택해주세요.")}
</script>
    <!-- jQuery와 jQuery UI 추가 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<title> 8조 백엔드 메인페이지 </title>
<style>
    body {
        position: relative;
        background-image: url('https://assets.nflxext.com/ffe/siteui/vlv3/9737377e-a430-4d13-ad6c-874c54837c49/945eec79-6856-4d95-b4c6-83ff5292f33d/KR-ko-20220111-popsignuptwoweeks-perspective_alpha_website_large.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        height: 100vh;
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
    .highlight {
    background-color: yellow;
    color: black;
	}
   	#datepicker {
        font-size: 1.5em; /* 글꼴 크기 변경 */
        width: 500px;    /* 달력의 너비 조정 */
        height: auto;    /* 높이는 자동 조정 */
    }
     .ui-datepicker {
        font-size: 1.2em; /* 달력 내부 폰트 크기 */
    }        
</style>

</head>
<body>
  <header>
    <section id="top">
    <% 
		if(mem_id != null){ 
	%>
			<a id="logo" href="index_USER.jsp">Megaflix</a>	
	<% } else { %>
		    <a id="logo" href="index.jsp">Megaflix</a>	
	<% } %>
      <nav id="top_menu">
        <ul>
          <% 
		 	if(mem_id != null){  %>   <!-- 로그인 함 -->
		 	<li style="color: white; font-weight: bold; font-size: 15pt;"><%= mem_id %>님</li> 		 	
		    <li class="green"><a href="<%= request.getContextPath() %>/logout.do"><i class="fa-solid fa-lock-open">로그 아웃</i></a></li>
		    <li class="green"><a href="mypage_USER.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          	<li class="green"><a href="customer_service.jsp"><i class="fa-solid fa-headset">고객센터</i></a></li> 
          		<%if (mem_role.equals("관리자")) {%>
          			<li class="green"><a href="admin_Approve.jsp"><i class="fa-solid fa-cloud">관리자</i></a></li>
          		<% } %>	
	    <% } else { %>
		    <li class="green"><a href="Login.jsp"><i class="fa-solid fa-lock">로그인</i></a></li>
		    <li class="green"><a href="register.jsp"><i class="fa-solid fa-user-plus">회원가입</i> </a></li>
		    <li class="green"><a href="Login.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          	<li class="green" onclick="Alert1()"><a href=""><i class="fa-solid fa-headset">고객센터</i></a></li> 
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
	<%if(mem_id != null) { 
		if(movie == null ) { %>	
	    	<form method="get" action="<%= request.getContextPath() %>/MyWebSite/WebContent/movie.jsp">  
	   <%}else{%>	
	       	<form method="get" action="<%= request.getContextPath() %>/MyWebSite/WebContent/Seat.jsp">    	   
	   <%} %>  	
	<%}else{ %>
    	<form method="get" action="<%= request.getContextPath() %>/MyWebSite/WebContent/index.jsp">    
    <%} %>
    <div class="container">	 
    		<div>    			
    			<img src="<%= MoviePoster %>"/>
    		</div> 
         <div class="date">
            <h3>날짜</h3>
            <div id="datepicker"></div> 
            <!-- 숨겨진 input 필드로 선택된 날짜를 전송 -->
            <input type="hidden" name="selectedDate" id="selectedDate" />           
            <script>
   			 $(document).ready(function () {
        			// 서버에서 전달받은 이벤트 날짜
        			var eventDates = <%= new org.json.JSONArray((List<String>) request.getAttribute("eventDates")).toString() %>;

        			console.log(eventDates); // 디버깅용 출력

        			// jQuery UI 달력 생성
        			$("#datepicker").datepicker({
			            beforeShowDay: function (date) {
			                var dateString = $.datepicker.formatDate('yy-mm-dd', date);
			                // eventDates 배열에 날짜가 포함되어 있는지 확인
			                if (eventDates.includes(dateString)) {
			                    return [true, "highlight", "이벤트 날짜"];
			                }
			                return [true, "", ""];
			            },
			            onSelect: function (dateText) {
			                // 선택된 날짜를 hidden input에 저장
			                $("#selectedDate").val(dateText);
			            }
			        });
			    });
			</script>
			
        </div>
        <div class="theaters">
            <h3>극장</h3>
            <div id="theater-buttons">
                <input type="radio" id="theater1" name="place" value="롯데월드몰" />
                <label class="button-label" for="theater1">롯데월드몰</label>

                <input type="radio" id="theater2" name="place" value="코엑스몰" />
                <label class="button-label" for="theater2">코엑스몰</label>

                <input type="radio" id="theater3" name="place" value="타워8" />
                <label class="button-label" for="theater3">타워8</label>

                <input type="radio" id="theater4" name="place" value="상암" />
                <label class="button-label" for="theater4">상암</label>
                
                <input type="radio" id="theater5" name="place" value="용산아이파크몰" />
                <label class="button-label" for="theater5">용산아이파크몰</label>
                
                <input type="radio" id="theater6" name="place" value="건대입구" />
                <label class="button-label" for="theater6">건대입구</label>
                
                <input type="radio" id="theater7" name="place" value="홍대" />
                <label class="button-label" for="theater7">홍대</label>
            </div>
            <input type="hidden" name="place" id="selected-theater" />
        </div>        

        <div class="times">
            <h3>시간</h3>
            <div id="time-buttons">
                <input type="radio" id="time1" name="time" value="10:30" />
                <label class="button-label" for="time1">10:30</label>

                <input type="radio" id="time2" name="time" value="12:45" />
                <label class="button-label" for="time2">12:45</label>

                <input type="radio" id="time3" name="time" value="14:20" />
                <label class="button-label" for="time3">14:20</label>

                <input type="radio" id="time4" name="time" value="17:50" />
                <label class="button-label" for="time4">17:50</label>

                <input type="radio" id="time5" name="time" value="20:30" />
                <label class="button-label" for="time5">20:30</label>

                <input type="radio" id="time6" name="time" value="22:45" />
                <label class="button-label" for="time6">22:45</label>
            </div>
            <input type="hidden" name="time" id="selected-time" />
        </div>

        <input type="hidden" name="moviename" value="<%= movie %>" >
       	<%if (mem_id == null ) {%>
        	<a href="index.jsp"><input type="button" value="돌아가기" class="reset-button"  ></a>
        <%} else { %>
        	<a href="movie.jsp"><input type="button" value="돌아가기" class="reset-button"  ></a>
        <%} %>
        <div>
        <% if (mem_id != null ) { 
	            if(movie == null ) { %>    
	                <input  class="unlog" onclick="Alert2()" type="submit" value="좌석 선택">		                           	 
	            <%} else  { %>
	                <input type="submit" value="좌석 선택"> 
	            <%} %>      
        <% }else{ %>
            <input  class="unlog" onclick="Alert3()" type="submit" value="좌석 선택">     
        <% } %>
        </div>
    </div>    
    </form> 
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
</html>
