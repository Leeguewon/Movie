package web.content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class TicketDAO  {

   public boolean ticketInsert(TicketDTO tDto) {
	   Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       boolean flag = false;
       String seat;
       
       String[] seats = tDto.getSeat();
       if (seats == null) {
    	   seat = null;
       }else {
    	    seat = String.join("/",seats);
       }
             
       try {
    	   conn = JDBCUtil.getConnection();
           String strQuery = "insert into ticket values(?, ?, ?, ?, ?, ?)";
           pstmt = conn.prepareStatement(strQuery);
           pstmt.setString(1, tDto.getMemberid());
           pstmt.setString(2, tDto.getMovieName());
           pstmt.setString(3, tDto.getPlace());
           pstmt.setString(4, tDto.getDate());
           pstmt.setString(5, tDto.getTime());
           pstmt.setString(6, seat);         
           
           int count = pstmt.executeUpdate();

           if (count == 1) {
               flag = true;
           }

       } catch (Exception ex) {
           System.out.println("Exception" + ex);
       } finally {
       	JDBCUtil.close(rs, pstmt, conn);
       }
       return flag;
   }  

	public boolean ticketCancel(String memberid,String movie, String place, String date, String time, String seat) {
		   Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       boolean flag = false;	     
	             
	       try {
	    	   conn = JDBCUtil.getConnection();
	    	   String strQuery = "DELETE FROM ticket WHERE id = ? AND movie = ? AND place = ? AND date = ? "
	    	   		+ "AND time = ? AND seat = ?";
	           pstmt = conn.prepareStatement(strQuery);
	           pstmt.setString(1, memberid); 
	           pstmt.setString(2, movie); 
	           pstmt.setString(3, place); 
	           pstmt.setString(4, date); 
	           pstmt.setString(5, time); 
	           pstmt.setString(6, seat);              
	           
	           int count = pstmt.executeUpdate();

	           if (count == 1) {
	               flag = true;
	           }
	       } catch (Exception ex) {
	           System.out.println("Exception" + ex);
	       } finally {
	       	JDBCUtil.close(rs, pstmt, conn);
	       }
	       return flag;	   
	} 
   
}
