package web.content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RegisterDAO {
    String jdbcDriver = "jdbc:mysql://localhost:3306/Megaflix?serverTimezone=UTC&useSSL=false&useUnicode=true&characterEncoding=utf-8";
    String dbUser = "root";
    String dbPass = "dongyang";
    Connection conn = null;
    PreparedStatement pstmt = null;

    public RegisterDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // users 테이블에서 데이터를 조회하는 메서드
    public ArrayList<RegisterDTO> selectMemberList() throws SQLException {
        ResultSet rs = null;
        ArrayList<RegisterDTO> aList = new ArrayList<RegisterDTO>();
        try {
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            pstmt = conn.prepareStatement("SELECT * FROM users;");  // users 테이블 조회
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RegisterDTO rd = new RegisterDTO();
                rd.setMemberid(rs.getString("ID"));  // users 테이블의 ID 필드
                rd.setPassword(rs.getString("PASSWORD"));  // users 테이블의 PASSWORD 필드
                rd.setName(rs.getString("NAME"));  // users 테이블의 NAME 필드
                rd.setRole(rs.getString("ROLE"));  // users 테이블의 ROLE 필드
                aList.add(rd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
            pstmt.close();
        }

        return aList;
    }
    
    public ArrayList<RegisterDTO> selectAdminList() throws SQLException {
        ResultSet rs = null;
        ArrayList<RegisterDTO> aList = new ArrayList<RegisterDTO>();
        try {
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            pstmt = conn.prepareStatement("SELECT * FROM admin;");  // users 테이블 조회
            rs = pstmt.executeQuery();

            while (rs.next()) {
                RegisterDTO rd = new RegisterDTO();
                rd.setMemberid(rs.getString("ID"));  // users 테이블의 ID 필드
                rd.setPassword(rs.getString("PASSWORD"));  // users 테이블의 PASSWORD 필드
                rd.setName(rs.getString("NAME"));  // users 테이블의 NAME 필드
                rd.setRole(rs.getString("ROLE"));  // users 테이블의 ROLE 필드
                aList.add(rd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
            pstmt.close();
        }

        return aList;
    }
    
    
    public ArrayList<TicketDTO> selectTicketList() throws SQLException {
        ResultSet rs = null;
        ArrayList<TicketDTO> aList = new ArrayList<TicketDTO>();
        try {
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            pstmt = conn.prepareStatement("SELECT * FROM ticket;");  // ticket 테이블 조회
            rs = pstmt.executeQuery();           
            
            while (rs.next()) {
                TicketDTO rd = new TicketDTO();
                rd.setMemberid(rs.getString("ID"));  // users 테이블의 ID 필드
                rd.setMovieName(rs.getString("MOVIE"));  // users 테이블의 PASSWORD 필드
                rd.setPlace(rs.getString("PLACE"));  // users 테이블의 NAME 필드
                rd.setDate(rs.getString("DATE"));  // users 테이블의 ROLE 필드
                rd.setTime(rs.getString("TIME"));
                String a = rs.getString("SEAT");
                String[] b = a.split("/");
                rd.setSeat(b);
                aList.add(rd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
            pstmt.close();
        }

        return aList;
    }
    
}
