<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// session 유효성 검증코드.. 로그인되어있으면 이 페이지에 오면 안됨 필요하면 redirect

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

	<style>

		a 
			{
		  		text-decoration: none;
			}
		tr,td
			{
				text-align: center;
			}
		.inner-div 
			{
			 	width : 300px;
			 	height : 30px;
			 	margin: auto;
			}
		.center
			{
				text-align : center;
			}
	</style>
</head>
<body>
	<br>
	<div class="container">
		<h1>로그인</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp">
			<table class="table">
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
				
			</table>
			<div style="float:left;">
				<%
					if(request.getParameter("msg") != null)
					{
				%>		
						<span style="float:left; color:red">경고!</span><span>&nbsp;<%=request.getParameter("msg") %></span>
				<%
					}
				%>
			</div>
			<div style="float:right;">
				<button type="submit">로그인</button>
			</div>
		</form>
	</div>
</body>
</html>