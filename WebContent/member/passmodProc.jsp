<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uidSession = (String)session.getAttribute("uidSession"); 
%>    
<jsp:useBean id="mMgr" class="pack.member.MemberMgr" />

<jsp:useBean id="mBean" class="pack.member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
    
    
<%
    String upw = request.getParameter("upw"); // 2. 사용자가 입력한 비밀번호를 가져옵니다.
    String newupw = request.getParameter("newupw");

    if (upw != null && newupw != null) { // 3. 사용자가 비밀번호를 입력한 경우
        try {
            boolean isSuccess = mMgr.changePassword(uidSession, upw, newupw); // 4. changePassword() 메소드를 호출합니다.
            if (isSuccess) {
            	out.print("<script>alert('비밀번호가 변경되었습니다'); location.href='../index.jsp';</script>");
            } else {
                out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); location.href='../member/passmod.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('비밀번호 변경에 실패했습니다.'); location.href='../member/passmod.jsp';</script>");
            e.printStackTrace();
        }
    }
%>