package ch03_TemplateMethod.dp;

public class ConcreteConnectHelper extends AbstConnectHelper {

	@Override
	protected String doSecurity(String info) {
		System.out.println("디코드");
		return info;
	}

	@Override
	protected String authentication(String id, String password) {
		System.out.println("아이디/암호 확인 과정");
		if (id.equals("abc") | password.equals("abc"))
			return "true info";
		else
			return "false info";
	}

	@Override
	protected int authorization(String userName) {
		System.out.println("권한 확인");
		return 0;
	}

	@Override
	protected String connection(String info) {
		System.out.println("마지막 접속단계!");
		return info;
	}

}
