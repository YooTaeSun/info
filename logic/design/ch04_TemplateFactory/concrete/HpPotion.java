package ch04_TemplateFactory.concrete;

import ch04_TemplateFactory.framework.Item;

public class HpPotion extends Item{

	@Override
	public void use() {
		System.out.println("체력 회복!");
	}

}
