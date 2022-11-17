package vo;


	//정보은닉 (숨기는 단계)
	//1. public - 100% 오픈
	//2. protected - 같은 패키지와 상속관계 오픈 ...거의안씀 입문자에게 의미가 없음
	//3. default - 같은 패키지 오픈	...거의안씀 입문자에게 의미가 없음
	//4. private - this 오픈 (나에게만 오픈) 정보 은닉

public class Employee {
	//정보 은닉
	private int empNo;
	private String birthDate;
	private String firstName;
	private String lastName;
	private String gender;
	private String hireDate;
	
	//캡슐화 자동으로 만들수 있음
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	
	
	
	
	/*
	 * //캡슣화(읽기) 겟메소드 public String getBirthDate()//문자 리턴 { return this.birthDate;
	 * //this를 뺴면 컴파일러가 알아서 붙힌다 그래도 꼭 붙혀야한다 } //캡슐화(쓰기) 셋메소드 public void
	 * setBirthdDate(String birthDate) { this.birthDate = birthDate; }
	 * 
	 * //자바는 모든필드를 정보은닉 시키고 캡슐화(읽기,쓰기)한다. 규칙 안지키면 나중에 문제
	 */}
