<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bMgr" class="pack.bbs.BoardMgr" scope="page" />
<%
bMgr.comment(request);
int num = Integer.parseInt(request.getParameter("num"));
response.sendRedirect("http://localhost/bbs/read.jsp?num="+num+"&nowPage=1&keyField=&keyWord=");

%>