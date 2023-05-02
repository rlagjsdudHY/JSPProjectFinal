<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%

%> 

<%@ page import="pack.bbsGallery.GalleryBoardBean,java.util.Vector" %>
<jsp:useBean id="gbMgr" class="pack.bbsGallery.GalleryBoardMgr" />

<%
request.setCharacterEncoding("UTF-8");


///////////////////////페이징 관련 속성 값 시작///////////////////////////
// 페이징(Paging) = 페이지 나누기를 의미함
int GtotalRecord = 0;        // 전체 데이터 수(DB에 저장된 row 개수)
int GnumPerPage = 6;    // 페이지당 출력하는 데이터 수(=게시글 숫자) int Gend 숫자도 똒같이 바꿔야함.
int GpagePerBlock = 5;   // 블럭당 표시되는 페이지 수의 개수
int GtotalPage = 0;           // 전체 페이지 수
int GtotalBlock = 0;          // 전체 블록수

 /*  페이징 변수값의 이해 
GtotalRecord=> 200     전체레코드
GnumPerPage => 10
GpagePerBlock => 5
GGtotalPage => 20
GtotalBlock => 4  (20/5 => 4)
*/

int GnowPage = 1;          // 현재 (사용자가 보고 있는) 페이지 번호
int GnowBlock = 1;         // 현재 (사용자가 보고 있는) 블럭

int Gstart = 0;     // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
int Gend = 6;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
                          // select * from T/N where... order by ... limit Gstart, Gend;

int GlistSize = 0;    // 1페이지에서 보여주는 데이터 수
						//출력할 데이터의 개수 = 데이터 1개는 가로줄 1개

// 게시판 검색 관련소스
String GkeyField = ""; // DB의 컬럼명
String GkeyWord = ""; // DB의 검색어
						
if (request.getParameter("GkeyWord") != null) {
	GkeyField = request.getParameter("GkeyField");
	GkeyWord = request.getParameter("GkeyWord");
}


						
if (request.getParameter("GnowPage") != null) {
	GnowPage = Integer.parseInt(request.getParameter("GnowPage"));
	Gstart = (GnowPage * GnumPerPage) - GnumPerPage;
	Gend = GnumPerPage;            
}



/*
 select * from tblboard order by num desc limit 10, 10;
데이터가 100개   =>   num :  100  99   98    97 ... 91 |  90        1
                       Gstart, Gend :   0    1    2     3....   9      10
페이지당 출력할 데이터 수 10개
현재 페이지 1페이지라면    => 1페이지의 출력결과   100 ~ 91
2페이지   90~81
3페이지    80~71
*/

GtotalRecord = gbMgr.getTotalCount(GkeyField, GkeyWord);   
// 전체 데이터 수 반환

GtotalPage = (int)Math.ceil((double)GtotalRecord/GnumPerPage);
GnowBlock = (int)Math.ceil((double)GnowPage/GpagePerBlock);
GtotalBlock = (int)Math.ceil((double)GtotalPage/GpagePerBlock);

///////////////////////페이징 관련 속성 값 끝///////////////////////////

Vector<GalleryBoardBean> GvList = null;
%>   

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible"  >
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>게시판 목록</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/style_Template.css">
	<link rel="stylesheet" href="/style/style_GBBS.css">
	<script src="/resource/jquery-3.6.0.min.js"></script>
	<script src="/adminScript/script_adminGBBS.js"></script>
</head>

<body>
    <div id="wrap">
    	
    	<main id="main" class="dFlex">
    	
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">
    		
    		<%
				String GprnType = "";
				if (GkeyWord.equals("null") || GkeyWord.equals("")) {
					GprnType = "전체 게시글";
				} else {
					GprnType = "검색 결과";
				}
			%>
    		
	    		<div id="pageInfo" class="dFlex">
					<span><%=GprnType %> :  <%=GtotalRecord%> 개</span>
					<span>페이지 :  <%=GnowPage + " / " + GtotalPage%></span>  
				</div>	
					
			<table id="boardList">
				<thead>
					<tr>
<!-- 						<th>번호</th> -->
<!-- 						<th>제목</th> -->
<!-- 						<th>이름</th> -->
<!-- 						<th>날짜</th> -->
<!-- 						<th>조회수</th> -->
					</tr>		
					<tr>
						<td colspan="5" class="spaceTd"></td>
					</tr>		
				</thead>
				<tbody id="gridt"> 
			<!-- gridt가 게시글 본체 -->
	
			
			<%
			GvList = gbMgr.getBoardList(GkeyField, GkeyWord, Gstart, Gend);  // DB에서 데이터 불러오기
			GlistSize = GvList.size();			
			
				if (GvList.isEmpty()) {
					// 데이터가 없을 경우 출력 시작
				%> 
					<tr>
						<td colspan="5">
						<%="게시물이 없습니다." %>
						</td>
					</tr>				
				<%
					// 데이터가 없을 경우 출력 끝
				} else {
					// 데이터가 있을 경우 출력 시작
				%>
					
							
				<%
					for (int i=0; i<GnumPerPage; i++) {		
						
						if(i==GlistSize) break;
						
						GalleryBoardBean gbean = GvList.get(i);
						
						int num = gbean.getNum();
						String uname = gbean.getUname();
						String subject = gbean.getSubject();
						String regtm = gbean.getRegtm();
						String filename = gbean.getFilename(); // 김헌영 수정
						int depth = gbean.getDepth();
						
						int readcnt = gbean.getReadcnt();
						//여기서부터 아이콘 테스트
						 boolean hasAttachment = filename != null && !filename.isEmpty(); // 파일 첨부 여부
						 Date postDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(regtm);
 						 Date now = new Date();
  					long diff = now.getTime() - postDate.getTime();
 						 long hours = diff / (60 * 60 * 1000);
  					boolean isNew = hours < 24;
				%>
					<tr class="prnTr" onclick="Gread('<%=num%>', '<%=GnowPage%>')">
					<%
					//int prnNum = GtotalRecord - ((GnowPage-1) * GnumPerPage) - i; 
					// num와 prnNum는 전혀 관계없음
					%>
<!-- 						<td> -->
<%-- 							<% if (depth == 0) out.print(num);   // 답변글이 아님을 의미함 %> --%>
<!-- 						</td>  -->
<!--  게시글 번호 없앰 -->
						<td class="subjectTd">
							<% 
								 if (depth > 0) {    // 답변글을 의미함
									 for(int blank=0; blank<depth; blank++) {
										 out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
									 }
									 out.print("<img src='/images/replyImg.png' alt=''> ");
								 } 
// 								out.print(subject); 
							%>
<!-- 						</td> -->
<%-- 						<td><%=uname %></td> --%>
<%-- 						<td><%=regtm %></td> --%>
<%-- 						<td><%=readcnt %></td> --%>
<%-- 						<% if (filename != null && !filename.equals("")) { %> --%>
<%--    						 <td><img src="../fileupload/<%=filename%>" alt=""></td> <!-- 김헌영수정 --> --%>
<%-- 						<% } else { %> --%>
<!--    						 <td><img src="../fileupload/크기수정.png" alt=""></td> -->
<%-- 						<% } %> --%>
<!--   김헌영 구역 -->
				<table class="bbsItem">
                    <tbody id="gridbbs">
                        <tr>
                             <% if (filename != null && !filename.equals("")) { %>
   						 <td><img src="../fileupload/<%=filename%>" width="220px" height="220px" alt=""></td> <!-- 김헌영수정 -->
						<% } else { %>
   						 <td><img src="../fileupload/크기수정.png" width="220px" height="220px" alt=""></td>
						<% } %>
                        </tr>
                        <tr>
                            <td>
                             <% if (isNew && hasAttachment) { %>
                               <span class="a"><h1><%=subject %> <img src="/fileupload/newicon.png" alt="icon"><img src="/fileupload/clip_16x10.png" alt="attachment"> </h1></span>
								<% } else if (hasAttachment && !isNew) { %>
								<span class="a"><h1><%=subject %> <img src="/fileupload/newicon.png" alt="icon"></h1></span>
								<% } else if (!hasAttachment && isNew) { %>										
										<span class="a"><h1><%=subject %> <img src="/fileupload/newicon.png" alt="icon"></h1></span>				   
                               <% } else if (!hasAttachment && !isNew) { %>
                               	<span class="a"><h1><%=subject %></h1></span>
							  <% } %>
                                <br>
                                <span class="goodsName">작성자 : <%=uname %></span><br>
                                <span class="option">조회수 : <%=readcnt %></span><br>
                                <span class="option"><%=regtm %></span>
                                
                            </td>
                        </tr>
                    </tbody>
                </table>
				
<!-- 김헌영 구역 끝 -->
					</tr>

				<%
					}	// Gend for  데이터가 있을 경우 출력 끝
				}   // Gend if  
				
				%>
					
					
				</tbody>
				
				<!-- 	그리드를 넣기위한 구획 나누기 시작	table과 div 사이에 검색,번호 등등 들어감 -->
			</table>
		<tr id="listBtnArea">
						<td colspan="2">
						 
						</td>
						
						<td colspan="3">
						
							<form name="searchFrm" class="dFlex"
									id="searchFrm">
							
								<div>
									<select name="GkeyField" id="GkeyField">
										<option value="subject" 
												<% if(GkeyField.equals("subject")) out.print("selected"); %>>제  목</option>
										<option value="uName" 
												<% if(GkeyField.equals("uName")) out.print("selected"); %>>이  름</option>
										<option value="content" 
												<% if(GkeyField.equals("content")) out.print("selected"); %>>내  용</option>
									</select>
								</div>
								<div>
									<input type="text" name="GkeyWord" id="GkeyWord"
									  id="GkeyWord" size="20" maxlength="30" value="<%=GkeyWord%>">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>
															
							</form>
							
							<!-- 검색결과 유지용 매개변수 데이터시작 -->
							<input type="hidden" id="pGkeyField" value="<%=GkeyField%>">
							<input type="hidden" id="pGkeyWord" value="<%=GkeyWord%>">
							<!-- 검색결과 유지용 매개변수 데이터끝 -->
						
						</td>
					</tr>  <!-- tr#listBtnArea -->
					
					<tr id="listPagingArea">
						
					<!-- 페이징 시작 -->
						<td colspan="5" id="pagingTd">
				<%
				int GpageGstart = (GnowBlock - 1 ) * GpagePerBlock + 1;
							// 26개 자료기준
							// 현재 기준 GnumPerPage : 5;    // 페이지당 출력 데이터 수
							//            GpagePerBlock : 5;  //  블럭당 페이지 수
							//            GnowBlock : 현재블럭
							//            GtotalBlock : 전체블럭
							//  -------------------------------------------------
							//            GtotalRecord : 26    GtotalPage : 6
							
							// 적용결과  GnowBlock : 1  =>   GpageGstart : 1   GpageGend : 5
							//            GnowBlock : 2  =>   GpageGstart : 6   GpageGend : 6( = GtotalPage)
							//
				int GpageGend = (GnowBlock < GtotalBlock) ? 	GpageGstart + GpagePerBlock - 1 :  GtotalPage;
				                                        
				// 블럭당 5페이지 출력 =>        GpageGstart    GpageGend
				//                          1블럭        1                 5
				//                          2블럭        6                 10    		
				// 블럭마다 시작되는 첫 페이지와 마지막 페이지 관련 작업				
				if (GtotalPage != 0) {   //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
				%>
					
					<% if (GnowBlock>1) { 	   // 페이지 블럭이 2이상이면 => 2개이상의 블럭이 있어야 가능 %>
								<span class="moveBlockArea" onclick="moveBlock('<%=GnowBlock-1%>', '<%=GpagePerBlock%>')">
								&lt; 
								</span>
					<% } else { %>
					            <span class="moveBlockArea" ></span>
					<% } %>
				
					<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
					<% 
					/*
					out.print("GtotalRecord : " + GtotalRecord + "<br>");
					out.print("GpagePerBlock : " + GpagePerBlock + "<br>");
					out.print("GnumPerPage : " + GnumPerPage + "<br>");
					out.print("GtotalPage : " + GtotalPage + "<br>");
					out.print("GpageGstart : " + GpageGstart + "<br>");
					out.print("GpageGend : " + GpageGend + "<br>");
					out.print("GnowPage : " + GnowPage + "<br>");
					out.print("GnowBlock : " + GnowBlock + "<br>");
					out.print("GtotalBlock : " + GtotalBlock + "<br>");
					*/
					
					             // 2        <     6                     
						for (   ; GpageGstart<=GpageGend; GpageGstart++) { %>
							<% if (GpageGstart == GnowPage) {   // 현재 사용자가 보고 있는 페이지 %>
								<span class="GnowPageNum"><%=GpageGstart %></span>
							<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
							 	<span class="pageNum" onclick="movePage('<%=GpageGstart %>')">
									<%=GpageGstart %>
							 	</span>					
							<% } // Gend If%>		 	
					<% }  // Gend For%>
					<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
					
				
				<% if (GtotalBlock>GnowBlock) { // 다음 블럭이 남아 있다면  %>
							<span  class="moveBlockArea" onclick="moveBlock('<%=GnowBlock+1%>', '<%=GpagePerBlock%>')">
							&gt;
							</span>
			
				<% } else { %>
				            <span class="moveBlockArea"></span>
				<% } %>
				
					
					
				<%
				} else {
					out.print("<b>[ Paging Area ]</b>"); // Gend if
				}
				%>						
						
						</td>
					</tr>
<!-- 					그리드를 넣기위한 구획 나누기 끝 table과 div 사이에 검색,번호 등등 들어감 -->
		
    		</div>
    		<!-- 실제 작업 영역 끝 -->
    		
    		    	
    	</main>
    	<!--  main#main  -->
       
        
    </div>
    <!-- div#wrap -->

</body>
<script>

function movePage(p1) {
  let param = "/admin/admin.jsp?GnowPage="+p1;
  location.href = param;
}
 
</script>

<style>
 
tbody#gridt {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-auto-flow: row dense;
}

/* 바꾼 페이지 버튼 스타일 */
/* 리스트 /bbs/list.jsp  페이징 영역 시작 */

tr#listPagingArea td {
	padding-top: 20px;
}
td#pagingTd {	
	text-align: center;
}
td#pagingTd span {
	width: 30px;
	height: 30px;
	font-weight: 12px;
	text-align: center;
	line-height: 30px;
	margin: 10px 2px;
	display: inline-block;
	cursor: pointer;
}

span:hover {
	color: #aaa;
}

span.GnowPageNum {
	font-size: 16px;
	font-weight: bold;
	background-color: rgba(136, 136, 136, 0.1);
	cursor: default;
}

span.moveBlockArea {
	width: 30px;
	height: 30px;
	font-size: 12px;
	margin: 0 6px;
	display: inline-block;
}
/* 리스트 /bbs/list.jsp  페이징 영역 끝 */
</style>

</html> 