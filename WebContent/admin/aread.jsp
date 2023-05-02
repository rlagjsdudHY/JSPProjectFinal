<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 String uidSession = (String)session.getAttribute("uidSession");
 
 %> 

<%@ page import="pack.bbs.BoardBean" %>
<jsp:useBean id="bMgr" class="pack.bbs.BoardMgr"  scope="page" />
<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("num"));

// 검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
// 검색어 수신 끝

// 현재 페이지 돌아가기 소스 시작
String nowPage = request.getParameter("nowPage");
// 현재 페이지 돌아가기 소스 끝

bMgr.upCount(numParam);    // 조회수 증가
BoardBean bean = bMgr.getBoard(numParam);   
//  List.jsp에서 클릭한 게시글의 매개변수로 전달된 글번호의 데이터 가져오기
     
int num =  bean.getNum();
String uid	=	bean.getUid();
String uname	=	bean.getUname();
String subject	= bean.getSubject();
String content	= bean.getContent();

int pos	= bean.getPos();
int ref	= bean.getRef();
int depth	= bean.getDepth();
String regtm	= bean.getRegtm();
int readcnt 	= bean.getReadcnt();
String filename	= bean.getFilename();
double filesize 	= bean.getFilesize();
String fUnit = "Bytes";
if(filesize > 1024) {
	filesize /= 1024;	
	fUnit = "KBytes";
} 

String ip	= bean.getIp();

session.setAttribute("bean", bean);
%>   	

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" >
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글내용 보기</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/style_Template.css">
	<link rel="stylesheet" href="/style/style_BBS.css">
	<script src="/resource/jquery-3.6.0.min.js"></script>
	<script src="/adminScript/script_adminBBS.js"></script>
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
    		<div id="contents" class="bbsRead">

				<!--  게시글 상세보기 페이지 내용 출력 시작 -->
				<h2><%=subject %></h2>
				
				<table id="readTbl">
					<tbody id="readTblBody">
						<tr>
							<td>작성자</td>  <!-- td.req 필수입력 -->
							<td><%=uname %></td>
							<td>등록일</td>  <!-- td.req 필수입력 -->
							<td><%=regtm %></td>
						</tr>
						<tr>
							<td>첨부파일</td> <!-- td.req 필수입력 -->
							<td colspan="3">
								<input type="hidden" name="filename" value="<%=filename%>" 
											id="hiddenFname" form="downloadForm">
							<% if (filename != null && !filename.equals("")) { %>						
								<span id="downloadFile"><%=filename%></span>							
								(<span><%=(int)filesize + " " + fUnit%></span>)
							<% } else { %>
								등록된 파일이 없습니다.
							<% } %>
							</td>
						</tr>
						<tr>
							<td colspan="4" id="readContentTd"><pre><%=content %></pre></td>
						</tr>					
					</tbody>
					 
					<tfoot id="readTblFoot">	
						<tr>
							<td colspan="4" id="footTopSpace"></td>							
						</tr>			     
						<tr>
							<td colspan="4" id="articleInfoTd">
								<span><%="조회수 : " + readcnt %></span>
								<span>(<%="IP : " + ip %>)</span>							
							</td>							
						</tr>
						<tr>
							<td colspan="4" id="hrTd"><hr></td>							
						</tr>
						<tr>
							<%
							String listBtnLabel = "";
							if(keyWord.equals("null") || keyWord.equals("")) {
								listBtnLabel = "리스트";
							} else {
								listBtnLabel = "검색목록";
							}
							%>
						
							<td colspan="4" id="btnAreaTd" class="read">
								<button type="button" id="listBtn"><%=listBtnLabel %></button>
								
								<% if (uidSession==null ) { %>
								<button type="button" onclick="alert('로그인이 필요합니다.');">답 변</button>
								<% } else { %>
								<button type="button" id="replyBtn">답 변</button>
								<% } %>
								<% 
									// out.print("uidSession : "+ uidSession + "<br>" + "uid : "+ uid);
									if ((uidSession!=null && uidSession.equals(uid)) || (uidSession.equals("admin")))  { 
										// 수정 전 원본 uidSession!=null && uidSession.equals(uid)) 
								%>
								<button type="button" id="modBtn">수 정</button>
								<button type="button" id="delBtn">삭 제</button>
								<% } %>
							</td>
						</tr>
					</tfoot>
					 
				</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" id="pKeyField" value="<%=keyField%>">
				<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
				<!-- 검색어전송 끝 -->
			  
				<!--  게시글 상세보기 페이지 내용 출력 끝 -->
				<form action="/bbs/download.jsp" id="downloadForm"></form>

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