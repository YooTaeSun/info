package www.townsi.com.compare;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import www.townsi.com.vo.Human;
import www.townsi.com.vo.Person;

public class CompareUtil {

	public static enum COMPARE {
		GET_METHOD_ALL("ALL"),
		GET_METHOD_LIST("LIST"),
		GET_METHOD_START_GETNAME_LIST("START_GET_LIST"),
		GET_METHOD_START_NO_GETNAME_LIST("START_NO_GET_LIST");

		private final String value;

		private COMPARE(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	 * 데이터를 비교한다.
	 * @throws Exception
	 */

	private static boolean exceCompareGetVal(COMPARE type, Object o1, Object o2, List<String> getMethodList, Map<String, String> otherMpCditMap) throws Exception {

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

		if (getMethodList == null) {
			getMethodList = new ArrayList<String>(o1cMethodsMap.keySet());
		}

		Map<String, Object> o2cMethodsMap = new HashMap<String, Object>();
		for (int i = 0; i < o2cMethods.length; i++) {
			Method o2Method = o2cMethods[i];
			o2MethodName = o2Method.getName();
			if (o2MethodName.startsWith("get") && !o2MethodName.equals("getClass")) {
				o2cMethodsMap.put(o2MethodName, o2cMethods[i]);
			}
		}

		boolean isMapping = Boolean.TRUE;
		if (otherMpCditMap == null) {
			isMapping = Boolean.FALSE;
		}

		String getName1 = "";
		String getName2 = "";
		String name1 = "";
		String name2 = "";
		boolean isSame = Boolean.TRUE;

		for (String getMethod : getMethodList) {
			if (COMPARE.GET_METHOD_START_NO_GETNAME_LIST.getValue().equals(type.getValue())) {
				getName1 = "get" + getMethod.substring(0, 1).toUpperCase() + getMethod.substring(1);
				getName2 = getName1;
				name1 = getMethod;
				name2 = getMethod;
			} else {
				getName1 = getMethod;
				getName2 = getMethod;
				name1 = getMethod.substring(3, 4).toLowerCase() + getMethod.substring(4);
				name2 = name1;
			}

			if (isMapping) {
				if (otherMpCditMap.containsKey(name1)) {
					name2 = otherMpCditMap.get(name1);
					getName2 = "get" + name2.substring(0, 1).toUpperCase() + name2.substring(1);
				}
			}

//			System.out.println("getName1 >> " + getName1);
//			System.out.println("getName2 >> " + getName2);
//			System.out.println("name1 >> " + name1);
//			System.out.println("name2 >> " + name2);
//			System.out.println("");

			if (o1cMethodsMap.containsKey(getName1) && o2cMethodsMap.containsKey(getName2)) {

				Method o1Method = (Method) o1cMethodsMap.get(getName1);
				o1Val = o1Method.invoke(o1, paramArgs);
				o1Type = o1Method.getReturnType();

				Method o2Method = (Method) o2cMethodsMap.get(getName2);
				o2Val = o2Method.invoke(o2, paramArgs);
				o2Type = o2Method.getReturnType();

				System.out.println("getMethod >> " + getMethod);
				System.out.println("o1Val >> " + o1Val);
				System.out.println("o2Val >> " + o2Val);
				System.out.println("o1Type >> " + o1Type);
				System.out.println("o2Type >> " + o2Type);

				String result = "";

				if (o1Val != null && o2Val != null && o1Val.equals(o2Val) && o1Type.equals(o2Type)) {
					result = "SAME";

					System.out.println("result >> " + result);
					System.out.println("");
					System.out.println("----------------------------------");
				} else if (o1Val == null && o2Val == null) {
					result = "NULL SAME";

					System.out.println("result >> " + result);
					System.out.println("");
					System.out.println("----------------------------------");
				} else {
					result = "NOT SAME";
					isSame = Boolean.FALSE;

					System.out.println("result >> " + result);
					System.out.println("");
					System.out.println("----------------------------------");
					break;
				}
			}
		}
		return isSame;
	}


	public static boolean compareGetVal(Object o1, Object o2) throws Exception {
		return exceCompareGetVal(COMPARE.GET_METHOD_ALL, o1, o2, null, null);
	}

	public static boolean compareGetVal(Object o1, Object o2, COMPARE type) throws Exception{
		return exceCompareGetVal(type, o1, o2, null, null);
	}

	public static boolean compareGetVal(Object o1, Object o2, COMPARE type, List<String> getMethodList) throws Exception {
		if (COMPARE.GET_METHOD_LIST.getValue().equals(type.getValue())) {
			type = COMPARE.GET_METHOD_START_NO_GETNAME_LIST;
		}
		return exceCompareGetVal(type, o1, o2, getMethodList, null);
	}

	public static boolean compareGetVal(Object o1, Object o2, COMPARE type, List<String> getMethodList, Map<String, String> otherMpCditMap) throws Exception {
		if (COMPARE.GET_METHOD_LIST.getValue().equals(type.getValue())) {
			type = COMPARE.GET_METHOD_START_NO_GETNAME_LIST;
		}
		return exceCompareGetVal(type, o1, o2, getMethodList, otherMpCditMap);
	}

	public static void main(String[] args) {
		Person o1 = new Person("Korean", "John", 10, "Doctor", "aaaa");
		Human o2 = new Human("Korean", "John", 10, "Doctor");

		List<String> getMethodlist = new ArrayList<String>();
		getMethodlist.add("age");
		getMethodlist.add("name");
		getMethodlist.add("job");
		getMethodlist.add("space");

		Map<String, String> otherMpCditMap = new HashMap<String, String>();
		otherMpCditMap.put("space2", "name");
		boolean isSame =  Boolean.TRUE;
		try {
//			 isSame = compareGetVal(o1, o2);// o1기준 get메서드 다 비교
//			 isSame = compareGetVal(o1, o2, COMPARE.GET_METHOD_ALL);//get메서드 다 비교
//			 isSame = compareGetVal(o1, o2, COMPARE.GET_METHOD_LIST, getMethodlist);
			 isSame = compareGetVal(o1, o2, COMPARE.GET_METHOD_LIST, getMethodlist ,otherMpCditMap);

			 System.out.println("isSame boolean >> " + isSame);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
