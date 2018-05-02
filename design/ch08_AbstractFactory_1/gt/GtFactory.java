package ch08_AbstractFactory_1.gt;

import ch08_AbstractFactory_1.abst.BikeFactory;
import ch08_AbstractFactory_1.abst.Body;
import ch08_AbstractFactory_1.abst.Wheel;

public class GtFactory implements BikeFactory{

	@Override
	public Body createBody() {
		return new GtBody();
	}

	@Override
	public Wheel creatWheel() {
		return new GtWheel();
	}

}
