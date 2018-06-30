package design.Chapter04_TemplateFactory.concrete;

import design.Chapter04_TemplateFactory.framework.Item;
import design.Chapter04_TemplateFactory.framework.ItemCreator;

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
