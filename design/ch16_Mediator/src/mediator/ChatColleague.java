package ch16_Mediator.src.mediator;

import ch16_Mediator.src.mediator.contract.Colleague;

public class ChatColleague extends Colleague {

	private String Name;
	
	public ChatColleague(String name) {
		super();
		this.Name = name;
	}
	
	@Override
	public void handle(String data) {
		System.out.println(this.Name +"-"+data);
	}

}
