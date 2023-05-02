<%@page import="pack.bbsGallery.GalleryBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    request.setCharacterEncoding("UTF-8");
    %>
<jsp:useBean id="gbMgr" class="pack.bbsGallery.GalleryBoardMgr" scope="page" />
<%
String nowPage = request.getParameter("nowPage");
String reqNum = request.getParameter("num");
int numParam = Integer.parseInt(reqNum);

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

GalleryBoardBean gbean = (GalleryBoardBean)session.getAttribute("gbean");
int exeCnt = gbMgr.deleteBoard(numParam);
	
String url = "/gallerybbs/glist.jsp?nowPage="+nowPage;
		 url += "&keyField="+keyField;
		 url += "&keyWord="+keyWord;
%>	
<script>
	alert("삭제되었습니다!");
	location.href = "<%=url%>";
</script>
		