/**
 * 
 */

$(function(){
	
	
	/* 로그인 버튼 전송 실행 */	
	$("#loginBtn").click(function(){		
		fnLoginSbm();		
	});
	
	/* 폼실행 엔터키 이벤트 처리 */	
	$(window).keydown(function(){
		let code = event.keyCode;
		if (code == 13) return false;
	});
	
	/* 폼실행 엔터키 이벤트 처리 */
	$(window).keyup(function(){		
		let code = event.keyCode;
		//alert("code : " + code);
		if (code == "13") fnLoginSbm();
    });
	
	
	function fnLoginSbm() {
		
		let uid = $("#uid").val().trim();
		$("#uid").val(uid);
		let upw = $("#upw").val().trim();		
		$("#upw").val(upw);
		
		
		if (uid == "") {
			alert("아이디를 입력해주세요.");
			$("#uid").focus();
			return;
		} else if (upw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#upw").focus();
			return;
		} else {			
			$("#loginFrm").attr("action", "/member/loginProc.jsp");
			$("#loginFrm").submit();
		}
		
		
	}
	
});

// 어드민 로그인
	$(function(){
	
	
	/* 로그인 버튼 전송 실행 */	
	$("#adminLoginBtn").click(function(){		
		adminfnLoginSbm();		
	});
	
	/* 폼실행 엔터키 이벤트 처리 */	
	$(window).keydown(function(){
		let code = event.keyCode;
		if (code == 13) return false;
	});
	
	/* 폼실행 엔터키 이벤트 처리 */
	$(window).keyup(function(){		
		let code = event.keyCode;
		//alert("code : " + code);
		if (code == "13") adminfnLoginSbm();
    });
	
	
	function adminfnLoginSbm() {
		
		let uid = $("#uid").val().trim();
		$("#uid").val(uid);
		let upw = $("#upw").val().trim();		
		$("#upw").val(upw);
		
		
		if (uid == "") {
			alert("아이디를 입력해주세요.");
			$("#uid").focus();
			return;
		} else if (upw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#upw").focus();
			return;
		} else {			
			$("#adminLoginFrm").attr("action", "/admin/adminProc.jsp");
			$("#adminLoginFrm").submit();
		}
		
		
	}
	
});
// 어드민 로그인 끝
 