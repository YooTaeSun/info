package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;
import ch08_AbstractFactory_2.abst.GuiFac;
import ch08_AbstractFactory_2.abst.TextArea;

public class MacGuiFac implements GuiFac{

	protected MacGuiFac() {
		super();
	}
	
	@Override
	public Button createButton() {
		return new MacButton();
	}

	@Override
	public TextArea createTextArea() {
		return new MacTextArea();
	}

}
