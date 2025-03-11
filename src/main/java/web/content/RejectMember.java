package web.content;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/RejectMember.do")
public class RejectMember extends HttpServlet {


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberid = request.getParameter("memberid");
		PrintWriter alt = response.getWriter();
	
		MemberDAO dao = new MemberDAO();
		boolean isdelete = dao.deleteUSER(memberid);
		
		if(isdelete) {		
			alt.println("<script> alert('Rejected!'); history.go(-1); </script>");
			alt.close();
		}else {
		 alt.println("<script> alert('Delete Fail!  Please try again'); history.go(-1); </script>");
		 alt.close();

		}
	
	
	}
 
}
