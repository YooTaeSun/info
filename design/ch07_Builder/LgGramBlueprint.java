package ch07_Builder;

public class LgGramBlueprint extends BluePrint {

//	private Computer computer;
	private String cpu;
	private String ram;
	private String storage;
	
	public LgGramBlueprint() {
//		computer = new Computer("default", "default", "default");
	}

	@Override
	public void setCpu() {
//		computer.setCpu("i7");
		cpu = "i7";
	}

	@Override
	public void setRam() {
//		computer.setRam("8g");
		ram = "8g";
	}

	@Override
	public void setStorage() {
//		computer.setStorage("256g ssd");
		storage = "256g ssd";
	}

	@Override
	public Computer getComputer() {
		return new Computer(cpu, ram, storage);
	}

}
