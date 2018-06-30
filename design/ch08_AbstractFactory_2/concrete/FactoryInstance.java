package ch08_AbstractFactory_2.concrete;

import ch08_AbstractFactory_2.abst.GuiFac;

public class FactoryInstance {
	public static GuiFac getGuiFac() {
		
		switch (getOsCode()) {
		case 0:
			return new MacGuiFac();
		case 1:
			return new LinuxGuiFac();
		case 2:
			return new WindowGuiFac();
		}
		return null;
	}
	
	
	private static int getOsCode() {
		String osName = System.getProperty("os.name");
		System.out.println(osName);
		if("Mac OS X".equals(osName)) {
			return 0;	
		}else if("Windows 10".equals(osName)) {
			return 2;	
		}else {
			return 1;
		}
	}
}
