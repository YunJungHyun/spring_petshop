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
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/product")
public class productController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name="uploadPath")
	private String uploadPath;

	@Inject
	private ProductService productService;

	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	@ResponseBody
	public int productInsert(
			ProductVO productVO,
			@RequestParam("article_file") List<MultipartFile> multipartFile) throws IOException, Exception {

		String pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");
		String img_fileName_arr_str =  new String(productVO.getImg_fileName_arr_str().getBytes("8859_1"),"utf-8");
		String explicateHead = new String(productVO.getExplicateHead().getBytes("8859_1"),"utf-8");
		String explicateBody = new String(productVO.getExplicateBody().getBytes("8859_1"),"utf-8");
		String explicateFooterLeft = new String(productVO.getExplicateFooterLeft().getBytes("8859_1"),"utf-8");
		String explicateFooterRight = new String(productVO.getExplicateFooterRight().getBytes("8859_1"),"utf-8");

		log.debug("[productInsert] : img_fileName_arr_str" +img_fileName_arr_str);
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
		int pnum = productService.productBaseInsert(productVO);

		String img_uploadPath =uploadPath + File.separator + "imgUpload"+ File.separator +"product";
		String ck_uploadPath =uploadPath + File.separator + "ckUpload";
		
		
		
		//날짜 디렉토리 생성
		HashMap<String,String> dirMap = UploadFileUtils.calcPath(img_uploadPath,pnum);
		String ymdPath = dirMap.get("img_uploadPath");
		String ex_ymdPath = dirMap.get("ex_img_uploadPath");
		
		log.debug("[img_uploadPath] :"+img_uploadPath);
		//C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\pp_ps\resources\imgUpload\product
		log.debug("[ymdPath] :"+ymdPath);
		//\2021\11\24\product_code_87\slide
		log.debug("[ex_ymdPath] :"+ex_ymdPath);
		//\2021\11\24\product_code_87\explicate
		
		//explicate src 수정
		String ex_ymdPath_src = "/resources/imgUpload/product/"+dirMap.get("year")+"/"+dirMap.get("month")+"/"+dirMap.get("date")+"/"+dirMap.get("product")+"/";
		
		if(!img_fileName_arr_str.equals("")) {
			
			String[] img_fileName_arr = img_fileName_arr_str.split("/");
			
			for(int i = 0 ; i <img_fileName_arr.length ; i++) {
				String srcFile = ck_uploadPath+File.separator+img_fileName_arr[i];
				String dstFile = img_uploadPath+ex_ymdPath+File.separator+img_fileName_arr[i];
			
				log.debug("[productInsert] srcFile:" +srcFile);
				log.debug("[productInsert] dstFile:" +dstFile);
				
				File src = new File(srcFile);
				File dst = new File(dstFile);
				      
				try {
				   FileUtils.moveFile(src, dst);
				}
				catch (Exception e) {
				   e.printStackTrace();
				}
			}
			
		}
		if(explicateHead.indexOf("/resources/ckUpload/") >-1) {
			
			explicateHead = explicateHead.replaceAll("/resources/ckUpload/", ex_ymdPath_src);
		}

		if(explicateBody.indexOf("/resources/ckUpload/") >-1) {
			explicateBody = explicateBody.replaceAll("/resources/ckUpload/", ex_ymdPath_src);
		}

		if(explicateFooterLeft.indexOf("/resources/ckUpload/")  >-1) {
			explicateFooterLeft = explicateFooterLeft.replaceAll("/resources/ckUpload/", ex_ymdPath_src);
		}

		if(explicateFooterRight.indexOf("/resources/ckUpload/")  >-1) {
			explicateFooterLeft = explicateFooterLeft.replaceAll("/resources/ckUpload/", ex_ymdPath_src);
		}



		productVO.setExplicateHead(explicateHead);
		productVO.setExplicateBody(explicateBody);
		productVO.setExplicateFooterLeft(explicateFooterLeft);
		productVO.setExplicateFooterRight(explicateFooterRight);


		//log.debug("[productInsert] productVO.toString() :"+productVO.toString());
		//log.debug("[productInsert] multipartFile.size() :"+multipartFile.size());


		String head= productVO.getExplicateHead();
		String body =productVO.getExplicateBody();
		String footerLeft= productVO.getExplicateFooterLeft();
		String footerRight =productVO.getExplicateFooterRight();

		JSONObject ex_obj = new JSONObject();
		JSONObject ex_obj_inner = new JSONObject();

		ex_obj_inner.put("head", productVO.getExplicateHead());
		ex_obj_inner.put("body", productVO.getExplicateBody());
		ex_obj_inner.put("footerLeft", productVO.getExplicateFooterLeft());
		ex_obj_inner.put("footerRight", productVO.getExplicateFooterRight());

		ex_obj.put("explicate",ex_obj_inner);

		log.debug("[productInsert] explicateJSONObj.toString():"+ ex_obj.toString());

		String explicate =ex_obj.toString();
				
				
		JSONObject jsonObject = new JSONObject();
		JSONObject imgDirJSONObject = new JSONObject();

		jsonObject.put("pnum", pnum);
		
		for(int i = 0 ; i < multipartFile.size();i++) {

			//저장된 파일 이름
			String fileName = UploadFileUtils.fileUpload(img_uploadPath, multipartFile.get(i).getOriginalFilename(), multipartFile.get(i).getBytes(), ymdPath);
			log.debug("[productInsert] fileName: "+fileName);
			JSONObject imgDirInfoJSONObject = new JSONObject();

			imgDirInfoJSONObject.put("year", dirMap.get("year"));
			imgDirInfoJSONObject.put("month", dirMap.get("month"));
			imgDirInfoJSONObject.put("date", dirMap.get("date"));
			imgDirInfoJSONObject.put("product", dirMap.get("product"));
			imgDirInfoJSONObject.put("fileName", fileName);
			imgDirInfoJSONObject.put("s_fileName", "s_"+fileName);

			int imgNumber = i +1;
			imgDirJSONObject.put("slideImg_"+imgNumber, imgDirInfoJSONObject);
		}
		
		jsonObject.put("imgDir", imgDirJSONObject);
		log.debug("[productInsert] jsonObject.toJSONString: "+jsonObject.toJSONString());
		log.debug("[productInsert] jsonObject.toString: "+jsonObject.toString());

		int productRemainderUpdateResult = productService.productRemainderUpdate(jsonObject,explicate , pnum);

		
		return productRemainderUpdateResult;

	}

}
