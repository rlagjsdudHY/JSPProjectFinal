<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pack.member.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<jsp:useBean id="aMgr" class="pack.member.MemberMgr" scope="page" />
<jsp:useBean id="member" class="pack.member.MemberBean" scope="page" />

<%
String uid = request.getParameter("uid");
if (uid == null || uid.equals("")) {
    response.sendRedirect("/admin/admemberList.jsp");
} else {
    member = aMgr.getMemberByUid(uid);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
</head>
<body>
    <h1>회원정보수정</h1>
    <form action="/admin/amemberModProc.jsp" method="post">
        <input type="hidden" name="uid" value="<%=member.getUid()%>">
        <table>
            <tr>
                <td>ID</td>
                <td><input type="text" name="uid" value="<%=member.getUid()%>"></td>
            </tr>
           <tr>
 			 <td>PASSWORD</td>
  			<td>
    <%
      String password = member.getUpw();
      String maskedPassword = password.replaceAll(".", "*");
      out.print(maskedPassword);
    %>
  </td>
</tr>
            <tr>
                <td>NAME</td>
                <td><input type="text" name="uname" value="<%=member.getUname()%>"></td>
            </tr>
            <tr>
                <td>EMAIL</td>
                <td><input type="text" name="uemail" value="<%=member.getUemail()%>"></td>
            </tr>
            <tr>
                <td>Gender</td>
                <td><input type="text" name="gender" value="<%=member.getGender()%>"></td>
            </tr>
            <tr>
                <td>birthday</td>
                <td><input type="text" name="ubirthday" value="<%=member.getUbirthday()%>"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="수정완료">
                    <input type="button" value="취소" onclick="history.back()">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

