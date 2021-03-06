package design.Chapter02_AdapterPattern;



public class AdapterImpl implements Adapter {

	@Override
	public Double twiceOf(Float num) {
		return Math.doubled(num.doubleValue());
	}

	@Override
	public Double halfOf(Float num) {
		System.out.println("half 함수 호출");
		return Math.half(num);
	}

}
