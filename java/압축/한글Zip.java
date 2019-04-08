package zTestWeb;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.charset.Charset;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
 
public class 한글Zip {

    /**
     * 파일 만들기 메소드
     * @param file 파일
     * @param zis Zip스트림
     */
    private static void createFile(File file, ZipInputStream zis) throws Throwable {
        //디렉토리 확인
        File parentDir = new File(file.getParent());
        //디렉토리가 없으면 생성하자
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
        //파일 스트림 선언
        try (FileOutputStream fos = new FileOutputStream(file)) {
            byte[] buffer = new byte[256];
            int size = 0;
            //Zip스트림으로부터 byte뽑아내기
            while ((size = zis.read(buffer)) > 0) {
                //byte로 파일 만들기
                fos.write(buffer, 0, size);
            }
        } catch (Throwable e) {
            throw e;
        }
    }
    
    /**
     * 압축풀기 메소드
     * @param zipFileName 압축파일
     * @param directory 압축 풀 폴더
     */
    public static void decompress(String zipFileName, String directory) throws Throwable {
        File zipFile = new File(zipFileName);
        FileInputStream fis = null;
        ZipInputStream zis = null;
        ZipEntry zipentry = null;
        try {
            //파일 스트림
            fis = new FileInputStream(zipFile);
            //Zip 파일 스트림
//            zis = new ZipInputStream(fis);
//            zis = new ZipInputStream(fis,Charset.forName("ISO-8859-1"));
//            zis = new ZipInputStream(fis,Charset.forName("UTF-8"));
//            zis = new ZipInputStream(fis,Charset.forName("Cp437"));
            zis = new ZipInputStream(fis,Charset.forName("EUC-KR"));
            //entry가 없을때까지 뽑기
            while ((zipentry = zis.getNextEntry()) != null) {
                String filename = zipentry.getName();
               
                File file = new File(directory, filename);
                //entiry가 폴더면 폴더 생성
                if (zipentry.isDirectory()) {
                	System.out.println("1. FOLD >> " + filename);
                    file.mkdirs();
                } else {
                	System.out.println("  2. file >> " + filename);
                    //파일이면 파일 만들기
                    createFile(file, zis);
                }
            }
        } catch (Throwable e) {
            throw e;
        } finally {
            if (zis != null)
                zis.close();
            if (fis != null)
                fis.close();
        }
    }    
    
    //압축된 zip에 한글이름 파일시 에러 
    public static void main(String[] args){
        try{
//        	System.out.println("start");
//            Zip.decompress("D:\\test//반디집2.zip", "D:\\test//result//반디집");
            한글Zip.decompress("D:\\test//알집.zip", "D:\\test//result//알집");
//            System.out.println("end");
        }catch(Throwable e){
            e.printStackTrace();
           System.out.println(e);
        }
    }
}


