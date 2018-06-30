package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.TextArea;

public class WindowTextArea implements TextArea{

	@Override
	public String getText() {
		return "원도우 텍스트에어리어";
	}

}
