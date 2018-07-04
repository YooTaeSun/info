package www.townsi.com.compare;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import www.townsi.com.vo.Human;
import www.townsi.com.vo.Person;

public class CompareTest2 {

	public static void main(String[] args)
			throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Person p1 = new Person("Ame", "John", 30, "Doctor", "aaaa");
		Human p2 = new Human("Korean", "John", "30", "Doctor");

		List<String> getMethodlist = new ArrayList<String>();
		getMethodlist.add("age");
		getMethodlist.add("name");
		getMethodlist.add("job");

		// compareDTOValue(p1, p2);
		compareDTOValue(p1, p2, getMethodlist);
		// main2();
	}

	/**
	 * DTO간 데이터를 전송(복사)한다.
	 *
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */
	public static void compareDTOValue(Object o1, Object o2)
			throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {

		Class o1Clsss = o1.getClass();
		Class o2Clsss = o2.getClass();

		Method o1cMethods[] = o1Clsss.getMethods();
		Method o2Methods[] = o2Clsss.getMethods();

		Object[] paramArgs = null;// param
		Class o1Type = null;
		Class o2Type = null;
		Object o1Val = null;
		Object o2Val = null;
		String o1MethodName = "";
		String o2MethodName = "";

		for (int i = 0; i < o1cMethods.length; i++) {
			Method o1Method = o1cMethods[i];
			o1MethodName = o1Method.getName();
			String result = "";

			if (o1MethodName.startsWith("get")) {

				o1Val = o1Method.invoke(o1, paramArgs);
				o1Type = o1Method.getReturnType();
				o2Val = null;
				o2MethodName = "";

				for (int j = 0; j < o2Methods.length; j++) {
					Method o2Method = o2Methods[j];
					o2MethodName = o2Method.getName();

					if (o1MethodName.equals(o2MethodName)) {
						o2Val = o2Method.invoke(o2, paramArgs);
						o2Type = o2Method.getReturnType();
						break;
					}
				}

				if (o2Val == null) {
					break;
				} else {
					System.out.println("same method Name >> " + o1MethodName);
				}

				System.out.println("o1Val >> " + o1Val);
				System.out.println("o2Val >> " + o2Val);
				System.out.println("o1Type >> " + o1Type);
				System.out.println("o2Type >> " + o2Type);

				if (o1Val != null && o1Val.equals(o2Val) && o1Type.equals(o2Type)) {
					result = "SAME";
				} else {
					result = "NOT SAME";
				}
				System.out.println("result >> " + result);
				System.out.println("");
				System.out.println("----------------------------------");
			}
		}
	}

	public static void compareDTOValue(Object o1, Object o2, List<String> getMethodList)
			throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {

		Class o1Clsss = o1.getClass();
		Class o2Clsss = o2.getClass();

		Method o1cMethods[] = o1Clsss.getMethods();
		Method o2cMethods[] = o2Clsss.getMethods();

		Object[] paramArgs = null;// param
		Class o1Type = null;
		Class o2Type = null;
		Object o1Val = null;
		Object o2Val = null;
		String o1MethodName = "";
		String o2MethodName = "";

		List<String> o1cMethodslist = new ArrayList<String>();
		for (int i = 0; i < o1cMethods.length; i++) {
			Method o1Method = o1cMethods[i];
			o1MethodName = o1Method.getName();
			// if (o1MethodName.startsWith("get")) {
			o1cMethodslist.add(o1Method.getName());
			// }
		}

		List<String> o2cMethodslist = new ArrayList<String>();
		for (int i = 0; i < o2cMethods.length; i++) {
			Method o2Method = o2cMethods[i];
			o2MethodName = o2Method.getName();
			// if (o2MethodName.startsWith("get")) {
			o2cMethodslist.add(o2Method.getName());
			// }
		}

		for (String getMethod : getMethodList) {
			String getName = "get" + getMethod.substring(0, 1).toUpperCase() + getMethod.substring(1);
			if (o1cMethodslist.contains(getName) && o2cMethodslist.contains(getName)) {
				System.out.println("번째 >> " + o1cMethodslist.indexOf(getName));
				System.out.println("번째 >> " + o2cMethodslist.indexOf(getName));
				System.out.println("getMethod >> " + getMethod);

				int o1Index = o1cMethodslist.indexOf(getName);
				int o2Index = o2cMethodslist.indexOf(getName);

				Method o1Method = o1cMethods[o1Index];
				o1Val = o1Method.invoke(o1, paramArgs);
				o1Type = o1Method.getReturnType();

				Method o2Method = o2cMethods[o2Index];
				o2Val = o2Method.invoke(o2, paramArgs);
				o2Type = o2Method.getReturnType();

				String result = "";

				if (o2Val == null) {
					break;
				} else {
					System.out.println("same method Name >> " + o1MethodName);
				}

				System.out.println("o1Val >> " + o1Val);
				System.out.println("o2Val >> " + o2Val);
				System.out.println("o1Type >> " + o1Type);
				System.out.println("o2Type >> " + o2Type);

				if (o1Val != null && o1Val.equals(o2Val) && o1Type.equals(o2Type)) {
					result = "SAME";
				} else {
					result = "NOT SAME";
				}
				System.out.println("result >> " + result);
				System.out.println("");
				System.out.println("----------------------------------");
			}
		}

	}

	static void main2() {
		System.out.println("");
		// 상속 안 된다
		try {
			Person p2 = new Person("Korean", "John", 90, "Doctor");
			Object obj = p2;
			for (Field field : obj.getClass().getDeclaredFields()) {
				field.setAccessible(true);
				Object value = field.get(obj);
				System.out.println(field.getName() + "," + value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
