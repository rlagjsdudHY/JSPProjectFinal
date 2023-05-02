<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />

<jsp:useBean id="mBean" class="pack.member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />

<%
boolean admodRes =mMgr.admodifyMemberProc(mBean); 
// 전달받은 자료를 수정할 수 있는 메서드 호출
%>

<script>
<% if (admodRes) { %>
	alert("정보를 수정하셨습니다.");
	location.href="/admin/admin.jsp";
<% } else { %>
	alert("회원정보 수정 중 문제가 발생했습니다. 다시 시도해주세요.");
	history.back();
<% } %>
</script>