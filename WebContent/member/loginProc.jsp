
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />
    
<% 
request.setCharacterEncoding("UTF-8"); 
String uid = request.getParameter("uid");
String upw = request.getParameter("upw");
String loginip =request.getRemoteAddr();
String conndev = request.getParameter("conndev");
 
boolean loginRes =mMgr.loginMember(uid, upw, loginip, conndev);
%>

<script>
<%
try {
    if (loginRes) {
        session.setAttribute("uidSession", uid);
%>      
    location.href="/index.jsp";
<%
    } else {
%>      
    alert("아이디 또는 비밀번호를 확인해주세요.");
    location.href="/member/login.jsp";
<%
    }
} catch (Exception e) {
%>
    alert("로그인 정보를 저장하는 데 문제가 발생했습니다.");
    location.href="/member/login.jsp";
<%
}
%>
</script>