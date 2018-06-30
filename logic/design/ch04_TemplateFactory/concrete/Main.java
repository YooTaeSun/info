package ch04_TemplateFactory.concrete;

import ch04_TemplateFactory.framework.Item;
import ch04_TemplateFactory.framework.ItemCreator;

public class Main {

	public static void main(String[] args) {
		
		ItemCreator creator = new HpCreator();
		
		Item item = creator.create();
		item.use();
		
		creator = new MpCreator();
		creator.create();
		item.use();
	}
}
