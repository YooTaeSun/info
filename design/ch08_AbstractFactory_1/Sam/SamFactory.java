package ch08_AbstractFactory_1.Sam;

import ch08_AbstractFactory_1.abst.BikeFactory;
import ch08_AbstractFactory_1.abst.Body;
import ch08_AbstractFactory_1.abst.Wheel;

public class SamFactory implements BikeFactory {

	@Override
	public Body createBody() {
		return new SamBody();
	}

	@Override
	public Wheel creatWheel() {
		return new SamWheel();
	}

}
