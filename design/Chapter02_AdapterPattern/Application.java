package design.Chapter02_AdapterPattern;

public class Application {

/*
 * Adapter Pattern
 * 연관성 없는 두 객체 묶어 사용하기  
 * 
 */
	public static void main(String[] args) {

		//요구사항을 수행하는 인스턴스
		Adapter target = new AdapterImpl();
		
		System.out.println(target.twiceOf(100.0f));
		System.out.println(target.halfOf(100.3f));
		System.out.println(target.twiceOf(50f));
		System.out.println(target.twiceOf(300f));
	}
}
