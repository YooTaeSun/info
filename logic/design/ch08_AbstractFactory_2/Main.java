package ch08_AbstractFactory_2;

import ch08_AbstractFactory_2.abst.Button;
import ch08_AbstractFactory_2.abst.GuiFac;
import ch08_AbstractFactory_2.abst.TextArea;
import ch08_AbstractFactory_2.concrete.FactoryInstance;

public class Main {

	public static void main(String[] args) {
		
		GuiFac fac = FactoryInstance.getGuiFac();
//		GuiFac fac = new LinuxGuiFac();
//		GuiFac fac = new MacGuiFac();
//		GuiFac fac = new WindowGuiFac();
		Button button = fac.createButton();
		TextArea area = fac.createTextArea();
		
		button.click();
		System.out.println(area.getText());
		
	}
}
