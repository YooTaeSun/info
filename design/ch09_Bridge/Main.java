package ch09_Bridge;

public class Main {
	public static void main(String[] args) {
//		PrintMorseCode code = new PrintMorseCode(new DefaultMCF());
//		PrintMorseCode code = new PrintMorseCode(new SoundMCF());
		PrintMorseCode code = new PrintMorseCode(new FlashMCF());
		code.g().a().r().a();
	}
}
