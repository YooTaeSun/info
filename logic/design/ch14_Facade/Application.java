package ch14_Facade;

import ch14_Facade.system.Facade;

public class Application {

	public static void main(String[] args) {
		Facade facade = new Facade();
		facade.process();
	}
}
