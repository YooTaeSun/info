package ch04_TemplateFactory.concrete;

import ch04_TemplateFactory.framework.Item;

public class MpPotion extends Item{

	@Override
	public void use() {
		System.out.println("마력 회복!");
	}

}
