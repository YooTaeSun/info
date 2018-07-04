package www.townsi.com.vo;

public class Human extends Living implements Earch{
	public String name;
	public String age;
	public String job;

	public Human(String name, String age, String job) {
		this.name = name;
		this.age = age;
		this.job = job;
	}

	public Human(String space, String name, String age, String job) {
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



	public String getAge() {
		return age;
	}

	public void setAge(String age) {
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
