package ch15_Observer_2_advanced.observer;

import java.util.Observable;

public class Button extends Observable{
	
	public void onClick(){
		setChanged();
		notifyObservers();
	}

}
