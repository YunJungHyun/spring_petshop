package org.spring.ps.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	//C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\pp_ps\resources

	@Inject
	private ProductService productService;
	
	@RequestMapping(value="/{pid}", method=RequestMethod.GET)
	public String product(
			Model model,
			@PathVariable("pid") String pid
			) {
		
		ProductVO pvo = productService.getProductOne(pid);
		model.addAttribute("pvo",pvo);
		String pageTitle = pvo.getPname();  
		model.addAttribute("pageTitle", pageTitle);
		
		return "user/product/product.page";
	}
	@RequestMapping(value="/admin/stateChange")
	@ResponseBody
	public int  stateChange(
		
			@RequestParam(value="pid" , required = true) String pid,
			@RequestParam(value="state" , required = true) String state
			) {
		
		log.debug("[stateChange] productVO: "+ pid+"/"+state);
		ProductVO productVO =new ProductVO();
		productVO.setPid(pid);
		productVO.setState(Integer.parseInt(state));
		
		int result = productService.stateChange(productVO);
		
		return result;
		
	}

	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public int productInsert(
			ProductVO productVO,
			@RequestParam("pimgFile") MultipartFile file
			) throws IOException, Exception {
		
		//폴더이름 생성
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		Random random = new Random();

		String randomStr = random.ints(leftLimit,rightLimit + 1)
		  .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
		  .limit(targetStringLength)
		  .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
		  .toString();
		
		String dirName = "p"+productVO.getPccode()+"_"+randomStr;
		
		
		//디렉토리 생성
		String imgUploadPath = uploadPath + File.separator +"imgUpload"+File.separator+"product";
		HashMap<String,String> dirMap = UploadFileUtils.calcPath(imgUploadPath ,dirName);
		
		String originalFilename = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");
		//파일 업로드
		String ymdPidImgPath = dirMap.get("img_uploadPath"); 
		String fileName = UploadFileUtils.fileUpload(imgUploadPath, originalFilename, file.getBytes(), ymdPidImgPath);
		
		//데이터 삽입 준비
		HashMap<String,String> sql_dirMap = new HashMap();
		String path = "/resources/imgUpload/product/"+dirMap.get("year")+"/"+dirMap.get("month")+"/"+dirMap.get("date")+"/"+dirMap.get("product")+"/cover";
		
		sql_dirMap.put("path",path);
		sql_dirMap.put("fileName",fileName);
		
		
		String  pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");
		String  pbrand = new String(productVO.getPbrand().getBytes("8859_1"),"utf-8");
		String  pexplicate = new String(productVO.getPexplicate().getBytes("8859_1"),"utf-8");
		
		productVO.setPid(dirName);
		productVO.setPname(pname);
		productVO.setPbrand(pbrand);
		productVO.setPexplicate(pexplicate);
		
		//데이터확인
		log.debug("[productInsert] path:" +path);
		log.debug("[productInsert] fileName:" +fileName);
		log.debug("[productInsert] productVO.toString() :"+productVO.toString());
		
		int result = productService.productInsert(productVO,sql_dirMap);
		
		log.debug("[productInsert] result: "+result+" insert success");
		 
		
		return result;
	}

}
