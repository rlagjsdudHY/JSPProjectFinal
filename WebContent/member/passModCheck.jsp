<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");
String uidSession = (String)session.getAttribute("uidSession"); 
%>
   
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
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

				<form id="passChk" name="passChk">
	        
		        	<div id="loginArea">	        	
		        		<div id="loginInput">
		        			<input type="password" name="upw" placeholder="비밀번호 입력" id="upw" form="passChk">
		        		</div>
		        		
		        		<button type="button" id="PassChkBtn">확인</button>
		        		
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
		<script>
		$(document).ready(function() {
		    // 확인 버튼 클릭 시
		    $("#PassChkBtn").on("click", function() {
		        let upw = $("#upw").val();
		        let original_pw = "1234"; // 여기에 원래 비밀번호를 입력해주세요.
		        
		        if (upw !== original_pw) {
		            alert("입력한 비밀번호가 원래 비밀번호와 다릅니다.");
		        } else {
		            $("#passChk").attr("action", "passModCheckProc.jsp");
		            $("#passChk").submit();
		        }
		    });
		});
			
		</script>
</body>

</html>