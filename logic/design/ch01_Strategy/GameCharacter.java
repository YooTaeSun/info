package ch01_Strategy;

/*
StrategyPattern 패턴
- 여러 알고리즘을 하나의 추상적인 접근점을 만들어 접근 점에서 교환 가능하도록 하는 패턴
*/
public class GameCharacter {

	//접근점
	private Weapon weapon;

	//교환 가능
	public void setWeapon(Weapon weapon) {
		this.weapon = weapon;
	}
	
	public int attact() {
		if(weapon == null) {
			System.out.println("맨손 공격");
			return 1;
		}else {
			//델리게이트
			return weapon.doAttact();
		}
	}
}
