<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uId_Session = (String)session.getAttribute("uId_Session"); 
%>    

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible"  >
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인</title>
	<link rel="shortcut icon" href="#">
    <link rel="stylesheet" href="/style/style_Common.css">
    <link rel="stylesheet" href="/style/style_Template.css">
    <script src="/resource/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="wrap">
    	
    	<!--  헤더템플릿 시작, iframe으로 변경 -->
		<%@ include file="/ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
    	
    	<main id="main" class="dFlex">
    	
    		<div id="lnb">
	    		<!--  메인 LNB 템플릿 시작 -->
				<%@ include file="/ind/mainLnbTmp.jsp" %>
	    		<!--  메인 LNB 템플릿 끝 -->    	
    		</div>
    		
    		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents">
    
    			<h1>Main</h1>
    
    		
    			<h2 id="indexGuideMsg">
    			<% if (uId_Session == null) { 	%>
    				작업 중(회원인증, BBS 등)<br> 
    				메인에 노출하고 싶은 결과를 출력
    			<% } else { 
    				
    				out.print(uId_Session + "님이 로그인했습니다.");
    				
    			} %>
    			</h2>
    		
    		</div>
    		<!-- 실제 작업 영역 끝 -->
    		    	
    	</main>
    	<!--  main#main  -->
    
        	   	
    	<!--  푸터템플릿 시작 -->
		<%@ include file="/ind/footerTmp.jsp" %>
    	<!--  푸터템플릿 끝 -->  
        
    </div>
    <!-- div#wrap -->

</body>
</html>