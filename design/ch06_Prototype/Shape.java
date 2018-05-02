package ch06_Prototype;

public abstract class Shape implements Cloneable {

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
