package zJavaTest;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class EnumConstant {
	enum attrEnum {
	    C01("01", "이름"),
	    C02("02", "날짜"),
		C03("03", "화장품");

	    private final String retType;
	    private final String value;

	    attrEnum(String retType, String value) {
	        this.retType = retType;
	        this.value = value;
	    }

	    public String getRetType() {
	        return retType;
	    }
	    public String getValue() {
	        return value;
	    }
	    
	    @Override
	    public String toString() {
	    	System.out.println(
//	    			"aaaa >> "
	    			); 
	    	return super.toString();
	    }
	}


	
	public static void main(String[] args) {
		String retType = EnumConstant.attrEnum.C01.getRetType();
		String value = EnumConstant.attrEnum.C01.getValue(); 
		
		EnumConstant.attrEnum attrEnumValueOf = EnumConstant.attrEnum.valueOf("C02");
		
		String code = "02";
		String val = "";

		
//		System.out.println(
//				" retType >> " + retType
//				+"\n value >> " + value
//				+"\n attrEnumValueOf.getretType() >> " + attrEnumValueOf.getretType()
//				+"\n attrEnumValueOf.getValue() >> " + attrEnumValueOf.getValue()
//				+"\n val1 >> " + val
//				+"\n val2 >> " + EnumConstant.attrEnum.valueOf(EnumConstant.attrEnum.class, "C02")
//				+"\n val3 >> " + EnumConstant.attrEnum.valueOf("C02")
//					);
		
//		val = CodeUtil.getVal(EnumConstant.attrEnum.values(), code);
//		val = CodeUtil.getVal1(EnumConstant.attrEnum.values(), code);
//		
//		val = CodeUtil.getVal2(EnumConstant.attrEnum.values(), "01");
//		val = CodeUtil.getVal2(EnumConstant.attrEnum.values(), "02");
//		val = CodeUtil.getVal2(EnumConstant.attrEnum.values(), "03");
		
//		val = CodeUtil.getVal3(EnumConstant.attrEnum.values(), "03");
//		val = CodeUtil.getVal3(EnumConstant.attrEnum.values(), "02");
		val = CodeUtil.getVal3(EnumConstant.attrEnum.values(), "01");
		
//		val = CodeUtil.getCaseVal3(EnumConstant.attrEnum.values());
		
		
	}
}

class CodeUtil {
	public static String getVal(EnumConstant.attrEnum[] attrEnums, String code) {
		String val = "";
		for (EnumConstant.attrEnum attrEnum : attrEnums) {
			if (attrEnum.getRetType().equals(code)) {
				val = attrEnum.getValue();
				break;
			}
		}
		return val;
	}
	
	public static String getVal1(EnumConstant.attrEnum[] attrEnums, String code) {
		String val = Arrays.asList(attrEnums).stream().filter(o1->o1.getRetType().equals(code)).map(o->o.getValue()).collect(Collectors.joining());
		System.out.println(" getVal1 >> " + val);
		return val;
	}
	
	
	public static <T extends Comparable<T>> String getVal2(T[] attrEnums, String code)  {
		
	    String val = "";
	    Object o1Val = null;
	    
	    try {
		    for (T e : attrEnums) {
		    	List<Method> mlist = Arrays.asList(e.getClass().getMethods()).stream().filter(o->o.getName().equals("getRetType") || o.getName().equals("getValue")).collect(Collectors.toList());
		    	
		    	for (int i = 0; i < mlist.size(); i++) {
		    		Method o = mlist.get(i);
		    		if(o.getName().equals("getRetType")) {
		    			o1Val = o.invoke(e);
		    			if(o1Val.equals(code)) {
		    				System.out.println(
		    						" o1Val >> " + o1Val
		    						+ "\n valuE >> " + mlist.get((i == 0)? 1:0).invoke(e)
		    				);
		    			}
		    		}
				}
		    	
		    	System.out.println("--------------------------------");
		    	
		    	mlist.stream().forEach(o->{
		    		try {
		    			Object o1Val0 = "";
						if(o.getName().equals("getRetType")) {
							o1Val0 = o.invoke(e);
			    			if(o1Val0.equals(code)) {
									System.out.println(
											" o1Val >> " + o1Val0
											+ "\n valuE >> " + mlist.get((o == mlist.get(0))? 1:0).invoke(e)
									);
			    			}
						}
		    		} catch (Exception e1) {
		    			e1.printStackTrace();
		    		}
				});
		    	
		    	
		    	
		    }
	    }catch (Exception e1) {
			throw new RuntimeException(e1.getMessage());
		}
	    return val;
	}
	
	public static <T> String getVal3(T[] eList, String code)  {
		
		final String KEY_METHOD = "getRetType";
		final String VAL_METHOD = "getValue";
		
		String val = "";
		Object oVal = null;
		List<Method> kvList = null;
		
		try {
			for (T e : Arrays.asList(eList)) {
				kvList = Arrays.asList(e.getClass().getMethods())
							.stream()
							.filter(o->o.getName().equals(KEY_METHOD) || o.getName().equals(VAL_METHOD))
							.collect(Collectors.toList());
	
		    	for (int i = 0; i < kvList.size(); i++) {
		    		Method o = kvList.get(i);
		    		if(o.getName().equals(KEY_METHOD)) {
		    			oVal = o.invoke(e);
		    			if(oVal.equals(code)) {
								System.out.println(
										" getVal3 >> " + oVal
										+ "\n getVal3 valuE >> " + kvList.get((i == 0)? 1:0).invoke(e)
								);
								val = kvList.get((i == 0)? 1:0).invoke(e).toString();
		    			}
		    		}
				}
			}
		
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return val;
	}
	
/*
case 
WHEN code = '01' THEN ''
WHEN code = '' THEN ''
WHEN code = '' THEN ''
end 
 
 * */	
//public static <T> String getCaseVal3(T[] eList)  {
//		String field ="code";
//		String str = "WHEN code = 'ret' THEN 'val'";
//		final String KEY_METHOD = "getRetType";
//		final String VAL_METHOD = "getValue";
//		StringBuilder sb = new StringBuilder(); 
//		
//		String val = "";
//		Object oVal = null;
//		List<Method> kvList = null;
//		
//		try {
//			for (T e : Arrays.asList(eList)) {
//				kvList = Arrays.asList(e.getClass().getMethods())
//							.stream()
//							.filter(o->o.getName().equals(KEY_METHOD) || o.getName().equals(VAL_METHOD))
//							.collect(Collectors.toList());
//	
//		    	for (int i = 0; i < kvList.size(); i++) {
//		    		Method o = kvList.get(i);
//		    		if(o.getName().equals(KEY_METHOD)) {
//		    			oVal = o.invoke(e);
//		    			val = kvList.get((i == 0)? 1:0).invoke(e).toString();
//		    		}
//				}
//			}
//		
//		} catch (Exception e) {
//			throw new RuntimeException(e.getMessage());
//		}
//		return val;
//	}
//	public interface Comparable<T> {
//	    public int compareTo(String code);
//	}
	
	public static <T extends Comparable<T>> int countGreaterThan(T[] anArray, T elem) {
	    int count = 0;
	    for (T e : anArray)
	        if (e.compareTo(elem) > 0)
	            ++count;
	    return count;
	}
}
