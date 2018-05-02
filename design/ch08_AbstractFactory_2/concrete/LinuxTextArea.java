package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.TextArea;

public class LinuxTextArea implements TextArea{

	@Override
	public String getText() {
		return "리눅스 텍스트에어리어";
	}

}
