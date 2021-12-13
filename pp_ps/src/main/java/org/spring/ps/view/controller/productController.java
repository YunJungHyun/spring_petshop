package org.spring.ps.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.vo.ProductVO;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/product")
public class productController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name="uploadPath")
	private String uploadPath;

	@Inject
	private ProductService productService;
	
	@RequestMapping(value="/admin/update", method=RequestMethod.POST)
	@ResponseBody
	public int productUpdate(
			ProductVO productVO,
			@RequestParam(value="pimgFile", required = false) MultipartFile file,
			@RequestParam(value="path") String path,
			@RequestParam(value="fileName") String fileName
			) throws IOException, Exception { 
		
		String pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");
		
		productVO.setPname(pname);
		
		log.debug("[productVO] uploadPath : "+uploadPath);
		log.debug("[productVO] path : "+path);// /resources/imgUpload/product/y/m/d/product~
		//log.debug("[productVO] rePath : "+rePath);
		
		log.debug("[productVO] file : "+file);
		log.debug("[productVO] fileName : "+fileName);
		
		
		if(file != null) {
			
			String rePath=path.substring(10, path.length()); // /imgUpload/product/y/m/d/product~
			String ymdPath = path.substring(28,path.length());// /y/m/d/product~
			
			//파일 삭제
			String existing_file_location = uploadPath + rePath +File.separator+fileName;
			String existing_file_location_s = uploadPath + rePath +File.separator+"s"+File.separator+"s_"+fileName;

			new File(existing_file_location).delete();
			new File(existing_file_location_s).delete();
			
			
			//파일 생성
			String imgUploadPath = uploadPath +File.separator + "imgUpload" + File.separator +"product";
			//C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\pp_ps\resources\imgUpload\product
			log.debug("[productInsert] imgUploadPath :"+imgUploadPath);
			
			HashMap<String, String> dir_div = UploadFileUtils.calcPath(imgUploadPath, productVO.getPnum());
			
			
			//새로 생긴 파일이름 가져오기
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
		
		}
		
		int updateResult =productService.productUpdate(productVO,path,fileName);
		
		return updateResult;
		
	}

	@RequestMapping(value="/admin/insert" ,method=RequestMethod.POST)
	@ResponseBody
	public int productInsert(
			ProductVO productVO,
			@RequestParam("pimgFile") MultipartFile file) throws IOException, Exception {

		String pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");

		// pid생성
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		Random random = new Random();

		String generatedString = random.ints(leftLimit,rightLimit + 1)
		  .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		  .limit(targetStringLength)
		  .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		  .toString();
		
		String pid = "p"+productVO.getPccode()+"_"+generatedString;
		
		
		productVO.setPid(pid);
		productVO.setPname(pname);
		
		int pnum = productService.productInsert(productVO);
		
		String imgUploadPath = uploadPath +File.separator + "imgUpload" + File.separator +"product";
		//C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\pp_ps\resources\imgUpload\product
		log.debug("[productInsert] imgUploadPath :"+imgUploadPath);
		
		HashMap<String, String> dir_div = UploadFileUtils.calcPath(imgUploadPath, pnum);
		//\2021\11\30\product_code_26\cover
		log.debug("[productInsert] dir_div.get(\"img_uploadPath\") :"+dir_div.get("img_uploadPath"));
		
		String ymdPath  = dir_div.get("img_uploadPath");
		
		String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		
		String imgPath = "/resources/imgUpload/product/"+dir_div.get("year")+"/"+dir_div.get("month")+"/"+dir_div.get("date")+"/"+dir_div.get("product")+"/cover";
		
		int updateResult =productService.productRegUpdate(pnum,imgPath,fileName);
		return updateResult;

	}

}
