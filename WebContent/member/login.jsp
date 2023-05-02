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
    	
    	
    	<main id="main" class="dFlex">
    	
    		<div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="/ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div>
    		
    		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="loginDiv">

				<form id="loginFrm" name="loginFrm" method="post">
	        
		        	<div id="loginArea">	        	
		        		<div id="loginInput">
		        			<input type="text" name="uid" placeholder="아이디 입력" id="uid">
		        			<input type="password" name="upw" placeholder="비밀번호 입력" id="upw">
<%-- 		        		    <input type="hidden" name="loginip" value="<%=request.getRemoteAddr()%>"> --%>
<%--   							<input type="hidden" name="logintm" value="<%=new Date()%>"> --%>
<!--   							<input type="hidden" name="logincnt" value="1"> -->
  							<input type="hidden" name="conndev" value="pc">
		        		</div>
		        		
		        		<button type="button" id="loginBtn">로그인</button>
		        		
		        	</div>
		        	<!-- div#loginArea -->
	        	
	        	</form>

    		</div>
    		<!-- 실제 작업 영역 끝 div.loginDiv -->
    		    	
    	</main>
    	<!--  main#main  -->
    
        	   	
    	<!--  푸터템플릿 시작 -->
		<%@ include file="/ind/footerTmp.jsp" %>
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

</html>