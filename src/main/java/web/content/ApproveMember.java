package web.content;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ApproveMember.do")
public class ApproveMember extends HttpServlet {
   
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String memberid = request.getParameter("memberid");
			PrintWriter alt = response.getWriter();
			
			
			MemberDAO dao = new MemberDAO();
			boolean isApprove = dao.adminInsert(memberid);
			
			if(isApprove) {
					//response.sendRedirect("/admin.jsp");
					alt.println("<script> alert('Approved!'); history.go(-1); </script>");
					alt.close();
			}else {
				 alt.println("<script> alert('Approve Fail!  Please try again'); history.go(-1); </script>");
				 alt.close();

			}
	}

}
