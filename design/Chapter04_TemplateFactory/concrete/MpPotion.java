package design.Chapter04_TemplateFactory.concrete;

import design.Chapter04_TemplateFactory.framework.Item;

public class MpPotion extends Item{

	@Override
	public void use() {
		System.out.println("마력 회복!");
	}

}
