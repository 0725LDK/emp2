<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.sql.*" %>
<%
	//session 유효성 검증코드.. 로그인되어있으면 이 페이지에 오면 안됨 필요하면 redirect
	
	//1. controller
	//형변환
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
	
	int currentPage =1;
	if(request.getParameter("currentPage") != null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort = "ASC";
	if(request.getParameter("sort") != null && request.getParameter("sort").equals("DESC"))
	{
		sort = "DESC";
	}
	//2. model
	
	//연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/employees";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); 
	
	//페이징 위한 변수 설정
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	int lastPage = 0;
	int cnt = 0;
	
	//검색쿼리 변수 초기화
	String word = request.getParameter("word");
	ResultSet rs = null;
	String cntSql = null;
	PreparedStatement cntStmt = null;
	String sql = null;
	PreparedStatement stmt = null;
	
	if(word == null || word.equals(""))
	{
		//lastPage 구하는 알고리즘
		
		cntSql = "SELECT COUNT(*) FROM employees";
		cntStmt = conn.prepareStatement(cntSql);
		ResultSet cntRs = cntStmt.executeQuery();
		while(cntRs.next())
		{
			cnt = cntRs.getInt("COUNT(*)");
		}
		lastPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0)
		{
			lastPage = lastPage+1;
		}
		
		//페이지 출력
		sql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name ASC LIMIT ?,?";
		if(sort.equals("DESC"))
		{
			sql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name DESC LIMIT ?,?";
		}
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
	}
	else if(word != null)
	{
		cntSql = "SELECT COUNT(*) FROM employees WHERE first_name LIKE ?";
		cntStmt = conn.prepareStatement(cntSql);
		cntStmt.setString(1, "%"+word+"%");
		ResultSet cntRs = cntStmt.executeQuery();
		while(cntRs.next())
		{
			cnt = cntRs.getInt("COUNT(*)");
		}
		lastPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0)
		{
			lastPage = lastPage+1;
		}
		
		//페이지 출력
		sql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees WHERE first_name LIKE ? ORDER BY first_name ASC LIMIT ?,?";
		if(sort.equals("DESC"))
		{
			sql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees WHERE first_name LIKE ? ORDER BY first_name DESC LIMIT ?,?";
		}
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+word+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
	}
	
	
	rs = stmt.executeQuery();
	ArrayList<Employee> list = new ArrayList<Employee>();
	while(rs.next())
	{
		Employee e = new Employee();
		e.setEmpNo(rs.getInt("empNo"));
		e.setFirstName(rs.getString("firstName"));
		e.setLastName(rs.getString("lastName"));
		list.add(e);
	}
	//3. view
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
		.child 
			{
				
				vertical-align: middle;
			}
	</style>
</head>
<body>
	<div class="container">
		<h1>
			<div>
				<%=loginEmp.getLastName()%>(<%=loginEmp.getEmpNo()%>)님 반갑습니다.
			</div>
		</h1>
		
		<span style="float:right;">
			<a href="<%=request.getContextPath()%>/LogOut.jsp">로그아웃!</a>
		</span>
	
		<br><br><br>
		<h3>사원목록</h3>
					
		<table class="table table-hover">
			<tr class="table-warning">
				<th>사원번호</th>
				<th>
					이름(firstName)
					<%
						if(sort.equals("ASC"))
						{
					%>		
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=DESC">[내림차순]</a>
					<%	
						}
					else
						{
					%>	
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=ASC">[오름차순]</a>
					<%		
						}
					%>
				</th>
				<th>성(lastName)</th>
			</tr>
			<%
				for(Employee e : list)
				{
			%>
					<tr>
						<td><%=e.getEmpNo()%></td>
						<td><%=e.getFirstName()%></td>
						<td><%=e.getLastName()%></td>
						<td></td>
					</tr>	
			<%		
				}
			%>
		</table>
		
			<span style="float:left;">
				<form action="<%=request.getContextPath()%>/empList.jsp" method="post">
					<label for="word"> 검색 </label>
					<%
						if(word==null)
						{
					%>		
							<input type="text" name="word" id="word" placeholder="검색어를 입력하세요." onfocus="this.placeholder=''" onblur="this.placeholder='검색어를 입력하세요.'">		
					<%	
						}
						else
						{
					%>
							<input type="text" name="word" id="word" value="<%=word%>">
					<%		
						}
					%>
					
					<button type="submit"> 검색 </button>
				</form>
			</span>
			
			<div class="inner-div">

				<%
					if(currentPage > 1 && word==null)
					{
				%>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=<%=sort %>">처음으로</a>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort %>">이전</a>
				<%
					}
					else if(currentPage > 1 && word!=null)
					{
				%>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=<%=sort %>&word=<%=word%>">처음으로</a>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort %>&word=<%=word%>">이전</a>
				<%		
					}
				
					else if(currentPage ==1 && word==null || currentPage ==1 && word!=null )
					{
				%>
						<span>처음으로</span>
						<span>이전</span>
				<%		
					}
				%>
					
					<span>[ <%=currentPage%> ]</span>
				<%
					if(currentPage < lastPage && word==null)
					{
				%>		
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort %>">다음</a>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=<%=sort %>">마지막으로</a>
				<%		
					}
					else if(currentPage < lastPage && word!=null)
					{
				%>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort %>&word=<%=word%>">다음</a>
						<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=<%=sort %>&word=<%=word%>">마지막으로</a>
				<%		
					}
					else if(currentPage == lastPage && word==null || currentPage == lastPage && word!=null)
					{
				%>
						<span>다음</span>
						<span>마지막으로</span>		
				<%		
					}
				%>
			</div>
		</div>
	<
</body>
</html>