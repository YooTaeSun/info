package ch13_ChainOfResposibility_Advanced;

public class Armor implements Defense {

	private Defense nextDefense;
	private int def;
	
	public Armor() {
	}
	
	public Armor(int def) {
		this.def = def;
	}

	@Override
	public void depense(Attack attack) {
		//point
		proccess(attack);
		
		if(nextDefense!=null) {
			nextDefense.depense(attack);
		}
	}

	private void proccess(Attack attack) {
		int amount = attack.getAmount();
		amount -= def;
		attack.setAmount(amount);
	}
	
	public void setNextArmor(Defense nextDefense) {
		this.nextDefense = nextDefense;
	}

}
