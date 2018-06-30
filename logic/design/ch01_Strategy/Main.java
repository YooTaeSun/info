package ch01_Strategy;

public class Main {

	public static void main(String[] args) {
		
		GameCharacter character = new GameCharacter();
		character.attact();
		
		character.setWeapon(new Knife());
		character.attact();
		
		character.setWeapon(new Sword());
		character.attact();
		
		character.setWeapon(new Ax());
		character.attact();
		
	}
	
}
