<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입동의</title>
    <link rel="stylesheet" href="/style/style_Common.css">    
    <link rel="stylesheet" href="/style/style_Template.css">
    <script src="/resource/jquery-3.6.0.min.js"></script>
    <script src="/script/script_Join.js"></script>
</head>

<body>
    <div id="wrap">
    	
    	<!--  헤더템플릿 시작 -->
		<%@ include file="/ind/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->    	
    	
	    	<main id="main" class="dFlex">
	    	
	    		<!-- 실제 작업 영역 시작 -->
	    		<div id="contents" class="joinAgree">
	    		
	    			<div id="chkAllArea">
	    				<label>
	    					<input type="checkbox" id="chkAll">
	    					이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.
	    				</label>
	    			</div>
	    			
	    			<div id="licenseArea">
	    			    			
		    			<div class="termArea">
			    			<h3>[필수] 이용약관 동의</h3>
			    			<!--  iframe, textarea, div 중 선택하여 제작한다. -->
			    			<iframe src="/ind/usingAgree.jsp" class="usingAgree"></iframe>
			    			<label>
				    			이용약관에 동의하십니까?
				    			<input type="checkbox" class="usingAgreeChk chkRequired"
				    			data-link="0"> 동의함 (필수)
			    			</label> 
		    			</div>
		    			    			    			    		
		    			<div class="termArea">	    			
			    			<h3>[필수] 개인정보 수집 및 이용 동의</h3>
			    			<iframe src="/ind/personalInfoAgree.jsp" class="usingAgree"></iframe>
			    			<label>
				    			개인정보 수집 및 이용에 동의하십니까?
				    			<input type="checkbox" class="usingAgreeChk chkRequired"
				    			data-link="1"> 동의함 (필수)
			    			</label> 
			    		</div>	    			    		
		    			    		
		    			<div class="termArea">    			
			    			<h3>[선택] 쇼핑정보 수신 동의</h3>
			    			<iframe src="/ind/shopInfoAgree.jsp" class="usingAgree"></iframe>
			    			<label>
				    			쇼핑정보 수신에 동의하십니까?
				    			<input type="checkbox" class="usingAgreeChk"
				    			data-link="2"> 동의함 (선택)
			    			</label> 
		    			</div>
	    			
	    			</div>  <!--  div#licenseArea -->
	    		
	    		
	    		</div>
	    		<!-- 실제 작업 영역 끝 -->
	    		    	
	    	</main>
	    	<!--  main#main  -->
		
	   	<form id="joinFrm" method="post" action="/member/member.jsp">	    	
	   		<input type="hidden" name="vCode" value="chkOK1234">  <!-- 참고. 비정상접속 제한용 난수값으로 처리함 -->
	    	<div id="formArea">
	    		<button type="button">회원가입</button>
	    	</div>
    	
    	</form>  <!--  form#joinFrm -->
    
        	   	
    	<!--  푸터템플릿 시작 -->
		<%@ include file="/ind/footerTmp.jsp" %>
    	<!--  푸터템플릿 끝 -->  
        
    </div>
    <!-- div#wrap -->

</body>

</html>