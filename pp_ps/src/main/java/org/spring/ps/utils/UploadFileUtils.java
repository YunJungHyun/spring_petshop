package org.spring.ps.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

import net.coobird.thumbnailator.Thumbnails;

public class UploadFileUtils {

	static final int THUMB_WIDTH = 250;
	static final int THUMB_HEIGHT = 250;

	public static String fileUpload(String uploadPath,
			String fileName,
			byte[] fileData, String ymdPath) throws Exception {

		UUID uid = UUID.randomUUID();

		String newFileName = uid + "_" + fileName;
		String imgPath = uploadPath + ymdPath;

		File target = new File(imgPath, newFileName);
		FileCopyUtils.copy(fileData, target);

		String thumbFileName = "s_" + newFileName;
		File image = new File(imgPath + File.separator + newFileName);

		File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);

		if (image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		}
		return newFileName;
	}
	
	public static String ex_fileUpload(String uploadPath,
			String fileName,
			byte[] fileData, String ymdPath) throws Exception {
		
		UUID uid = UUID.randomUUID();
		
		String newFileName = uid + "_" + fileName;
		String imgPath = uploadPath + ymdPath;
		
		File target = new File(imgPath, newFileName);
		FileCopyUtils.copy(fileData, target);
		
		String thumbFileName = "s_" + newFileName;
		File image = new File(imgPath + File.separator + newFileName);
		
		File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);
		
		if (image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
		}
		return newFileName;
	}
	
	
	// 디렉토리 생성
	public static HashMap<String,String> calcPath(String uploadPath , int pnum) {
		
		Calendar cal = Calendar.getInstance(); 
		int year= cal.get(Calendar.YEAR);
		String yearStr = String.valueOf(year);
		String month = new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String date = new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		String yearPath = File.separator + year;
		String monthPath = yearPath + File.separator + month ;
		String datePath = monthPath + File.separator + date;
		String productPath = datePath + File.separator+"product_code_"+ pnum;
		String img_uploadPath = productPath + File.separator+"cover";
		String ex_img_uploadPath = productPath + File.separator+"explicate";
		
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath);
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath , img_uploadPath);
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath , img_uploadPath+ "\\s");
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath + "\\explicate");
		
		HashMap<String,String> dirMap = new HashMap(); 
		dirMap.put("year", yearStr);
		dirMap.put("month", month);
		dirMap.put("date", date);
		dirMap.put("product", "product_code_"+ pnum);
		dirMap.put("img_uploadPath", img_uploadPath);
		dirMap.put("ex_img_uploadPath", ex_img_uploadPath);
		
		return dirMap;
	}
	
	private static void makeDir(String uploadPath, String... paths) {

		if (new File(paths[paths.length - 1]).exists()) { return; }

		for (String path : paths) {
			File dirPath = new File(uploadPath + path);

			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}