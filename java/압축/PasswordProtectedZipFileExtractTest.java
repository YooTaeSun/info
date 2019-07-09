package zJava.testProject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Iterator;

import jp.hishidama.zip.ZipEntry;
import jp.hishidama.zip.ZipFile;
import jp.hishidama.zip.ZipOutputStream;

/**
 * 비밀번호가 걸린 ZIP 파일 읽기 테스트.
 * @since 2010.02.01.
 */
public class PasswordProtectedZipFileExtractTest {

	public static void main(String[] args) throws Exception {
		PasswordProtectedZipFileExtractTest.make();
	}
	
	
     public static void make() throws Exception {
 
         String password = "1111";
 
         ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File("c:\\test/1.zip")));
         PrintWriter pw = new PrintWriter(new OutputStreamWriter(zos, "euc-kr"));
 
         zos.setPassword(password.getBytes("MS932"));
 
         ZipEntry ze = new ZipEntry("1/Hello.txt");
 
         zos.putNextEntry(ze);
 
         File f = new File("C:\\test/1가a.txt");
         
         pw.println("안녕하세요? 반갑습니다.");
         pw.println("이 파일은 비밀번호가 들어간 ZIP 파일 만들기 테스트용입니다.");
 
         // Zip파일 내 파일(? ^^;)의 내용을 Entry를 닫기 전에 밀어 넣는다. 안 그럼 내용이 뒤 파일에 나온다.
         pw.flush();
 
         // Entry를 닫는다.
         zos.closeEntry();
 
         // 그리고 다음 Entry로.
         ze = new ZipEntry("2/Hello2.txt");
 
         zos.putNextEntry(ze);
 
         pw.println("안녕하세요? 반갑습니다.");
         pw.println("이 파일은 비밀번호가 들어간 ZIP 파일 만들기 테스트용입니다.");
         pw.println("Zip 파일 내 하위 디렉토리에 생기는 파일입니다.");
 
         pw.flush();
 
         zos.closeEntry();
         zos.close();
 
         pw.close();
 
         System.out.println("비밀번호가 걸린 Zip 파일 생성 완료!");
     }
	
    /**
     * @param args
     * @throws Exception
     */
    public static void make2(String[] args) throws Exception {

        String password = "1111";

        ZipFile zf = new ZipFile(new File("C:\\test/1.zip"));
        zf.setPassword(password.getBytes());

        for (Iterator i = zf.getEntriesIterator(); i.hasNext();) {
            ZipEntry ze = (ZipEntry) i.next();

            System.out.println("파일명: " + ze.getName() + " =======================================");

            InputStream is = zf.getInputStream(ze);
            BufferedReader br = new BufferedReader(new InputStreamReader(is, "euc-kr"));

            String line = null;

            while ((line = br.readLine()) != null ) {
                System.out.println(line);
            }

            System.out.println("== Size: " + ze.getCompressedSize() + " byte(s) =======================================");
            System.out.println();

            is.close();
            br.close();
        }

        zf.close();

        System.out.println("비밀번호가 걸린 Zip 파일 내용 읽어 보여주기 완료!");
    }
}