<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uidSession = (String)session.getAttribute("uidSession"); 
%>    
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />

<jsp:useBean id="mBean" class="pack.member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
    
 
<%
if (uidSession != null) { // 로그인한 경우
    String upw = request.getParameter("upw"); // 2. 사용자가 입력한 비밀번호를 가져옵니다.
    
 // 3. DAO를 통해 DB에서 해당 아이디의 정보를 가져옵니다.
    String dbPw = mMgr.getPasswordById(uidSession); // DB에서 비밀번호를 가져옵니다.

    if (dbPw != null && dbPw.equals(upw)) { // 4. DB에서 가져온 정보의 비밀번호와 사용자가 입력한 비밀번호를 비교합니다.
        // 로그인 성공 처리
        response.sendRedirect("passmod.jsp"); // 비밀번호 변경 페이지로 이동
    } else {
        // 로그인 실패 처리
     
    }
} else { // 로그인하지 않은 경우
    response.sendRedirect("index.jsp"); // 로그인 페이지로 이동
}
%>