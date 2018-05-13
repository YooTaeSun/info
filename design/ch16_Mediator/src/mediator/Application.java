package ch16_Mediator.src.mediator;

import ch16_Mediator.src.mediator.contract.Colleague;
import ch16_Mediator.src.mediator.contract.Mediator;

public class Application {

	public static void main(String[] args) {
		Mediator mediator = new ChatMediator();
		
		Colleague colleague1 = new ChatColleague("ANDY");
		Colleague colleague2= new ChatColleague("JOHN");
		Colleague colleague3= new ChatColleague("ANNA");
		
		colleague1.join(mediator);
		colleague1.sendData("AAA");
		
		System.out.println("");
		
		colleague2.join(mediator);
		colleague1.sendData("BBB");
		
		System.out.println("");
		
		colleague3.join(mediator);
		
//		colleague3.sendData("CCC");
		
	}
}
