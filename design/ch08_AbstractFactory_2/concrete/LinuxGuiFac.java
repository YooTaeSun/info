package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;
import ch08_AbstractFactory_2.abst.GuiFac;
import ch08_AbstractFactory_2.abst.TextArea;

public class LinuxGuiFac implements GuiFac{

	protected LinuxGuiFac() {
		super();
	}

	@Override
	public Button createButton() {
		return new LinuxButton();
	}

	@Override
	public TextArea createTextArea() {
		return new LinuxTextArea();
	}

}
