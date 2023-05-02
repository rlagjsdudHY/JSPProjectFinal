<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="pack.dbcp.DBConnectionMgr"%>

<html>
<head>
    <title>Login History</title>
    <style>
    tr#blue>th{
    background-color: #e5f3ff;
    }
        table, th, td {
        	width: 800px;
        	margin: 0 auto;
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
   <h2><%= session.getAttribute("uidSession") %> 님의 접속내역</h2>
    <table class="mytable">
        <tr id="blue">
            <th>번호</th>
            <th>일시</th>
            <th>로그인 IP</th>
            <th>접속 수단</th>
        </tr>
    <%
String uidSession = (String) session.getAttribute("uidSession");
DBConnectionMgr pool = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    pool = DBConnectionMgr.getInstance();
    conn = pool.getConnection();
    pstmt = conn.prepareStatement("SELECT * FROM logininfo WHERE uid = ? ORDER BY num desc");
    pstmt.setString(1, uidSession);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        int num = rs.getInt("num");
        String uid = rs.getString("uid");
        int logincnt = rs.getInt("logincnt");
        String loginip = rs.getString("loginip");
        Timestamp logintime = rs.getTimestamp("logintime");
        String conndev = rs.getString("conndev");
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd (E) HH:mm");
        String formattedDateLoginTime = dateFormat.format(logintime);
        %>
        <tr>
            <td><%= logincnt %></td>
            <td><%= formattedDateLoginTime %></td>
            <td><%= loginip %></td>
            <td><%= conndev %></td>
        </tr>
        <%
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) try { rs.close(); } catch(SQLException e) {}
    if (pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
    if (conn != null) pool.freeConnection(conn); 
}
%>
    </table>
</body>
</html>