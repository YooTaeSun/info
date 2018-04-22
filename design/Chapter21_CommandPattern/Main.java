package design.Chapter21_CommandPattern;

import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;

import javax.annotation.Priority;

public class Main {
	public static void main(String[] args) {
		
		List<Command> list = new LinkedList<>();
		list.add(new Command() {
			@Override
			public void execute() {
				System.out.println("작업 1");
			}
			@Override
			public int compareTo(Command o) {
				// TODO Auto-generated method stub
				return 0;
			}
		});
		
		list.add(new Command() {
			@Override
			public void execute() {
				System.out.println("작업 2");
			}
			@Override
			public int compareTo(Command o) {
				// TODO Auto-generated method stub
				return 0;
			}
		});
			
		list.add(new Command() {
			@Override
			public void execute() {
				System.out.println("작업 3");
			}
			@Override
			public int compareTo(Command o) {
				// TODO Auto-generated method stub
				return 0;
			}
		});
		
		for (Command command : list) {
			command.execute();
		}
		
		PriorityQueue<Command> queue = new PriorityQueue<>();
		queue.add(new StringPrintCommand("ABCD"));
		queue.add(new StringPrintCommand("A"));
		queue.add(new StringPrintCommand("AB"));
		queue.add(new StringPrintCommand("ABC"));
		
		for (Command command : queue) {
			command.execute();
		}
		
		
		
	}
}
