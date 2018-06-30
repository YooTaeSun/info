package ch16_Mediator.src.mediator;

import ch16_Mediator.src.mediator.contract.Colleague;
import ch16_Mediator.src.mediator.contract.Mediator;

public class ChatMediator extends Mediator {

	@Override
	public void mediate(String data) {
		for (Colleague colleague : colleagues) {
			//중재가능성.
			colleague.handle(data);
		}
	}

}
