package www.townsi.com.vo;

public class Human extends Living implements Earch{
	public String name;
	public int age;
	public String job;
	public Human(String name, int age, String job) {
		this.name = name;
		this.age = age;
		this.job = job;
	}

	public Human(String space, String name, int age, String job) {
		this.space = space;
		this.name = name;
		this.age = age;
		this.job = job;
	}

//	@Override
//	public String toString() {
//		return name;
//	}

	public String getName() {
		return name;
	}

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



}
