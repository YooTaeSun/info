package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;;

public class WindowButton implements Button{

	@Override
	public void click() {
		System.out.println("원도우 버튼");
	}

}
