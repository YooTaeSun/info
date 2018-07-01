package www.townsi.com.vo;

public class Person {
	public String name;
	public Integer age;
	public String job;

	public Person(String name, Integer age, String job) {
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

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}



}
