<%@page import="java.util.Arrays" %>
<%@page import="pack.member.MemberBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uidSession = (String)session.getAttribute("uidSession");
if (uidSession == null) response.sendRedirect("/index.jsp");
%>
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />
<%
MemberBean mBean = mMgr.modifyMember(uidSession);
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>회원정보수정</title>
		<link rel="stylesheet" href="/style/style_MemMod.css">
		<link rel="stylesheet" href="/style/style_Template.css">
		<script src="/resource/jquery-3.6.0.min.js"></script>
		<script src="/script/script_MemMod.js"></script>
	</head>
	<body>
		<div id="wrap">
			<%@ include file="/ind/headerTmp.jsp" %>
			<!-- 헤더템플릿 -->
			
			<main id="main" class="dFlex">
				
				<!-- 실제 작업 영역 시작 -->
				<div id="contents" class="memUpdate">
					<form name="modFrm" id="modFrm">
						<table id="modFrmTbl">
							<caption>회원 정보 수정</caption>
							<tbody>
								<tr>
									<td class="req">아이디</td>
									<td>
										<%=mBean.getUid() %>
										<input type="hidden" name="uid" value="<%=mBean.getUid() %>">
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="req">패스워드</td>
									<td>
										<input type="password" name="upw" id="upw"
										maxlength="20">
										<input type="checkbox" id="pwView"> 비밀번호 보기
									</td>
									<td>
										<span>영어소문자/숫자, _, @, $, 5~20 </span>
									</td>
								</tr>
								<tr>
									<td class="req">패스워드 확인</td>
									<td>
										<input type="password" id="upw_Re"
										maxlength="20">
										<span id="pwChk"></span>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="req">이름</td>
									<td>
										<input type="text" name="uname" id="uname"
										maxlength="20" value="<%=mBean.getUname() %>">
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="req">Email</td>
									<td>
										<%
										String uemail = mBean.getUemail();
										if (uemail == null) {
										    uemail = ""; // or 다른 기본값으로 설정
										}
										int idxAt = uemail.indexOf("@");
										//out.print("idxAt : " + idxAt);
										String uemail1 = uemail.substring(0, idxAt);
										//out.print("uemail1 : " + uemail1);
										String uemail2 = uemail.substring(idxAt+1);
										//out.print("uemail2 : " + uemail2);
										%>
										<input type="text" id="uemail_01"
											maxlength="20" size="7" value="<%=uemail1%>">
										<span>@</span>
										<input type="text" id="uemail_02"
											maxlength="40" size="10" value="<%=uemail2%>">
										
										<select id="emailDomain" class="frmDropMenu">
											<option value="">직접입력</option>
											<option>naver.com</option>
											<option>daum.net</option>
										</select>
										<button type="button" id="emailAuthBtn" class="frmBtn">인증코드받기</button>
										
										<!-- 이메일 인증 영역 시작 : Authentication code 인증코드 -->
										<div id="emailAuthArea">
											<span>인증코드 입력</span>
											<input type="text" id="emailAuth" size="25">
											<button type="button" class="frmBtn">인증하기</button>
										</div>
										<!-- div#emailAuthArea -->
										<input type="hidden" name="uemail" id="uemail">
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>성별</td>
									<td>
									<%
									String gender = mBean.getGender();
									
									if (gender == null) gender = "";
									
									String chkMale = "";
									String chkFemale = "";
									if (gender.equals("1")) {
										chkMale = "checked";
									} else if (gender.equals("2")) {
										chkFemale = "checked";
									}
									%>
										<label>
											남 <input type="radio" name="gender" value="1"
											<%=chkMale %>>
										</label>
										<label>
											여 <input type="radio" name="gender" value="2"
											<%=chkFemale %>>
										</label>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>생년월일</td>
									<td>
										<input type="text" name="ubirthday" id="ubirthday"
										maxlength="6" size="8" value="<%=(mBean.getUbirthday() == null) ? "" : mBean.getUbirthday()%>">&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>우편번호</td>
									<td>
										<input type="text" name="uzipcode" id="uzipcode"
										maxlength="7" size="7" value="<%=(mBean.getUzipcode() == null) ? "" : mBean.getUzipcode() %>" readonly>
										<button type="button" id="findZipBtn" class="frmBtn">우편번호찾기</button>
									</td>
									<td>
										<span>우편번호 찾기 버튼을 클릭하세요.</span>
									</td>
								</tr>
								<tr>
									<td>주소</td>
									<td>
										<input type="text" name="uaddr" id="uaddr"
										maxlength="100" size="50" value="<%=(mBean.getUaddr() == null) ? "" : mBean.getUaddr() %>">
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>취미</td>
									<%
									String[] uhobby = mBean.getUhobby();
									%>
									<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
									<script>
										$(function() {
											let chkBoxAry = <%=Arrays.toString(uhobby) %>;
											//console.log("chkBoxAry : " + chkBoxAry);
											let len = chkBoxAry.length;
											//console.log("len : " + len);
											let chkToF;
											for (let i=0; i<len; i++) {
												if (chkBoxAry[i] == 1) chkToF = true;
												$("input[name=uhobby]").eq(i).prop("checked", chkToF);
												chkToF = false;
											}
										});
									</script>
									<td>
										<label> 인터넷
											<input type="checkbox" name="uhobby" value="인터넷">
										</label>
										<label> 여행
											<input type="checkbox" name="uhobby" value="여행">
										</label>
										<label> 게임
											<input type="checkbox" name="uhobby" value="게임">
										</label>
										<label> 영화
											<input type="checkbox" name="uhobby" value="영화">
										</label>
										<label> 운동
											<input type="checkbox" name="uhobby" value="운동">
										</label>
									</td>
									<td></td>
								</tr>
								<tr>
									<td>직업</td>
									<%
									String ujob = mBean.getUjob();
									%>
									<td>
										<select name="ujob" id="ujob" class="frmDropMenu">
											<option<% if (ujob == null || ujob.equals("")) out.print("selected");  %>> - 선택 - </option>
											<option<% if (ujob != null && ujob.equals("교수")) out.print("selected");  %>>교수</option>
											<option<% if (ujob != null && ujob.equals("학생")) out.print("selected");  %>>학생</option>
											<option<% if (ujob != null && ujob.equals("회사원")) out.print("selected");  %>>회사원</option>
											<option<% if (ujob != null && ujob.equals("공무원")) out.print("selected");  %>>공무원</option>
											<option<% if (ujob != null && ujob.equals("자영업")) out.print("selected");  %>>자영업</option>
											<option<% if (ujob != null && ujob.equals("전문직")) out.print("selected");  %>>전문직</option>
											<option<% if (ujob != null && ujob.equals("주부")) out.print("selected");  %>>주부</option>
											<option<% if (ujob != null && ujob.equals("무직")) out.print("selected");  %>>무직</option>	
										</select>
									</td>
									<td></td>
								</tr>
								<tr>
									<td colspan="3">
										<button type="button" id="modSbmBtn" class="frmBtn">수정하기</button>
										<button type="reset" class="frmBtn">다시쓰기</button>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<!-- 실제 작업 영역 끝 -->
				
			</main>
			<!-- main#main -->
			
			<%@ include file="/ind/footerTmp.jsp" %>
			<!-- 푸터템플릿 -->
		</div>
		<!-- div#wrap -->
	</body>
</html>