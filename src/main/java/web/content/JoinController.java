package web.content;
/*
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;*/

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/Register.do")
public class JoinController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		String role = request.getParameter("role");
		PrintWriter alt = response.getWriter();

		MemberDTO mDto = new MemberDTO();
		mDto.setId(id);
		mDto.setPassword(pw);
		mDto.setName(name);
		mDto.setRole(role);		//정보 저장
		
		MemberDAO mDao = new MemberDAO();	
		boolean insertCheck = mDao.memberInsert(mDto);

	    if(insertCheck){
	    	request.setAttribute("joinResult", insertCheck);
			HttpSession session = request.getSession();
			session.setAttribute("idKey", id);
			session.setAttribute("Rolekey", role);
			//RequestDispatcher dispatcher = request.getRequestDispatcher("MyWebSite/WebContent/index.jsp");
			//dispatcher.forward(request, response);
			response.sendRedirect("MyWebSite/WebContent/index.jsp");

		}else{
	    	request.setAttribute("joinResult", 0);
			//RequestDispatcher dispatcher = request.getRequestDispatcher("MyWebSite/WebContent/register.jsp");
			//dispatcher.forward(request, response);
	    	alt.println("<script> alert('Already in Member! Pleas try again!'); history.go(-1); </script>");
			alt.close();
			response.sendRedirect("MyWebSite/WebContent/register.jsp");

		}
		   
		  
	}


	
}
