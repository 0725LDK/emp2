<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	//session 유효성 검증코드.. 로그인되어있으면 이 페이지에 오면 안됨 필요하면 redirect
	
	//형변환
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.
	</div>
	
	<a href="<%=request.getContextPath()%>/LogOut.jsp">로그아웃</a>
</body>
</html>