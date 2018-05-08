package ch13_ChainOfResposibility_Advanced;

public class Application {

	public static void main(String[] args) {
		
		Attack attack = new Attack(100);
 		
		Armor armor1 = new Armor(10);
 		Armor armor2 = new Armor(15);
		
 		armor1.setNextArmor(armor2);
 		
 		//첫번째 공격
 		armor1.depense(attack);
		System.out.println(attack.getAmount());

		/*
		 * Point2
		 * */
		Defense defense = new Defense() {
			
			@Override
			public void depense(Attack attack) {
				int amount = attack.getAmount();
				attack.setAmount(amount-=50);
			}
		};
		
		//추가 작용
		armor2.setNextArmor(defense);
		attack.setAmount(100);
		//두번째 공격 
 		armor1.depense(attack);
		System.out.println(attack.getAmount());
	}
}
