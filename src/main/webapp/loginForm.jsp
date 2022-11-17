<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// session 유효성 검증코드.. 로그인되어있으면 이 페이지에 오면 안됨 필요하면 redirect

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<table>
			<tr>
				<td>empNo</td>
				<td><input type="text" name="empNo"></td>
			</tr>
			<tr>
				<td>firstName</td>
				<td><input type="text" name="firstName"></td>
			</tr>
			<tr>
				<td>lastName</td>
				<td><input type="text" name="lastName"></td>
			</tr>
			
			<%
				if(request.getParameter("msg") != null)
				{
			%>		
					<span style="float:left;" style="color:red"> 경고! </span><span><%=request.getParameter("msg") %></span>
			<%
				}
			%>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>