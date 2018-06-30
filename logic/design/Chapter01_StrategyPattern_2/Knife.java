package design.Chapter01_StrategyPattern_2;

public class Knife implements Weapon {

	/**
	 * 내구성, 공격력, 특수 능력 등
	 */

	public int doAttact() {
		System.out.println("칼 공격");
		return 0;
	}

}
