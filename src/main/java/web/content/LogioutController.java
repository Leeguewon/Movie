package web.content;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/logout.do")
public class LogioutController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		//RequestDispatcher dispatcher = request.getRequestDispatcher("MyWebSite/WebContent/index.jsp");
		//dispatcher.forward(request, response);
		response.sendRedirect("MyWebSite/WebContent/index.jsp");		  
	}	
}
