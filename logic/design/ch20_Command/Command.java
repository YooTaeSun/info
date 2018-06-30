package ch20_Command;

public interface Command extends Comparable<Command>{
//	void action();
//	void undo();
	public void execute();
}
