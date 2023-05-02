<%@page import="pack.notice.NBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    request.setCharacterEncoding("UTF-8");
    %>
<jsp:useBean id="nMgr" class="pack.notice.BoardMgr" scope="page" />
<%
String nowPage = request.getParameter("nowPage");
String reqNum = request.getParameter("num");
int numParam = Integer.parseInt(reqNum);

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

NBoardBean bean = (NBoardBean)session.getAttribute("bean");
int exeCnt = nMgr.deleteBoard(numParam);
	
String url = "/notice/nList.jsp?nowPage="+nowPage;
		 url += "&keyField="+keyField;
		 url += "&keyWord="+keyWord;
%>	
<script>
	alert("삭제되었습니다!");
	location.href = "<%=url%>";
</script>
		