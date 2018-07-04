package www.townsi.com.vo;


public class Person extends Living implements Earch{
	public String name;
	public int age;
	public String job;
	public String addr;

	public Person(String name, int age, String job) {
		this.name = name;
		this.age = age;
		this.job = job;
	}

	public Person(String space, String name, int age, String job) {
		this.space = space;
		this.name = name;
		this.age = age;
		this.job = job;
	}

	public Person(String space, String name, int age, String job,String addr) {
		this.space = space;
		this.name = name;
		this.age = age;
		this.job = job;
		this.addr = addr;
	}

//	@Override
//	public String toString() {
//		return name;
//	}


	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	@Override
	public String getSpace2() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}



	public String getName() {
		return name;
	}

}
