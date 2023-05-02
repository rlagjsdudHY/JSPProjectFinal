<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bMgr" class="pack.bbs.BoardMgr" scope="page" />
<jsp:useBean id="reBean" class="pack.bbs.BoardBean" scope="page" />
<jsp:setProperty name="reBean" property="*" />

<%
int repUpCnt = bMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
     // 끼어들기가 아닐경우 실행되는 소스 없음.
     
int repInsCnt = bMgr.replyBoard(reBean);

String nowPage = request.getParameter("nowPage");
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");

if(repInsCnt > 0) { 
	// replayUpBoard( )와 replyBoard( )가 정상실행되었음을 의미함.
	
	String url = "/bbs/list.jsp?nowPage="+nowPage;
	url += "&keyField="+keyField;
	url += "&keyWord="+keyWord;
%>    
	<script>
		location.href="<%=url%>";
	</script>
<%
} else {
%>	

	<script>
		let msg = "답변글 등록중 오류가 발생했습니다.\n";
		     msg += "다시 시도해주세요\n";
		     msg += "오류가 지속되면 관리자에게 연락바랍니다.";
		alert(msg);
		history.back();
	</script>

<%
}
%>