package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;;

public class MacButton implements Button{

	@Override
	public void click() {
		System.out.println("맥 버튼");
	}

}
