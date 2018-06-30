package ch17_Memento;

import java.util.Stack;

import ch17_Memento.abc.Memento;
import ch17_Memento.abc.Originator;

public class Application {
	public static void main(String[] args) {
		
		Stack<Memento> mementos = new Stack<>();
		Originator originator = new Originator();

		originator.setState("state 1");
		mementos.push(originator.createMemento());
		originator.setState("state 2");
		mementos.push(originator.createMemento());
		originator.setState("state 3");
		mementos.push(originator.createMemento());
		originator.setState("state Final");
		mementos.push(originator.createMemento());

		originator.restoreMement(mementos.pop());
		System.out.println(originator.getState());//state Final
		
		originator.restoreMement(mementos.pop());
		System.out.println(originator.getState());//state 3
		
		originator.restoreMement(mementos.pop());
		System.out.println(originator.getState());//state 2
		
		originator.restoreMement(mementos.pop());
		System.out.println(originator.getState());//state 1
	}
}
