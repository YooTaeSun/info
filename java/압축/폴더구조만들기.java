package zTestWeb;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;

class testFile {
	File ft = null;
	String path = "";
}

public class 폴더구조만들기 {

	public static ArrayList<String> dirList = new ArrayList<String>();
	public static ArrayList<testFile> fileList = new ArrayList<testFile>();
	public static String desti = "D:\\mk";
	public static String source = "D:\\반디집";

	public static void main(String[] args) {
		new 폴더구조만들기();
	}

	public 폴더구조만들기() {
		subDirList(this.source);

		// 디렉토리 생성

		for (int i = 0; i < dirList.size(); i++) {
			File temp = new File(dirList.get(i));
			if (!temp.exists()) {
				temp.mkdirs();
			}
		}

		BufferedWriter bw = null;
		BufferedReader br = null;

		try {

			for (int i = 0; i < this.fileList.size(); i++) {
				br = new BufferedReader(new InputStreamReader(new FileInputStream(fileList.get(i).ft)));
				bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileList.get(i).path)));

				while (true) {
					String str = br.readLine();
					if (str == null)
						break;
					bw.write(str);
					bw.newLine();

				}
				br.close();
				bw.close();

			}

		} catch (IOException E) {
		}

	}

	public void subDirList(String source) {
		File dir = new File(source);
		File[] fileList = dir.listFiles();

		try {
			for (int i = 0; i < fileList.length; i++) {
				File file = fileList[i];
				if (file.isFile()) {
					String rep = this.source.replaceAll("\\\\", "/");
					String path = this.desti + file.getPath().replaceAll("\\\\", "/").replaceAll(rep, "");

					testFile tf = new testFile();
					tf.path = path;
					tf.ft = file;
					System.out.println(path);

					this.fileList.add(tf);

				} else if (file.isDirectory()) {

					String rep = this.source.replaceAll("\\\\", "/");
					String path = this.desti + file.getPath().replaceAll("\\\\", "/").replaceAll(rep, "");
					this.dirList.add(path);
					subDirList(file.getCanonicalPath().toString());
				}

			}

		} catch (IOException e) {

		}
	}
}
