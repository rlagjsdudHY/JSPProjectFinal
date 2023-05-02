<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import="java.util.Date"%>
   <%@page import="javax.servlet.http.HttpServletRequest"%>
<%
request.setCharacterEncoding("UTF-8");
String uidSession = (String)session.getAttribute("uidSession"); 
%>
   
  
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible"  >
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>로그인</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/style_Template.css">
	<script src="/resource/jquery-3.6.0.min.js"></script>
	<script src="/script/script_Login.js"></script>
</head>

<body>
    <div id="wrap">
    	
    	<!--  헤더템플릿 시작 -->
		<%@ include file="/ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
    	
    	<main id="main"> 
<!--     	 플렉스 지워봄 -->
    	
    		<div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="/ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div>
    		
    		
	    	<!-- 실제 작업 영역 시작 -->
	    	<%
			if (uidSession == null) {
			%>
    		<div id="contents" class="loginDiv">

				<form id="adminLoginFrm" name="adminLoginFrm" method="post">
	        
		        		<h1 style="padding-bottom:10px; text-align:center;" >관리자 페이지</h1>
		        	<div id="loginArea">	        	
		        		<div id="loginInput">
		        			<input type="text" name="uid" placeholder="아이디 입력" id="uid">
		        			<input type="password" name="upw" placeholder="비밀번호 입력" id="upw">
<%-- 		        		    <input type="hidden" name="loginip" value="<%=request.getRemoteAddr()%>"> --%>
<%--   							<input type="hidden" name="logintm" value="<%=new Date()%>"> --%>
<!--   							<input type="hidden" name="logincnt" value="1"> -->
  							<input type="hidden" name="conndev" value="pc">
		        		</div>
		        		
		        		<button type="button" id="adminLoginBtn">로그인</button>
		        		
		        	</div>
		        	<!-- div#loginArea -->
	        	
	        	</form>

    		</div>
    			<%
			} else if (uidSession.equals("admin")){
			%>
			
			<%@ include file="/admin/amemlist.jsp" %>
			<%@ include file="/admin/alist.jsp" %>  
			<%@ include file="/admin/aglist.jsp" %> 
			<%@ include file="/admin/anlist.jsp" %>			
			
			<%
			} else {
			%>
			out.println("<script>alert('잘못된 접근입니다.'); location.href='../index.jsp';</script>");
			
			<%} %>
    		<!-- 실제 작업 영역 끝 div.loginDiv -->
    		    	
    		    	
    	</main>
    	<!--  main#main  -->
    
        	   	
    	<!--  푸터템플릿 시작 -->
<%-- 		<%@ include file="/ind/footerTmp.jsp" %> --%>
    	<!--  푸터템플릿 끝 -->  
        
    </div>
    <!-- div#wrap -->

</body>
		<script>
		$(function(){
			$("#loginBtn").click(function(){
				$("#loginFrm").attr("action", "/loginData.jsp")
				
			});
		});
		
		</script>
		<style>
		div#wrap>main#main>div.loginDiv {
	text-align: center;
	padding: 40px;
}

div#wrap>main#main>div.loginDiv>form#adminLoginFrm {
	
	padding: 20px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	
	display: inline-block;
	
}


#main>.loginDiv>#adminLoginFrm input {
	
	width: 320px;
	font-size: 17px;
	padding: 13px 16px;
	margin-bottom: 7px;
	display: block;
}

/* #main>.loginDiv>#adminLoginFrm button { */
button#adminLoginBtn {
	
	width: 320px;
	color: #fff;
	font-size: 18px;
	padding: 15px 20px;
	border: none;
	margin-top: 17px;
	margin-bottom: 7px;
	background-color: #4e87f0;
	cursor: pointer;
	display: block;
}
		</style>

</html>