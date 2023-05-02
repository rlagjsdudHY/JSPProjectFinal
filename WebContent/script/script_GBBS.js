/**
 * 
 */
 
 
$(function(){
	
	
	/* 리스트 페이지 글쓰기 버튼 시작 /bbs/list.jsp */	
	$("button#GloginAlertBtn").click(function(){		
		alert("로그인 후 게시글을 작성하실 수 있습니다.");
	});	
	
	$("button#GwriteBtn").click(function(){		
		location.href="/gallerybbs/gwrite.jsp";
	});
	/* 리스트 페이지 글쓰기 버튼 끝 /bbs/list.jsp */
	
	
	/* 글쓰기 페이지 게시글 등록 시작 /bbs/write.jsp */
	$("#regBtn").click(function(){
		let subject = $("#subject").val().trim();		
		
		 if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#writeFrm").attr("action", "/gallerybbs/gwriteProc.jsp");
			$("#writeFrm").submit();
		}
	
	});	
	
	/* 글쓰기 페이지 게시글 등록 끝 /bbs/write.jsp */
	
	
	/* 게시글 삭제버튼 시작 /bbs/read.jsp */
	$("button#delBtn").click(function(){
		
		let chkTF = confirm("게시글을 삭제하시겠습니까?");
		
		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let num = $("input#num").val().trim();
					
			let p3 = $("#pKeyField").val().trim();  // p3 : keyField
		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		    
			let url = "/gallerybbs/gdeleteProc.jsp?";
				url += "num="+num+"&nowPage="+nowPage;
				url += "&keyField="+p3;
				url += "&keyWord="+p4;
			location.href=url;
		} else {
			alert("취소하셨습니다.");	
		}
		
	});
	/* 게시글 삭제버튼 끝 /bbs/read.jsp */
	
	
	
	/* 파일다운로드 시작 /bbs/read.jsp */
	$("span#downloadFile").click(function(){
		$("#downloadForm").submit();
		
	});
	/* 파일다운로드 끝 /bbs/read.jsp */
	
	
	/* 게시글 내용 수정 페이지 이동 시작 /bbs/read.jsp => /bbs/modify.jsp */
	$("button#modBtn").click(function(){	
		
			let num = $("input#num").val().trim();

			let nowPage = $("input#nowPage").val().trim();					
			let p3 = $("#pKeyField").val().trim();  // p3 : keyField
		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord	
		
			let url = "/gallerybbs/gmodify.jsp?";
				url += "num="+num+"&nowPage="+nowPage;
				url += "&keyField="+p3;
				url += "&keyWord="+p4;
			location.href=url;
			
	});
	/* 게시글 내용 수정 페이지 이동 끝 /bbs/read.jsp => /bbs/modify.jsp */



	/* 글수정 페이지 게시글 수정 시작 /bbs/modifyProc.jsp */
	$("#modProcBtn").click(function(){
		let subject = $("#subject").val().trim();		
		
		 if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			// 편법 코드 <form name="form" method="post" enctype="multipart/form-data" action="result.jsp?keyValue=multipart">

			$("#modFrm").attr("action", "/gallerybbs/gmodifyProc.jsp");
			$("#modFrm").submit();
		}
	
	});	
	
	/* 글수정 페이지 게시글 수정 끝 /bbs/modifyProc.jsp */
	
	
	
	
	
			
	/* 게시글 내용보기페이지에서 답변버튼 시작 /bbs/read.jsp */
	$("td.read>button#replyBtn").click(function(){
	
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
				
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
		let url = "/gallerybbs/greply.jsp?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
			url += "&keyField="+p3;
	     	url += "&keyWord="+p4; 
		location.href=url;
	
	});
	/* 게시글 내용보기페이지에서 답변버튼 끝 /bbs/read.jsp */
	
	
	/* 답변입력양식 페이지에서 답변내용 전송 시작 /bbs/reply.jsp */
	$("td.reply>button#replyBtn").click(function(){
		
		let subject = $("#subject").val().trim();
		
		if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {		
			$("#replyFrm").submit();
		}
		
	});
	/* 답변입력양식 페이지에서 답변내용 전송 끝 /bbs/reply.jsp */		
	
	
	
	/* 리스트페이지 검색 시작 /bbs/list.jsp */	
	$("button#searchBtn").click(function(){
		let keyWord = $("#keyWord").val().trim();
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});	
	/* 리스트페이지 검색 끝 /bbs/list.jsp */	
	
	
	/* 검색 결과를 유지한 리스트페이지 이동 시작 /bbs/read.jsp */
	$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	     
		let url = "/gallerybbs/glist.jsp?nowPage=" + param;		    
		    url += "&keyField="+p3;
	     	url += "&keyWord="+p4 ; 
		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /bbs/read.jsp */
	
	
});
// End of $(function(){});	
	
	
/* 상세내용 보기 페이지 이동 시작 /bbs/list.jsp => read.jsp */
function read(p1, p2) {
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let param = "gread.jsp?num="+p1;
	     param += "&nowPage="+p2;
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href=param;
}		
/* 상세내용 보기 페이지 이동 끝 /bbs/list.jsp => read.jsp  */
 
 








