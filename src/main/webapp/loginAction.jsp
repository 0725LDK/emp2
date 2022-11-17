<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.net.*"%>

<%
	//1)controller
	//session 유효성 검증코드.. 로그인되어있으면 이 페이지에 오면 안됨 필요하면 redirect
	//request 유효성 검증코드
	request.setCharacterEncoding("utf-8");
	String msg = null;
	if(request.getParameter("empNo")==null || request.getParameter("empNo").equals("") 
		|| request.getParameter("firstName")==null || request.getParameter("fitstName").equals("")
		|| request.getParameter("lastName")==null || request.getParameter("lastName").equals("") )
	{
		msg =URLEncoder.encode("항목들을 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
		
	
	
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	Employee employee = new Employee();
	employee.setEmpNo(empNo);
	employee.setFirstName(firstName);
	employee.setLastName(lastName);
	
	
	//2)model
	//로그인
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/employees";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		
		/*
			SELECT emp_no empNo, last_name lastName
			FROM employee
			WHERE emp_no =? AND first_name =? AND last_name =?
		*/
		String sql = "SELECT emp_no empNo, last_name lastName FROM employees WHERE emp_no =? AND first_name =? AND last_name =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		//getter사용
		stmt.setInt(1,employee.getEmpNo());
		stmt.setString(2,employee.getFirstName());
		stmt.setString(3,employee.getLastName());
		
		ResultSet rs = stmt.executeQuery();
		String targetUrl = "/loginForm.jsp";
		if(rs.next())
		{
			//로그인 성공
			Employee loginEmp = new Employee();
			loginEmp.setEmpNo(rs.getInt("empNo"));
			loginEmp.setLastName(rs.getString("lastName"));
			session.setAttribute("loginEmp", loginEmp);//키:"loginEmp" 값 : Object Object = loginEmp;
			targetUrl = "/empList.jsp";
		}
		rs.close();
		stmt.close();
		conn.close();
		response.sendRedirect(request.getContextPath()+targetUrl);
		
	//3)view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>