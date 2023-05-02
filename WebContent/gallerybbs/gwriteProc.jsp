<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="gbMgr" class="pack.bbsGallery.GalleryBoardMgr" scope="page" />
<%
gbMgr.insertBoard(request);
response.sendRedirect("/gallerybbs/glist.jsp");
%>