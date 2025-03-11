package web.content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;





public class MemberDAO {

    public boolean loginCheck(String id, String password) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select id, password from users where id = ? and password = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
            
            if ( loginCon == false) {
            	String sql = "select id, password from admin where id = ? and password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, id);
                pstmt.setString(2, password);               
                rs = pstmt.executeQuery();
                loginCon = rs.next();
            }                       
            
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
        
    }	   
    
    public boolean isadmin(String id, String password) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean adminCon = false;
        
        try {
			conn = JDBCUtil.getConnection();
			String sql = "select id, password from admin where id = ? and password = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, password);               
            rs = pstmt.executeQuery();
            adminCon = rs.next();
                                              
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return adminCon;
        
    }
	
    
    
    public boolean memberInsert(MemberDTO mDTO) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into users values(?,?,?,?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, mDTO.getId());
            pstmt.setString(2, mDTO.getPassword());
            pstmt.setString(3, mDTO.getName());
            pstmt.setString(4, mDTO.getRole());

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
    
    public boolean adminInsert(String memberid) {	
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "INSERT INTO admin (id, password, name, role) SELECT id,password,name,role "
            		+ "FROM users WHERE users.id = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, memberid);      

            int count = pstmt.executeUpdate();
                       
            String sql = "DELETE from users WHERE users.id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberid); 
            pstmt.executeUpdate();                       

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
    
    
  public boolean deleteUSER(String memberid) {  	
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "UPDATE users SET role=? WHERE id=? ";
            pstmt = conn.prepareStatement(strQuery);      
            pstmt.setString(1, "일반");
            pstmt.setString(2, memberid);
            
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
