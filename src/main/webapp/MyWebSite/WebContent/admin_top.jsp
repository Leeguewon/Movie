<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mem_id = (String)session.getAttribute("idKey");
	String mem_role = (String)session.getAttribute("Rolekey");
	
	String log="";
	String mem="";
	String admin="";
	
	log = "<a href="+request.getContextPath()+"/MyWebSite/WebContent/admin_Approve.jsp> 관리자 승인</a>";	
	mem = "<a href="+request.getContextPath()+"/MyWebSite/WebContent/Memberlist.jsp> 회원 목록</a>";
	admin = "<a href="+request.getContextPath()+"/MyWebSite/WebContent/admin.jsp> 관리자 명단</a>";
	
%>
