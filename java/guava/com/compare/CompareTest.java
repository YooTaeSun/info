package www.townsi.com.compare;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import www.townsi.com.vo.Person;

public class CompareTest {

	public static void main(String[] args) {
		Person p1 = new Person("Ame","John", 30, "Doctor");
		Person p2 = new Person("Korean","John", 90, "Doctor");
		compareDTOValue(p1, p2);
//		main2();
	}
	/**
	 * DTO간 데이터를 전송(복사)한다.
	 */
	public static void compareDTOValue(Object srcDTO, Object tgtDTO) {
		try {
			Class srcClass = srcDTO.getClass();
			Class tgtClass = tgtDTO.getClass();

			Method srcMethods[] = srcClass.getMethods();

			for (int i = 0; i < srcMethods.length; i++) {
				Method srcMethod = srcMethods[i];
				String srcMethodName = srcMethod.getName();
				Object[] args = null;
				Class[] paras = new Class[1];
				Object[] args2 = new Object[1];
				String result = "";

				if (srcMethodName.startsWith("get")) {
					System.out.println("1 srcMethodName >> " + srcMethodName);
					try {
						Object returnSrcObj = srcMethod.invoke(srcDTO, args);
						Object returnTgtObj = srcMethod.invoke(tgtDTO, args);
						Class returnType = srcMethod.getReturnType();


						System.out.println("returnSrcObj >> " + returnSrcObj);
						System.out.println("returnTgtObj >> " + returnTgtObj);
						System.out.println("returnType >> " + returnType);

						if ((returnSrcObj == null) && (returnTgtObj != null)) {
							// 다른값
							result = "NOT SAME";
						} else if ((returnSrcObj != null) && (returnTgtObj == null)) {
							// 다른값
							result = "NOT SAME";
						} else if ((returnSrcObj == null) && (returnTgtObj == null)) {
							// 같은값
							result = "SAME";
						} else if ((returnSrcObj != null) && (returnTgtObj != null)) {
							// 둘다 널이 아닐때
							if (returnSrcObj.equals(returnTgtObj)) {
								// 같을 때
								result = "SAME";
							} else {
								// 다를 때
								result = "NOT SAME";
							}
						}
					} catch (IllegalArgumentException iae) {
						// iae.printStackTrace();
					}
					System.out.println("result >> " + result);
					System.out.println("");
				}
//				} else if (srcMethodName.length() >= 2 && srcMethodName.substring(0, 2).equals("is")) {
//					try {
//						Object returnSrcObj = srcMethod.invoke(srcDTO, args);
//						Object returnTgtObj = srcMethod.invoke(tgtDTO, args);
//						Class returnType = srcMethod.getReturnType();
//
//						if ((returnSrcObj == null) && (returnTgtObj != null)) {
//							// 다른값
//							result = "NOT SAME";
//						} else if ((returnSrcObj != null) && (returnTgtObj == null)) {
//							// 다른값
//							result = "NOT SAME";
//						} else if ((returnSrcObj == null) && (returnTgtObj == null)) {
//							// 같은값
//							result = "SAME";
//						} else if ((returnSrcObj != null) && (returnTgtObj != null)) {
//							// 둘다 널이 아닐때
//							if (returnSrcObj.equals(returnTgtObj)) {
//								// 같을 때
//								result = "SAME";
//							} else {
//								// 다를 때
//								result = "NOT SAME";
//							}
//						}
//					} catch (IllegalArgumentException iae) {
//						// iae.printStackTrace();
//					}
//				}
			}

		} catch (InvocationTargetException ite) {
			// ite.printStackTrace();w
		} catch (IllegalAccessException iae) {
			// iae.printStackTrace();
		}

	}


	static void main2() {
		System.out.println("");
		//상속 안 된다
		   try{
			   Person p2 = new Person("Korean","John", 90, "Doctor");
		        Object obj=p2;
		        for (Field field : obj.getClass().getDeclaredFields()){
		            field.setAccessible(true);
		            Object value=field.get(obj);
		            System.out.println(field.getName()+","+value);
		        }
		    }catch (Exception e){
		        e.printStackTrace();
		    }

	}

}
