<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List, java.util.Arrays, java.net.URLEncoder, java.io.PrintWriter" %>
<%@ page import="web.content.RegisterDTO, web.content.RegisterDAO, web.content.TicketDTO, web.content.TicketDAO" %>
<%@ include file="admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/Seat.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>    
<title>영화 좌석표</title>
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
</style>
<script>
    function toggleSeat(seat) {
        if (!seat.classList.contains('occupied')) {
            seat.classList.toggle('selected');           
            // 내부의 체크박스 상태 동기화
            const checkbox = seat.querySelector('input[type="checkbox"]');
            if (checkbox) {
                checkbox.checked = seat.classList.contains('selected');
            }
        }
    }
</script>

</head>
<body>
<header>
  <section id="top">
	<a id="logo" href="index_USER.jsp">Megaflix</a>	
      <nav id="top_menu">
    	<div>
    	 <ul>
    	 	<li style="color: white; font-weight: bold; font-size: 15pt;"><%= mem_id %>님</li> 
		    <li class="green"><a href="<%= request.getContextPath() %>/logout.do"><i class="fa-solid fa-lock-open">로그 아웃</i></a></li> 	 		                 
          	<li class="green"><a href="Login.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          	<li class="green"><a href=""><i class="fa-solid fa-headset">고객센터</i></a></li>
          	<%if (mem_role.equals("관리자")) {%>
          			<li class="green"><a href="admin_Approve.jsp"><i class="fa-solid fa-cloud">관리자</i></a></li>
           <% } %>	
        </ul>
        </div>
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
</header>

  <section id="main">
    <div style="border: 2px solid #fff; padding: 20px; border-radius: 10px; background-color: rgba(0, 0, 0, 0.5);"> 
  	<h1 style="font-weight: bold; color: white;">
  	<h1 style="text-align: center; color: white;">관람하실 좌석을 선택해주세요</h1>
    <div id="screen">Screen</div>
    <form method="post" action="<%= request.getContextPath() %>/Reservation.do">
        <%  
        
        	PrintWriter alt = response.getWriter();
        	String movie = request.getParameter("moviename");
        	String date = request.getParameter("selectedDate");
			String theater = request.getParameter("place");
			String time = request.getParameter("time");
			String moviePoster = (String)session.getAttribute("posterURL");
		
			//response.setContentType("text/html; charset=UTF-8");			
			
			if( date.equals("") || theater.equals("") || time.equals("")){
				//String redirectUrl = "Date.jsp?Poster=" + URLEncoder.encode(moviePoster, "UTF-8") 
               // + "&MovieName=" + URLEncoder.encode(movie, "UTF-8"); 
				alt.println("<script> alert('Pleas check seat again!'); history.go(-1); </script>");
				//response.sendRedirect(redirectUrl);
			}
				
			session.setAttribute("Movie", movie);
			session.setAttribute("Date", date);
			session.setAttribute("Theater", theater);
			session.setAttribute("Time", time);
			
            // 좌석 상태 설정: 예약된 좌석과 비어있는 좌석
            // 예: 좌석번호 "A1", "B2"는 이미 예약됨
                                  
             RegisterDAO dao = new RegisterDAO();
             ArrayList<TicketDTO> ticketList = dao.selectTicketList();

             ArrayList<String> occupiedSeats = new ArrayList<>(); // 예약된 좌석 누적 리스트

                for (TicketDTO occupied : ticketList) {
                    if ( movie.equals(occupied.getMovieName()) &&date.equals(occupied.getDate()) &&theater.equals(occupied.getPlace()) &&time.equals(occupied.getTime())) {
                        String[] seats = occupied.getSeat(); // 예약된 좌석 배열
                        
                        for (String seat : seats) {
                            if (!occupiedSeats.contains(seat)) {
                                occupiedSeats.add(seat); // 예약 좌석 누적
                            }
                        }
                        
                    }
                }

            %>

        <%//좌석표
            String rows = "ABCDEFGH"; // 좌석 행 이름
            int columns = 10; // 열 개수

            for (int i = 0; i < rows.length(); i++) {	
                char row = rows.charAt(i); //하나의 열, row에 A부터 차례대로 저장
        %>
        <div class="row">
            <%
            
                for (int j = 1; j <= columns; j++) { //행
                    String seatId = row + String.valueOf(j);               
                    boolean isOccupied = occupiedSeats.contains(seatId); // 예약 좌석 확인
            %>
            
            <div class="seat <%= isOccupied ? "occupied" : "" %>"  onclick="toggleSeat(this)" >
                 <%= seatId %>                
                 <input type="checkbox" name="seats" value="<%= seatId %>" style="display: none;" <%= isOccupied ? "disabled" : "" %> /> 
            </div>
            <% }  %>                      
        </div>
        <% } %>
        <div style="text-align: center; margin-top: 20px;">
        	<input type="hidden" name="movie" value="<%= movie %>">
        	<input type="hidden" name="date" value="<%= date %>">
        	<input type="hidden" name="theater" value="<%= theater %>">
        	<input type="hidden" name="time" value="<%= time %>">        	
            <button type="submit" style="font-weight: bold; color: white; display: inline-block; padding: 10px 20px; background-color: #4CAF50; border-radius: 5px; text-align: center; text-decoration: none; font-size: 16px; font-weight: bold;">예약하기</button>
        </div>
    </form>
     </h1>
    </div>
    <div class="clear"></div>
</section>    
</body>
</html>
