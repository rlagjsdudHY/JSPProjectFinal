<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack.member.MemberMgr"  />   
<%
String uidSession = (String) session.getAttribute("uidSession");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호수정</title>
<link rel="stylesheet" href="/style/style_Common.css">
<link rel="stylesheet" href="/style/style_Template.css">
<script src="/resource/jquery-3.6.0.min.js"></script>
<script src="/script/script_MemMod.js"></script>
</head>

<body>
	<div id="wrap">

		<!--  헤더템플릿 시작 -->
		<%@ include file="/ind/headerTmp.jsp"%>
		<!--  헤더템플릿 끝 -->


		<main id="main" class="dFlex">

			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="memQuitDiv">

				<form name="memQuitFrm" id="memQuitFrm" method="post" >
					<h1>비밀번호수정</h1>
					<p>아래 버튼을 클릭하시면 비밀번호를 수정합니다</p>
					<label for="uid">아이디:</label> 
					
					<input type="text" id="uid"
						name="uid" form="memQuitFrm"><br>
					<label for="upw">비밀번호:</label> 
						<input type="password" id="upw"
						name="upw" form="memQuitFrm"><br>
				 
					<button type="button" id="memQuitBtn">회원 탈퇴하기</button>
				</form>

			</div>
			<!-- 실제 작업 영역 끝 -->

		</main>
		<!--  main#main  -->


		<!--  푸터템플릿 시작 -->
		<%@ include file="/ind/footerTmp.jsp"%>
		<!--  푸터템플릿 끝 -->

	</div>
	<!-- div#wrap -->

	<script>
	   $(document).ready(function() {
	        // 회원 탈퇴 버튼 클릭 시
	        $("#memQuitBtn").on("click", function() {
	        let uid = $("#uid").val();
	        let upw = $("#upw").val();
	            $("#memQuitFrm").attr("action","memberQuitProc.jsp");
	            $("#memQuitFrm").submit();
	        });
	    });
	</script>

</body>

</html>