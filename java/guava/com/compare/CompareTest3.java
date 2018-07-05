package www.townsi.com.compare;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import www.townsi.com.vo.Human;
import www.townsi.com.vo.Person;

public class CompareTest3 {

	public static void main(String[] args)
			throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Person p1 = new Person("John", "John", 30, "Doctor", "aaaa");
		Human p2 = new Human("Korean", "John", "30", "Doctor");

		List<String> getMethodlist = new ArrayList<String>();
		getMethodlist.add("age");
		getMethodlist.add("name");
		getMethodlist.add("job");
		getMethodlist.add("space");

//		 compareDTOValue(p1, p2);
//		compareDTOValue(p1, p2, getMethodlist);


		Map<String, String> mappingMap = new HashMap<String, String>();
		mappingMap.put("space", "name");

		compareDTOValue(p1, p2, getMethodlist , mappingMap);
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

	public static void compareDTOValue(Object o1, Object o2, List<String> getMethodList, Map<String, String> mappingMap)
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

		Map<String, Object> o1cMethodsMap = new HashMap<String, Object>();
		for (int i = 0; i < o1cMethods.length; i++) {
			Method o1Method = o1cMethods[i];
			o1MethodName = o1Method.getName();
			if (o1MethodName.startsWith("get") && !o1MethodName.equals("getClass")) {
				o1cMethodsMap.put(o1MethodName, o1cMethods[i]);
			}
		}

		Map<String, Object> o2cMethodsMap = new HashMap<String, Object>();
		for (int i = 0; i < o2cMethods.length; i++) {
			Method o2Method = o2cMethods[i];
			o2MethodName = o2Method.getName();
			if (o2MethodName.startsWith("get") && !o2MethodName.equals("getClass")) {
				o2cMethodsMap.put(o2MethodName, o2cMethods[i]);
			}
		}

		boolean isMapping = Boolean.FALSE;
		if(mappingMap != null && mappingMap.size() > 0){
			isMapping = Boolean.TRUE;
		}
		for (String getMethod : getMethodList) {
			String getName1 = "get" + getMethod.substring(0, 1).toUpperCase() + getMethod.substring(1);
			String getName2 = getName1;
			String name1 = getMethod;//age
			String name2 = getMethod;//age
			if(isMapping){
				if(mappingMap.containsKey(name1)){
					name2 = mappingMap.get(name1);
					getName2 = "get" + name2.substring(0, 1).toUpperCase() + name2.substring(1);
				}
			}

			System.out.println("name1 >> " + name1);
			System.out.println("name2 >> " + name2);
			System.out.println("getName1 >> " + getName1);
			System.out.println("getName2 >> " + getName2);
			System.out.println("");

			if (o1cMethodsMap.containsKey(getName1) && o2cMethodsMap.containsKey(getName2)) {

				System.out.println("getMethod >> " + getMethod);

				Method o1Method = (Method)o1cMethodsMap.get(getName1);
				o1Val = o1Method.invoke(o1, paramArgs);
				o1Type = o1Method.getReturnType();

				Method o2Method = (Method)o2cMethodsMap.get(getName2);
				o2Val = o2Method.invoke(o2, paramArgs);
				o2Type = o2Method.getReturnType();

				System.out.println("o1Val >> " + o1Val);
				System.out.println("o2Val >> " + o2Val);
				System.out.println("o1Type >> " + o1Type);
				System.out.println("o2Type >> " + o2Type);

				String result = "";

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
}
