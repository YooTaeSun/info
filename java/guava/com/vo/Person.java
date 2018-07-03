package www.townsi.com.vo;
interface Earch {
	public String getSpace2();
}

class Living {
	public String space;

	public String getSpace() {
		return space;
	}

	public void setSpace(String space) {
		this.space = space;
	}
}

public class Person extends Living implements Earch{
	public String name;
	public Integer age;
	public String job;

	public Person(String name, Integer age, String job) {
		this.name = name;
		this.age = age;
		this.job = job;
	}

	public Person(String space, String name, Integer age, String job) {
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

	@Override
	public String getSpace2() {
		// TODO Auto-generated method stub
		return null;
	}



}
