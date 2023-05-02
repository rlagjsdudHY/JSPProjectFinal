<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="nMgr" class="pack.notice.BoardMgr" scope="page" />
<%
nMgr.insertBoard(request);
response.sendRedirect("/notice/nList.jsp");
%>