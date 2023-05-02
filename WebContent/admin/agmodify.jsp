<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" autoFlush="true" %>
    
    
    
<%@ page import="pack.bbsGallery.GalleryBoardBean" %>
<jsp:useBean id="gbMgr" class="pack.bbsGallery.GalleryBoardMgr"  scope="page" />
    
<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("num"));

//검색어 수신 시작
String keyField = request.getParameter("gkeyField");
String keyWord = request.getParameter("gkeyWord");
//검색어 수신 끝

//현재 페이지 돌아가기 소스 시작
String nowPage = request.getParameter("gnowPage");
//현재 페이지 돌아가기 소스 끝

GalleryBoardBean
gbean = gbMgr.getBoard(numParam);  


int num =  gbean.getNum();
String uid	=	gbean.getUid();
String uname	=	gbean.getUname();
String subject	= gbean.getSubject();
String content	= gbean.getContent();

int pos	= gbean.getPos();
int ref	= gbean.getRef();
int depth	= gbean.getDepth();
String regtm	= gbean.getRegtm();
int readcnt 	= gbean.getReadcnt();
String filename	= gbean.getFilename();
double filesize 	= gbean.getFilesize();
String fUnit = "Bytes";
if(filesize > 1024) {
	filesize /= 1024;	
	fUnit = "KBytes";
} 

String ip	= gbean.getIp();

 
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>수정페이지</title>
		<link rel="shortcut icon" href="#">
		<link rel="stylesheet" href="/style/style_Common.css">
		<link rel="stylesheet" href="/style/style_Template.css">
		<link rel="stylesheet" href="/style/style_BBS.css">
		<script src="/resource/jquery-3.6.0.min.js"></script>
		<script src="/script/script_GBBS.js"></script>	
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
    		<div id="contents" class="bbsWrite">
<!-- 편법코드 <form name="form" method="post" enctype="multipart/form-data" action="result.jsp?keyValue=multipart">
 -->
				<h2>글 수정하기</h2>
				<!-- form 에서 enctype="multipart/form-data" 를 빼버림  -->
				<form name="modFrm" enctype="multipart/form-data"
						  method="post" id="modFrm" >
				
					<table>	
						<tbody>
							<tr>
								<td class="req">성명</td>  <!-- td.req 필수입력 -->
								<td>
									<%=uname%>
									<input type="hidden" name="uname" value="<%=uname%>" form="modFrm">
									<input type="hidden" name="uid" value="<%=uid%>" form="modFrm">
								</td>
							</tr>
							<tr>
								<td class="req">제목</td> <!-- td.req 필수입력 -->
								<td>
									<input type="text" name="subject"
									maxlength="50" id="subject" value="<%=subject%>" form="modFrm">
								</td>
							</tr>
							<tr>
								<td class="contentTD">내용</td>
								<td>
									<textarea name="content" 
									id="content" cols="60" 
									wrap="hard" form="modFrm"><%=content%></textarea>
								</td>
							</tr>
							<tr>
								<td>파일첨부</td>
								<td>
									<span class="spanFile">
										<input type="file" name="filename" id="filename">
									</span>	
								</td>
							</tr>
							<tr>
								<td>내용타입</td>
								<td>
									<label>
										<input type="radio" name="contentType" value="HTML">									
										<span>HTML</span>	
									</label>
									<label>
										<input type="radio" name="contentType" value="TEXT" checked>
										<span>TEXT</span>
									</label>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2"><hr>	</td>							
							</tr>
							<tr>
								<td colspan="2">
									<button type="button" id="modProcBtn">수정하기</button>
									<button type="reset">다시쓰기</button>
									<button type="button" id="listBtn">리스트</button>
								</td>
							</tr>
						</tfoot>
					</table>
					<input type="hidden" name="num" value="<%=num%>" form="modFrm">
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>" form="modFrm">
					
				    <!--  
				    IP주소를 IPv4 형식으로 설정함.(IPv6 형식이 기본으로 설정되어 있음)
				    프로젝트 => Run Configuration => Tomcat 클릭
				    => (x)Argument => VM arguments 입력란 =>
				    -Djava.net.preferIPv4Stack=true  
				     -->
								
				</form>

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
		<script>
// 		$(function(){
// 			$("#modProcBtn").click(function(){
// 				$("#modFrm").attr("action", "/modifyProc.jsp")
// 				$("#modFrm").submit();
// 			});
// 		});
		
		</script>
	 
</html>