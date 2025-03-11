package web.content;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login.do")
public class LoginController extends HttpServlet {
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String role = request.getParameter("role");
		PrintWriter alt = response.getWriter();

		MemberDAO mDao = new MemberDAO();		
		boolean loginCheck = mDao.loginCheck(id, pw);
		
		boolean isadmin = mDao.isadmin(id, pw);
		if(isadmin) {
			role = "관리자";
		}else {
			role = "일반";
		}

	    if(loginCheck){
	    	request.setAttribute("loginResult", loginCheck);
			HttpSession session = request.getSession();
			session.setAttribute("idKey", id);
			session.setAttribute("Rolekey", role);
			//RequestDispatcher dispatcher = request.getRequestDispatcher("MyWebSite/WebContent/index_USER.jsp");
			//dispatcher.forward(request, response);
			response.sendRedirect("MyWebSite/WebContent/index_USER.jsp");

		}else{			 
			  alt.println("<script> alert('Please try again'); history.go(-1); </script>");
			  alt.close();
		}
		   

		  
	}


	
}
