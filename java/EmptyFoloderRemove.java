package zTestWeb;

import java.io.File;

public class EmptyFoloderRemove {

//	private static final String FOLDER_LOCATION = "G:\\\\정리";
	private static final String FOLDER_LOCATION = "D:\\투디스크 다운로드";
	private static boolean isFinished = false;

	private static void replaceText(String fileLocation) {
		
		File folder = new File(fileLocation);
		File[] listofFiles = folder.listFiles();
		
		if (listofFiles.length == 0) {
			System.out.println("Folder Name :: " + folder.getAbsolutePath() + " is deleted.");
			folder.delete();
			isFinished = false;
		} else {
			for (int j = 0; j < listofFiles.length; j++) {
				File file = listofFiles[j];
				if (file.isDirectory()) {
					System.out.println(" getAbsolutePath >> " + folder.getAbsolutePath());
					replaceText(file.getAbsolutePath());
				}
			}
		}
	}

	public static void main(String[] args) {
		System.out.println(" start >>> ");
		do {
			isFinished = true;
			replaceText(FOLDER_LOCATION);
		} while (!isFinished);

		System.out.println(" end >>> ");
	}

}
