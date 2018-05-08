package ch13_ChainOfResposibility;

public class Application {

	public static void main(String[] args) {
		
		Calculator plus = new PlusCalculator();
		Calculator sub = new SubCalculator();
		Calculator sub2 = new SubCalculator();
		
		plus.setNextCalculator(sub);
		sub.setNextCalculator(sub2);
		
		Request request1 = new Request(1,2,"+"); //3
		Request request2 = new Request(3,4,"-");//8
		Request request3 = new Request(5,6,"-");//8
		
		plus.process(request1);
		plus.process(request2);
		plus.process(request3);
		
	}
}
