package ch08_AbstractFactory_1;

import ch08_AbstractFactory_1.Sam.SamFactory;
import ch08_AbstractFactory_1.abst.BikeFactory;
import ch08_AbstractFactory_1.abst.Body;
import ch08_AbstractFactory_1.abst.Wheel;

public class Main {

	public static void main(String[] args) {
		
		BikeFactory factory = new SamFactory();
		
		Body body = factory.createBody();
		Wheel wheel = factory.creatWheel();
		
		System.out.println(body.getClass());
		System.out.println(wheel.getClass());
	}
}
