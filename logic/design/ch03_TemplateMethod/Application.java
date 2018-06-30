package ch03_TemplateMethod;

import ch03_TemplateMethod.dp.AbstConnectHelper;
import ch03_TemplateMethod.dp.ConcreteConnectHelper;

/*
 * TemplateMethod Pattern
 * 	공통적인 프로세스를 묶어 주기
 * 
 * 	알고리즘의 구조를 메소드에 정의 하고
 *  하위 클래스에서 알고리즘 구조의 변경없이 알고리즘을 재정의 하는 패턴
 *  
 *  구현하려는 알고리즘의 일정한 프로세스가 있다.
 *  구현하려는 알고리즘의 변경가능성이 있다.
 *  
 *  알고리즘으 여러단계로 나눈다.
 *  나뉘진 알고리즘의 단계를 메소드로 선언한다.
 *  알고리즘을 수행할 템플릿 메소드를 만든다.
 *  하위 클래스에서 나눤진 메소드들을 구현한다.
 *  
 * 
 * */
public class Application {

	public static void main(String[] args) {
		AbstConnectHelper abstConnectHelper = new ConcreteConnectHelper();
		abstConnectHelper.requestConnection("info");
	}

}
