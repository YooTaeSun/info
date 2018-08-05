package www.townsi.com.link;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.townsi.utils.FileUtil;
import com.townsi.utils.StrUtil;

@SuppressWarnings("rawtypes")
public class LinkTest {



	
	public static void main(String[] args) {
		
		String jspFilePath = "D:\\project\\02\\eGovFrameDev-3.7.0-64bit\\workspace\\linkTest\\src\\main\\webapp";
		String rControllerFilePath = "D:\\project\\02\\eGovFrameDev-3.7.0-64bit\\workspace\\linkTest\\src\\main\\controller";
		String wControllerFilePath = "D:\\project\\02\\eGovFrameDev-3.7.0-64bit\\workspace\\zGuava\\WebContent\\WEB-INF\\simple";
		String wControllerFilePath2 = "";
		
		
		
		
		//
		File controllFiles = new File(rControllerFilePath);
		File[] files = controllFiles.listFiles();
		
		if(files != null && files.length > 0){
			
			String name = ""; 
			String absolutePath = ""; 
			int a_cnt = 0; 
			for (int i = 0; i < files.length; i++) {
				File file = files[1];
				
//				a_cnt = 0;
				
				name = file.getName();
				absolutePath = file.getAbsolutePath();
				
//				System.out.println("name >> " + name);
//				System.out.println("absolutePath >> " + absolutePath);
				
				String str = readFile(absolutePath);
				
				//주석제거 
				str = str.replaceAll("/\\*([^*]|[\r\n]|(\\*+([^*/]|[\r\n])))*\\*+/", ""); // 마지막에 '+' 넣어서 해결
				str = str.replaceAll("(?:/\\*(?:[^*]|(?:\\*+[^*/]))*\\*+/)|(?://.*)","");
				str = StrUtil.replaceLast(str.replaceFirst("\\{", ""),"\\}","");
				
				wControllerFilePath2 = wControllerFilePath + "\\" + name;
				
				Pattern pattern = Pattern.compile("\\{([^]]+)\\}");
//				Pattern methodPattern = Pattern.compile("\\{[a-zA-Z]+[^>]+[\\}])([^{]*)(\\{\\/[a-zA-Z]+\\}");
				Pattern methodPattern = Pattern.compile("[\\{\\}");
				Matcher matcher = methodPattern.matcher(str);
				String str2 = "";
				String classBody = "";
				String methodBody = "";
				
//				Pattern methodPattern = Pattern.compile("\\{([^]]+)\\}");
				
				
				
				while(matcher.find()){
					classBody = matcher.group();
					//클래스 콸호 제거
					System.out.println("classBody >> " + classBody);
//					Matcher methodMatcher = methodPattern.matcher(classBody);
//					while(methodMatcher.find()){
//						methodBody = methodMatcher.group();
//						System.out.println(methodBody);
////						str = str.replace(methodBody, methodBody.replaceFirst("{", ""));
//					}
				}
				

				FileUtil.writeFile(wControllerFilePath2, classBody);
				
				str = readFile(wControllerFilePath2);
				
//				matcher = pattern.matcher(str);
//				while(matcher.find()){
//					methodBody = matcher.group(0);
//					System.out.println(methodBody);
//					str = str.replace(methodBody, methodBody.replaceFirst("{", ""));
////					str2 = matcher.group(0);
////					matcher3 = pattern.matcher(str2);
////					while(matcher3.find()){
////					}
//				}
				
				System.out.println("");
//				System.out.println("str >> " + str);
				
				if(true) return;


				System.out.println("-------------------------------------");				
				System.out.println(str);				
				System.out.println("-------------------------------------");

//				Pattern pattern3 = Pattern.compile("@RequestMapping\\((.*?)\\)");
//				Matcher matcher3 = pattern3.matcher(str);
//				String requestMappingStr = "";
//				while(matcher3.find()){
//					requestMappingStr = matcher3.group(0);
//					str = str.replace(requestMappingStr, "{" + requestMappingStr);
////					System.out.println(str);
//				}				
				
				
				if(true) return;
				
				
//System.out.println("-------------------------------------");				
//System.out.println(str);				
//System.out.println("--------------------	1111	-----------------");

				
				System.out.println("-------------------------------------");				
				System.out.println(str);				
				System.out.println("-------------------------------------");
				System.out.println("-------------------------------------");
				
				
				break;
				
			}
		}
		
		
	}
	
	public static String readFile(String filePath) {
		BufferedReader br = null;
		StringBuilder sb = null;
		try {
			br = new BufferedReader(new FileReader(filePath));
			String line = "";
			sb = new StringBuilder(1000);
			while ((line = br.readLine()) != null){
				if(!line.trim().equals("")){
					sb.append(line + "\r\n");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

			if (br != null)
				try {
					br.close();
				} catch (IOException localIOException) {
				}
		} finally {
			if (br != null)
				try {
					br.close();
				} catch (IOException localIOException1) {
				}
		}
		return sb.toString();
	}
}



