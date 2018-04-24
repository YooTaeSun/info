package design.Chapter04_TemplateFactory.concrete;

import java.util.Date;

import design.Chapter04_TemplateFactory.framework.Item;
import design.Chapter04_TemplateFactory.framework.ItemCreator;

public class MpCreator extends ItemCreator {

	@Override
	protected void requestItemsInfo() {
		System.out.println("데이터베이스에서 마력 회복 물약의 정보를 가져옴");
	}

	@Override
	protected void createItemLog() {
		System.out.println("마력 회복 물약을 새로 생성 했습니다." + new Date());
	}

	@Override
	protected Item createItem() {
		return new MpPotion();
	}

}
