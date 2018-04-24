package design.Chapter04_TemplateFactory.concrete;

import design.Chapter04_TemplateFactory.framework.Item;

public class HpPotion extends Item{

	@Override
	public void use() {
		System.out.println("체력 회복!");
	}

}
