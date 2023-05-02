<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uidSession = (String)session.getAttribute("uidSession"); 
%>    
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />

<jsp:useBean id="mBean" class="pack.member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
    
<!--
MemberMgr에서 회원탈퇴를 처리하는 메서드를 생성하여 처리합니다.
방법1. 데이터베이스에서 회원Row 삭제
방법2. 데이터베이스의 member 테이블에서 새로운 컬럼을 추가한다.
        이 컬럼은 탈퇴여부를 결정하는 컬럼으로 값을 1 또는 0을 입력하게 하여
        1인 경우 탈퇴한 회원, 0인 경우 현재 정상 회원으로 구분한다.
방법3. 탈퇴한 회원의 Row를 삭제하고 별도의 삭제회원 테이블을 생성하여
        삭제회원 테이블에 탈퇴한 회원정보를 입력함.       
 -->    
 
<%
if (uidSession == null) { // 로그인하지 않았을 경우
    response.sendRedirect("login.jsp");
} else { // 로그인한 경우
    String uid = request.getParameter("uid"); // 탈퇴할 회원 아이디
    String upw = request.getParameter("upw");
    if (uid != null) { // 탈퇴 요청이 들어온 경우
        String deletedMember = mMgr.delMemberName(uid, upw); // 회원 탈퇴 처리

        if (deletedMember != null) { // 탈퇴 성공한 경우
            // 로그아웃 처리 및 탈퇴 완료 메시지 출력
            session.invalidate();
            out.print("<script>alert('회원 탈퇴가 완료되었습니다.'); location.href='../index.jsp';</script>");
        } else { // 탈퇴 실패한 경우
            // 오류 메시지 출력
            out.print("<script>alert('회원 탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    }
}
%>