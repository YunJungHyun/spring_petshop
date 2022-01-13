package org.spring.ps.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.BrandService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.vo.BrandVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/brand")
public class BrandController {
	Log log = LogFactory.getLog(this.getClass());

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	private BrandService brandService;
	
	@RequestMapping(value="/{bnum}", method=RequestMethod.GET)
	public String goBrand(
			@PathVariable(value="bnum",required = true) int bnum
			) {
		
		log.debug("[goBrand] : "+bnum);
		
		//BrandVO brandVO = brandService.getOneBrand(bnum);
		// 브랜드 하나에대한 정보를 가져옴
		// 브랜드 이름으로 같은 브랜드의 제품을 가져옴
		// 카테고리랑 조인해서 있는 카테고리만 리스트에 담아서 출력
		
		
		return "";
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public int brandInsert(
			BrandVO brandVO,
			@RequestParam("bimgFile") MultipartFile file
			
			) throws IOException, Exception {
		
		log.debug("[brandInsert] :" +brandVO.toString());
		log.debug("[brandInsert]file :" +file.getOriginalFilename());
		
		String  bname = new String(brandVO.getBname().getBytes("8859_1"),"utf-8");
		String 	originalFilename = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");
		
		String imgUploadPath = uploadPath +File.separator+"brandImgUpload";
		String fileName = null;
		HashMap<String, String> sql_dirMap = new HashMap();
		String path  = null;
		if(file != null) {
			fileName =  UploadFileUtils.brand_fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes()); 
			path = "/brandImgUpload";
			
		}else {
			 
			fileName = "none.png";
			path= "/icon";
			
		}
		
		sql_dirMap.put("path", path);
		sql_dirMap.put("fileName", fileName);
		
		brandVO.setBname(bname);
		
		int result = brandService.brandInsert(brandVO, sql_dirMap);
		
		log.debug("[brandInsert] result:"+result);
		
		return result;
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	@ResponseBody
	public int brandDelete(
			@RequestParam(value = "bnum") String bnum,
			@RequestParam(value = "bimg") String bimg
			) {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(bimg);
		JsonObject img_json = element.getAsJsonObject().get("img").getAsJsonObject();

		String path = img_json.getAsJsonObject().get("path").getAsString();
		String fileName = img_json.getAsJsonObject().get("fileName").getAsString();
		
		File rootDir =  new File(uploadPath+path+"/"+fileName);
		
		if(rootDir.exists()) {
			UploadFileUtils.deleteFilesRecursively(rootDir);
		}
		int result = brandService.brandDelete(bnum);
		
		return result;
	}
}
