<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uidSession_MLTmp = (String)session.getAttribute("uidSession");
request.setCharacterEncoding("UTF-8");

String gnbParam = "";
if (request.getParameter("gnbParam") != null) {
	gnbParam = request.getParameter("gnbParam");
}

%>    


	<nav id="mainLNB">
		<ul id="lnbMainMenu">
		
		<% if (uidSession_MLTmp == null) { 	%> 
<!--     			비회원도 갤러리는 볼 수 있게 수정 -->
    		<li class="lnbMainLi"><a href="/bbs/list.jsp">자유게시판</a></li>
			<li class="lnbMainLi"><a href="/gallerybbs/glist.jsp">갤러리게시판</a></li>
			<li class="lnbMainLi"><a href="/notice/nList.jsp">공지사항</a></li>
			<li class="lnbMainLi"><a href="#">menu4</a></li>
			<li class="lnbMainLi"><a href="#">menu5</a></li>
    				
    	<% } else { %>
    		 
    		 <% if (gnbParam.equals("myPage")) { %>
	    		<li class="lnbMainLi"><a href="/member/memberMod.jsp">회원정보수정</a></li>
				<li class="lnbMainLi"><a href="/member/memberQuit.jsp">회원탈퇴</a></li>
				<li class="lnbMainLi"><a href="/member/passModCheck.jsp">비밀번호수정</a></li>
				<li class="lnbMainLi"><a href="#">menu4</a></li>
				<li class="lnbMainLi"><a href="#">menu5</a></li>
			<% } else { %>    		     		 
	    		<li class="lnbMainLi"><a href="/bbs/list.jsp">자유게시판</a></li>
				<li class="lnbMainLi"><a href="/gallerybbs/glist.jsp">갤러리게시판</a></li>
				<li class="lnbMainLi"><a href="/notice/nList.jsp">공지사항</a></li>
				<li class="lnbMainLi"><a href="#">menu4</a></li>
				<li class="lnbMainLi"><a href="#">menu5</a></li>
    		 <% } %>
    		 
    	<% } %>
    			
		</ul>
	</nav>
	