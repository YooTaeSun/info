package zTestWeb;

import java.io.File;

public class EmptyFoloderRemove {

	private static final String FOLDER_LOCATION = "G:\\\\정리";
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

				String fileNm = file.getName();

				if (file.isDirectory()) {
//					System.out.println(" getAbsolutePath >> " + folder.getAbsolutePath());
					replaceText(file.getAbsolutePath());
				} else {
					if (fileNm.lastIndexOf(".") > -1) {
						String exn = fileNm.substring(fileNm.lastIndexOf(".") + 1).toLowerCase();
//					System.out.println("fileNm ->" + fileNm  + " exn >> " + exn);
//						System.out.println(exn);

						//지우는 대상 확장자
						if (exn.equals("jpg") || exn.equals("png") || exn.equals("txt") || exn.equals("smi") || exn.equals("db")) {

							if (exn.equals("smi")) {
								if(folder.listFiles().length == 1) {
									System.out.println(file.getAbsolutePath() + " is deleted.");
									file.delete();
									System.out.println("Folder Name :: " + folder.getAbsolutePath() + " is deleted.");
									folder.delete();
								}
							}else {
								System.out.println(file.getAbsolutePath() + " is deleted.");
								file.delete();
							}
						} 
						
						 
						if (exn.equals("mp4") && exn.equals("avi")) {
//							System.out.println("안 삭제 exn >> " + exn + " >> " + file.getAbsolutePath());
						}
					
						
					} else {
						System.out.println(file.getAbsolutePath() + " is deleted.");
						file.delete();
					}
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
