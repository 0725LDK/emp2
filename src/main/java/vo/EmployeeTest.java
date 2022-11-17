package vo;

public class EmployeeTest {

	public static void main(String[] args) {
		Employee e1 = new Employee();
		//e1.birthDate = "2000-01-01";
		e1.setBirthDate("2000-01-01"); //this는 e1이 들어감
		System.out.println(e1.getBirthDate());//this = e1가 들어감
		Employee e2 = new Employee();
		//e2.birthDate = "2000-01-01";
		e2.setBirthDate("2000-01-01"); //this는 e2이 들어감
		System.out.println(e2.getBirthDate());//this = e2가 들어감
		
	}

}
