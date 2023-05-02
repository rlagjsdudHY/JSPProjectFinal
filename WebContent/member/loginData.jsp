<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
String uidSession = (String)session.getAttribute("uidSession"); 
%>    
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />

 <%
 	String uid = request.getParameter("uid");
	String loginip = request.getRemoteAddr();
	Date logintm = new Date(Long.parseLong(request.getParameter("logintm")));
	int logincnt = Integer.parseInt(request.getParameter("logincnt"));
	String conndev = request.getParameter("conndev");
	
	mMgr.InputLoginData(uid, logincnt, loginip, conndev); 
	
 %>
 