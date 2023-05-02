<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
  function updateTime() {
    let date = new Date();
    let options = {
      timeZone: 'Asia/Seoul',
      month: '2-digit',
      day: '2-digit',
      weekday: 'short',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    };
    let formattedDate = date.toLocaleString('ko-KR', options);
    document.getElementById("time").innerHTML = formattedDate;
  }

  setInterval(updateTime, 1000); // 1초마다 호출
</script>

<div id="userInfo">
  <% 
    String uidSession_HTmp = (String) session.getAttribute("uidSession");
    String ipAddress = request.getHeader("X-FORWARDED-FOR");
    if (ipAddress == null) {
      ipAddress = request.getRemoteAddr();
    }
  %>
  <p><%=uidSession_HTmp%>님이 로그인 중 (<span id="time"></span>/ 접속IP : <%=ipAddress%>)</p>
</div>


<header id="header" class="dFlex">
	<!-- 로고, GNB -->
	<div id="headerLogo">
		<a href="/index.jsp"> <img src="/images/headerLogo.png"
			alt="헤더로고이미지">
		</a>
	</div>
	<nav id="gnb">

		<ul id="mainMenu" class="dFlex">

			<%
			if (uidSession_HTmp == null) {
			%>

			<li class="mainLi"><a href="/index.jsp">HOME</a></li>
			<li>|</li>
			<li class="mainLi"><a href="/member/login.jsp">로그인</a></li>
			<li>|</li>
			<li class="mainLi"><a href="/member/joinAgreement.jsp">회원가입</a></li>
			<li>|</li>
			<li id="boardLi" class="mainLi"><a href="/bbs/list.jsp?gnbParam=list">게시판</a>
			<ul class="subMenu">
			<li class="subLi"><a href="/bbs/list.jsp">자유게시판</a></li>
			<li class="subLi"><a href="/gallerybbs/glist.jsp">갤러리게시판</a></li>
			<li class="subLi"><a href="/notice/nList.jsp">공지사항</a></li>
			</ul>

			<%
			} else { //비회원도 갤러리 게시판은 볼 수 있게 수정
			%>

			<li class="mainLi"><a href="/index.jsp">HOME</a></li>
			<li>|</li>
			<li class="mainLi"><a href="/member/logout.jsp">로그아웃</a></li>
			<li>|</li>
			<li class="mainLi"><a href="/member/myPage.jsp?gnbParam=myPage">마이페이지</a></li>
			<li>|</li>
			<li id="boardLi" class="mainLi"><a href="/bbs/list.jsp?gnbParam=list">게시판</a>
			<ul class="subMenu">
			<li class="subLi"><a href="/bbs/list.jsp">자유게시판</a></li>
			<li class="subLi"><a href="/gallerybbs/glist.jsp">갤러리게시판</a></li>
			<li class="subLi"><a href="/notice/nList.jsp">공지사항</a></li>
			</ul>
			</li>

			<%
			}
			%>

		</ul>

	</nav>
</header>
<!--  header#header  -->
<hr class="sepLine">

<script>
/*
* GNB 메뉴 구현
*/


$(function(){
	 
	 $("ul#mainMenu>li.mainLi").mouseover(function(){
	 
		$(this).children("ul.subMenu").stop().slideDown(400);
	});
	 $("ul#mainMenu>li.mainLi").mouseout(function(){
		 
		$(this).children("ul.subMenu").stop().slideUp(100);
	});
});
</script>
<style>
ul.subMenu {
	display: none;
	position: absolute;
}
/* 메인메뉴 시작 ul#mainMenu */
ul#mainMenu {
	justify-content: space-around;
}
#mainMenu>li.mainLi>a {
	display: inline-block;
}
.subLi {
	font-size: 20px;
	 border: 1px solid #000;
	}
 
 #mainMenu>li.mainLi {
  padding: 10px;
}
</style>
