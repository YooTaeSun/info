package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.TextArea;

public class MacTextArea implements TextArea{

	@Override
	public String getText() {
		return "맥 텍스트에어리어";
	}

}
