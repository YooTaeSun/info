package design.Chapter04_TemplateFactory.concrete;

import java.util.Date;

import design.Chapter04_TemplateFactory.framework.Item;
import design.Chapter04_TemplateFactory.framework.ItemCreator;

public class HpCreator extends ItemCreator {

	@Override
	protected void requestItemsInfo() {
		System.out.println("데이터베이스에서 회복 물략의 정보를 가져옴");
	}

	@Override
	protected void createItemLog() {
		System.out.println("회복 물약을 새로 생성 했습니다." + new Date());
	}

	@Override
	protected Item createItem() {
		return new HpPotion();
	}

}
