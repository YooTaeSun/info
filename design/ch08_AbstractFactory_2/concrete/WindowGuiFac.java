package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.Button;
import ch08_AbstractFactory_2.abst.GuiFac;
import ch08_AbstractFactory_2.abst.TextArea;

public class WindowGuiFac implements GuiFac{

	protected WindowGuiFac() {
		super();
	}
	
	@Override
	public Button createButton() {
		return new WindowButton();
	}

	@Override
	public TextArea createTextArea() {
		return new WindowTextArea();
	}

}
