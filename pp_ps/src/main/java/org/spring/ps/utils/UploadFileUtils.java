package org.spring.ps.utils;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
	public static HashMap<String,String> calcPath(String uploadPath ,String dirName) {
		 
		

		Calendar cal = Calendar.getInstance(); 
		int year= cal.get(Calendar.YEAR);
		String yearStr = String.valueOf(year);
		String month = new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String date = new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		String yearPath = File.separator + year;
		String monthPath = yearPath + File.separator + month ;
		String datePath = monthPath + File.separator + date;
		String productPath = datePath + File.separator+dirName;
		String img_uploadPath = productPath + File.separator+"cover";
		
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath);
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath , img_uploadPath);
		makeDir(uploadPath, yearPath, monthPath, datePath,productPath , img_uploadPath+ "\\s");
		
		HashMap<String,String> dirMap = new HashMap(); 
		dirMap.put("year", yearStr); // year
		dirMap.put("month", month); // month
		dirMap.put("date", date); //  date
		dirMap.put("product",dirName ); // p_pid
		dirMap.put("img_uploadPath", img_uploadPath); // /year/month/date/p_pid/cover;
			
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