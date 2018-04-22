package design.Chapter21_CommandPattern;

public interface Command extends Comparable<Command>{
//	public <T> T[] toArray(T[] a);
	public void execute();
		
}
