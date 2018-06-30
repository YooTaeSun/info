package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;;

public class LinuxButton implements Button{

	@Override
	public void click() {
		System.out.println("리눅스 버튼");
	}

}
