package web.content;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Reservation.do")
public class Reservation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter alt = response.getWriter();
        PrintWriter out = response.getWriter();
        // 선택된 좌석 데이터 받기
        HttpSession session = request.getSession();		
		String memberid = (String)session.getAttribute("idKey");
		String movieName = request.getParameter("movie");
		String date = request.getParameter("date");
		String theater = request.getParameter("theater");
		String time = request.getParameter("time");
        String[] selectedSeats = request.getParameterValues("seats");                          
        
        
        TicketDTO tDto = new TicketDTO();
        tDto.setMemberid(memberid);
		tDto.setMovieName(movieName);
		tDto.setPlace(theater);
		tDto.setDate(date);
		tDto.setTime(time);
        tDto.setSeat(selectedSeats);
        
        TicketDAO tDao = new TicketDAO();
        boolean fullTicket = tDao.ticketInsert(tDto);             
        
        if (selectedSeats == null) {
        	fullTicket = false;
        }
        
        if(fullTicket){
        	String seatParam = "";
        	if (selectedSeats != null) {
        		seatParam = String.join("/", selectedSeats);
        	}
        	String redirectUrl = "MyWebSite/WebContent/Payment.jsp?selectedSeats="+ URLEncoder.encode(seatParam, "UTF-8");       	
        	response.sendRedirect(redirectUrl);
        }else{
	    	alt.println("<script> alert('Pleas check seat again!'); history.go(-1); </script>");
			alt.close();
			//response.sendRedirect("MyWebSite/WebContent/Seat.jsp");
		}
   
        
    }
                  

}      
        
        
   

