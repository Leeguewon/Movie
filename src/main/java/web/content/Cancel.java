package web.content;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Cancel.do")
public class Cancel extends HttpServlet {     

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberid = request.getParameter("memberid");
		String movie = request.getParameter("movie");
		String place = request.getParameter("place");
		String date = request.getParameter("date");
		String time = request.getParameter("time");		
		String seat = request.getParameter("seat");
		PrintWriter alt = response.getWriter();
	
		TicketDAO dao = new TicketDAO();
		boolean iscancel = dao.ticketCancel(memberid, movie, place, date, time, seat);
		
		if(iscancel) {		
			alt.println("<script> alert('Cancel Confirm!'); history.go(-1); </script>");
			alt.close();
		}else {
		 alt.println("<script> alert('Cancel Fail!  Please try again'); history.go(-1); </script>");
		 alt.close();

		}
	
	}

}
