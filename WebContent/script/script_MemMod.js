/**
 * 
 */
 
 $(function(){
	
	
	///////////////////////////////////////////////////////////////////////////
	/*//////////   회원정보 수정(/member/memberMod.jsp) 시작   /////////*/
	///////////////////////////////////////////////////////////////////////////
	
	// 필수입력 영역 배경색 적용
	$("#modFrmTbl td.req").parent("tr").css({
		"background-color": "rgba(128, 128, 128, 0.07)"
	});
	
	// 선택된 Email 도메인 자동입력  
	$("#modFrm select#emailDomain").change(function(){
		// change 이벤트 핸들러 => value값이 변경되었을때 인식하는 이벤트
		let emailDomain = $(this).val().trim();
		$("input#uemail_02").val(emailDomain);
		if (emailDomain == "") {
			$("input#uemail_02").focus();
		} else {
			$("input#uemail_01").focus();
		}
	});
	
	
	
	
	// 비밀번호 표시하기 
	$("#wrap #modFrmTbl input#pwView").click(function(){
		let chkTF = $(this).prop("checked");     ;     // YN => Yes or No,   TF => True or False
		//alert("chkTF : " + chkTF);
		if (chkTF) {
			$("input#upw").attr("type", "text");
		} else {
			$("input#upw").attr("type", "password");
		}
	});
	
	// 비밀번호 / 비밀번호 확인 동일성 검사   +  유효성검사(정규표현식)
	$("#upw_Re").keyup(function(){ 
		let upw = $("#upw").val();
		let upw_Re = $("#upw_Re").val();
		
		// after( )메서드는 선택자로 지정된 요소 다음에 생성되는 요소를 만드는 기능
		if (upw != upw_Re) {
			$("span#pwChk").text("비밀번호가 다릅니다.");
		} else {
			$("span#pwChk").text("");
		}
		
	});
	
	
	
	// Email 유효성 검사 => 공백검사만!
	$("#emailAuthBtn").click(function(){
		
		let uemail_01 = $("#uemail_01").val().trim();
		let uemail_02 = $("#uemail_02").val().trim();
		
		if (uemail_01 == "") {
			alert("이메일 주소를 확인해주세요");
			$("#uemail_01").focus();			
		} else if (uemail_02 == "") {
			alert("이메일 주소를 확인해주세요");
			$("#uemail_02").focus();
		} else {
			$("#emailAuthArea").css({"display": "block"});
		}
		
		
	});
	
	
	// 우편번호 찾기 팝업 
	$("#modFrm button#findZipBtn").click(function(){
		
		let url = "/member/zipCheck.jsp";
		let nickName = "zipChkPop";

		let w = screen.width;     // 1920
		let popWidth = 640;
		let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치

		let h = screen.height;    // 1080
		let popHeight = 400;
		let topPos = (h - popHeight) / 2; 		
		
		let prop = "width="+ popWidth +", height="+ popHeight;
			  prop += ", left=" + leftPos + ", top=" + topPos; 
		window.open(url, nickName, prop);
		
	});
	
	
	// 우편번호 팝업창에서 주소 검색
	$("#addrSearchBtn").click(function(){
		let area3 = $("#area3").val().trim();
		if (area3 == "") {
			alert("검색어를 입력해주세요.");
			$("#area3").focus();
		} else {
			$("#zipFrm").submit();
		}
	});
	
	
	// 우편번호 팝업창에서 주소 선택
	$("table#zipResTbl td").click(function(){
		let txtAddr = $(this).children("span").text();
		let zipcode = txtAddr.substring(0, 7);
		let addr = txtAddr.substring(8);
		window.opener.uzipcode.value = zipcode;
		window.opener.uaddr.value = addr;
		window.close();
	});
	
				
					
	
	/* 회원정보수정 버튼 전송 실행 */	
	$("#modSbmBtn").click(function(){		
		fnModSbm();		
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
		if (code == 13) fnModSbm();
    });

	function fnModSbm() {
		
		let upw = $("#upw").val().trim();		
		$("#upw").val(upw);		
		let upw_Re = $("#upw_Re").val().trim();	
		let uname = $("#uname").val().trim();
		$("#uname").val(uname);
		let uemail_01 = $("#uemail_01").val().trim();
		let uemail_02 = $("#uemail_02").val().trim();
		$("#uemail").val(uemail_01+"@"+uemail_02);
		let ubirthday = $("#ubirthday").val().trim();
		
		if (upw == "") {
			alert("비밀번호를 입력해주세요.");
			$("#upw").focus();
			return;
		} else if (upw_Re == "" || upw != upw_Re) {
			alert("비밀번호 일치여부를 확인해주세요.");
			$("#upw_Re").focus();
			return;
		} else if (uname == "") {
			alert("이름을 입력해주세요.");
			$("#uname").focus();
			return;
		} else if (uemail_01 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uemail_01").focus();
			return;
		} else if (uemail_02 == "") {
			alert("이메일 주소를 입력해주세요.");
			$("#uemail_02").focus();
			return;
		} else if (ubirthday != "" && isNaN(ubirthday)) {
			// 생년월일 숫자유효성 검사
			alert("생년월일은 숫자만 입력할 수 있습니다.");
			$("#ubirthday").val("").focus();
			return;
		} else {
			let chkSbmTF = confirm("회원정보를 수정 하시겠습니까?");
			if (chkSbmTF) {
				$("#modFrm").attr("action", "/member/memberModProc.jsp");
				$("#modFrm").submit();
			}
		}
		 
	}
    
		
	///////////////////////////////////////////////////////////////////////////
	/*//////////   회원정보 수정(/member/memberMod.jsp)  끝   /////////*/
	///////////////////////////////////////////////////////////////////////////
	
	
		
	///////////////////////////////////////////////////////////////////////////
	/*//////////   회원 탈퇴(/member/memberMod.jsp)  시작   /////////*/
	///////////////////////////////////////////////////////////////////////////
	
	/*$("#memQuitBtn").click(function(){		
		 alert("/member/memberQuitProc.jsp 파일을 사용하여 회원탈퇴소스를 구현합니다."); 		
	});*/
	
		
	///////////////////////////////////////////////////////////////////////////
	/*//////////   회원 탈퇴(/member/memberMod.jsp)  끝   /////////*/
	///////////////////////////////////////////////////////////////////////////
	
	
});