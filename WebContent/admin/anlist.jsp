<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat"%>
<%

%> 

<%@ page import="pack.notice.NBoardBean,java.util.Vector" %>
<jsp:useBean id="nMgr" class="pack.notice.BoardMgr" />

<%
request.setCharacterEncoding("UTF-8");


///////////////////////페이징 관련 속성 값 시작///////////////////////////
// 페이징(Paging) = 페이지 나누기를 의미함
int NtotalRecord = 0;        // 전체 데이터 수(DB에 저장된 row 개수)
int NnumPerPage = 10;    // 페이지당 출력하는 데이터 수(=게시글 숫자)
int NpagePerBlock = 10;   // 블럭당 표시되는 페이지 수의 개수
int NtotalPage = 0;           // 전체 페이지 수
int NtotalBlock = 0;          // 전체 블록수

 /*  페이징 변수값의 이해 
totalRecord=> 200     전체레코드
numPerPage => 10
pagePerBlock => 5
totalPage => 20
totalBlock => 4  (20/5 => 4)
*/

int NnowPage = 1;          // 현재 (사용자가 보고 있는) 페이지 번호
int NnowBlock = 1;         // 현재 (사용자가 보고 있는) 블럭

int Nstart = 0;     // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
int Nend = 10;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
                          // select * from T/N where... order by ... limit start, end;

int NlistSize = 0;    // 1페이지에서 보여주는 데이터 수
						//출력할 데이터의 개수 = 데이터 1개는 가로줄 1개

// 게시판 검색 관련소스
String NkeyField = ""; // DB의 컬럼명
String NkeyWord = ""; // DB의 검색어
						
if (request.getParameter("NkeyWord") != null) {
	NkeyField = request.getParameter("NkeyField");
	NkeyWord = request.getParameter("NkeyWord");
}


						
if (request.getParameter("NnowPage") != null) {
	NnowPage = Integer.parseInt(request.getParameter("NnowPage"));
	Nstart = (NnowPage * NnumPerPage) - NnumPerPage;
	Nend = NnumPerPage;            
}



/*
 select * from tblboard order by num desc limit 10, 10;
데이터가 100개   =>   num :  100  99   98    97 ... 91 |  90        1
                       start, end :   0    1    2     3....   9      10
페이지당 출력할 데이터 수 10개
현재 페이지 1페이지라면    => 1페이지의 출력결과   100 ~ 91
2페이지   90~81
3페이지    80~71
*/

NtotalRecord = nMgr.getTotalCount(NkeyField, NkeyWord);   
// 전체 데이터 수 반환

NtotalPage = (int)Math.ceil((double)NtotalRecord/NnumPerPage);
NnowBlock = (int)Math.ceil((double)NnowPage/NpagePerBlock);
NtotalBlock = (int)Math.ceil((double)NtotalPage/NpagePerBlock);

///////////////////////페이징 관련 속성 값 끝///////////////////////////

Vector<NBoardBean> NvList = null;
%>   

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" >
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공지사항 목록</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/style_Template.css">
	<link rel="stylesheet" href="/style/style_BBS.css">
	<script src="/resource/jquery-3.6.0.min.js"></script>
	<script src="/adminScript/script_adminNBBS.js"></script>
</head>

<body>
    <div id="wrap">
    	
    	 
    	<main id="main" class="dFlex">
    	 
    		
    		
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">
    		
    		<%
				String NprnType = "";
				if (NkeyWord.equals("null") || NkeyWord.equals("")) {
					NprnType = "전체 게시글";
				} else {
					NprnType = "검색 결과";
				}
			%>
    		
	    		<div id="pageInfo" class="dFlex">
					<span><%=NprnType %> :  <%=NtotalRecord%> 개</span>
					<span>페이지 :  <%=NnowPage + " / " + NtotalPage%></span>  
				</div>	
					
			<table id="boardList">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>		
					<tr>
						<td colspan="5" class="spaceTd"></td>
					</tr>		
				</thead>
				<tbody>
			
	
			
			<%
			NvList = nMgr.getBoardList(NkeyField, NkeyWord, Nstart, Nend);  // DB에서 데이터 불러오기
			NlistSize = NvList.size();			
			
				if (NvList.isEmpty()) {
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
					for (int i=0; i<NnumPerPage; i++) {		
						
						if(i==NlistSize) break;
						
						NBoardBean bean = NvList.get(i);
						
						int num = bean.getNum();
						String uname = bean.getUname();
						String subject = bean.getSubject();
						String regtm = bean.getRegtm();
						
						int depth = bean.getDepth();
						
						int readcnt = bean.getReadcnt();
						//여기서부터 아이콘 테스트 
						
						String filename = bean.getFilename(); // 파일 이름
  boolean hasAttachment = filename != null && !filename.isEmpty(); // 파일 첨부 여부
						Date postDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(regtm);
						 Date now = new Date();
 					long diff = now.getTime() - postDate.getTime();
						 long hours = diff / (60 * 60 * 1000);
 					boolean isNew = hours < 24;
				%>
					<tr class="prnTr" onclick="Nread('<%=num%>', '<%=NnowPage%>')">
					<%
					//int prnNum = totalRecord - ((nowPage-1) * numPerPage) - i; 
					// num와 prnNum는 전혀 관계없음
					%>
						<td>
							<% if (depth == 0) out.print(num);   // 답변글이 아님을 의미함 %>
						</td> 
						<td class="subjectTd">
							<% 
								 if (depth > 0) {    // 답변글을 의미함
									 for(int blank=0; blank<depth; blank++) {
										 out.print("&nbsp;&nbsp;&nbsp;&nbsp;");
									 }
									 out.print("<img src='/images/replyImg.png' alt=''> ");
								 } 
							if (isNew) {
								out.print(subject+" "+"<img src='/fileupload/newicon.png' alt='new icon'>");
							}else {
								out.print(subject);}
							if (hasAttachment) {
							    out.print("<img src='/fileupload/clip_16x10.png' alt='attachment'>");
							  }
								
							%>
						</td>
						<td><%=uname %></td>
						<td><%=regtm %></td>
						<td><%=readcnt %></td>
					</tr>
				<%
					}	// end for  데이터가 있을 경우 출력 끝
				}   // end if  	
				%>
					
					<tr id="listBtnArea">
						<td colspan="2">
						</td>
						
						<td colspan="3">
						
							<form name="searchFrm" class="dFlex"
									id="searchFrm">
							
								<div>
									<select name="keyField" id="keyField">
										<option value="subject" 
												<% if(NkeyField.equals("subject")) out.print("selected"); %>>제  목</option>
										<option value="uName" 
												<% if(NkeyField.equals("uName")) out.print("selected"); %>>이  름</option>
										<option value="content" 
												<% if(NkeyField.equals("content")) out.print("selected"); %>>내  용</option>
									</select>
								</div>
								<div>
									<input type="text" name="keyWord" id="keyWord"
									  id="keyWord" size="20" maxlength="30" value="<%=NkeyWord%>">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>
															
							</form>
							
							<!-- 검색결과 유지용 매개변수 데이터시작 -->
							<input type="hidden" id="pKeyField" value="<%=NkeyField%>">
							<input type="hidden" id="pKeyWord" value="<%=NkeyWord%>">
							<!-- 검색결과 유지용 매개변수 데이터끝 -->
						
						</td>
					</tr>  <!-- tr#listBtnArea -->
					
					<tr id="listPagingArea">
						
					<!-- 페이징 시작 -->
						<td colspan="5" id="pagingTd">
				<%
				int NpageStart = (NnowBlock - 1 ) * NpagePerBlock + 1;
							// 26개 자료기준
							// 현재 기준 numPerPage : 5;    // 페이지당 출력 데이터 수
							//            pagePerBlock : 5;  //  블럭당 페이지 수
							//            nowBlock : 현재블럭
							//            totalBlock : 전체블럭
							//  -------------------------------------------------
							//            totalRecord : 26    totalPage : 6
							// 적용결과  nowBlock : 1  =>   pageStart : 1   pageEnd : 5
							//            nowBlock : 2  =>   pageStart : 6   pageEnd : 6( = totalPage)
							//
				int NpageEnd = (NnowBlock < NtotalBlock) ? 	NpageStart + NpagePerBlock - 1 :  NtotalPage;
				                                        
				// 블럭당 5페이지 출력 =>        pageStart    pageEnd
				//                          1블럭        1                 5
				//                          2블럭        6                 10    		
				// 블럭마다 시작되는 첫 페이지와 마지막 페이지 관련 작업				
				if (NtotalPage != 0) {   //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
				%>
					
					<% if (NnowBlock>1) { 	   // 페이지 블럭이 2이상이면 => 2개이상의 블럭이 있어야 가능 %>
								<span class="moveBlockArea" onclick="moveBlock('<%=NnowBlock-1%>', '<%=NpagePerBlock%>')">
								&lt; 
								</span>
					<% } else { %>
					            <span class="moveBlockArea" ></span>
					<% } %>
				
					<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
					<% 
					/*
					out.print("totalRecord : " + totalRecord + "<br>");
					out.print("pagePerBlock : " + pagePerBlock + "<br>");
					out.print("numPerPage : " + numPerPage + "<br>");
					out.print("totalPage : " + totalPage + "<br>");
					out.print("pageStart : " + pageStart + "<br>");
					out.print("pageEnd : " + pageEnd + "<br>");
					out.print("nowPage : " + nowPage + "<br>");
					out.print("nowBlock : " + nowBlock + "<br>");
					out.print("totalBlock : " + totalBlock + "<br>");
					*/
					
					             // 2        <     6                     
						for (   ; NpageStart<=NpageEnd; NpageStart++) { %>
							<% if (NpageStart == NnowPage) {   // 현재 사용자가 보고 있는 페이지 %>
								<span class="nowPageNum"><%=NpageStart %></span>
							<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
							 	<span class="pageNum" onclick="movePage('<%=NpageStart %>')">
									<%=NpageStart %> 
							 	</span>					
							<% } // End If%>		 	
					<% }  // End For%>
					<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
					
				
				<% if (NtotalBlock>NnowBlock) { // 다음 블럭이 남아 있다면  %>
							<span  class="moveBlockArea" onclick="moveBlock('<%=NnowBlock+1%>', '<%=NpagePerBlock%>')">
							&gt;
							</span>
			
				<% } else { %>
				            <span class="moveBlockArea"></span>
				<% } %>
				
					
					
				<%
				} else {
					out.print("<b>[ Paging Area ]</b>"); // End if
				}
				%>						
						
						</td>
					</tr>
					
				</tbody>
			</table>
		
		
    		</div>
    		<!-- 실제 작업 영역 끝 -->
    		    	
    	</main>
    	<!--  main#main  -->
      
        
    </div>
    <!-- div#wrap -->

</body>

<script>
 	
function movePage(p1) {
	  let param = "/admin/admin.jsp?nowPage="+p1;
	  location.href = param;
	}

</script>

</html>