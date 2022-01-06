package org.spring.ps.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.ReviewService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.ReviewDetailVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
@RequestMapping("/product")
public class ProductController {
 
	Log log = LogFactory.getLog(this.getClass());

	@Resource(name="uploadPath")
	private String uploadPath;
	//C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\pp_ps\resources

	@Inject
	private ProductService productService;
	
	@Inject
	private CategoryService categoryService;
	
	@Inject
	private ReviewService reviewService;
	
	@RequestMapping(value="/{pid}", method=RequestMethod.GET)
	public String product(
			Model model,
			@PathVariable("pid") String pid
			) {

		ProductVO pvo = productService.getProductOne(pid);
		
		List<ReviewDetailVO> rList = reviewService.getProdOneReviewList(pid);
		
		//route
		String cnameref = categoryService.getCategoryOne(Integer.toString(pvo.getPccoderef()));
		String cname = categoryService.getCategoryOne(Integer.toString(pvo.getPccode()));
		
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{cnameref,"/category/"+pvo.getPccoderef()},{cname,"/category/"+pvo.getPccoderef()+pvo.getPccode()},{pvo.getPname(),"/product/"+pvo.getPid()}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
		routeMap.put(2,routeArray[2]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);


		model.addAttribute("rList",rList);
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
		productVO.setPstate(state);

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

		String dirName = "p_"+randomStr;


		//디렉토리 생성
		String imgUploadPath = uploadPath + File.separator +"imgUpload"+File.separator+"product";
		HashMap<String,String> dirMap = UploadFileUtils.calcPath(imgUploadPath ,dirName);

		String originalFilename = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");
		//파일 업로드
		String ymdPidImgPath = dirMap.get("img_uploadPath"); 
		String fileName = UploadFileUtils.fileUpload(imgUploadPath, originalFilename, file.getBytes(), ymdPidImgPath);

		//데이터 삽입 준비
		HashMap<String,String> sql_dirMap = new HashMap();
		String path = "/imgUpload/product/"+dirMap.get("year")+"/"+dirMap.get("month")+"/"+dirMap.get("date")+"/"+dirMap.get("product")+"/cover";

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

	@RequestMapping(value= "/update", method=RequestMethod.POST)
	@ResponseBody
	public int productUpdate(
			ProductVO productVO,
			@RequestParam(value="pimgFile" , required =false) MultipartFile file
			) throws Exception {

		String  pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");
		String  pbrand = new String(productVO.getPbrand().getBytes("8859_1"),"utf-8");
		String  pexplicate = new String(productVO.getPexplicate().getBytes("8859_1"),"utf-8");
		String  pimg = new String(productVO.getPimg().getBytes("8859_1"),"utf-8");

		productVO.setPname(pname);
		productVO.setPbrand(pbrand);
		productVO.setPexplicate(pexplicate);
		productVO.setPimg(pimg);

		log.debug("[productUpdate] productVO :" +productVO.toString());
		log.debug("[productUpdate] file :" +file);

		HashMap<String,String> sql_dirMap = new HashMap();

		if(file == null) {

			sql_dirMap= null;

		}else {

			//File file =  new File(uploadPath+)
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(productVO.getPimg());

			JsonObject img_json = element.getAsJsonObject().get("img").getAsJsonObject();

			String path = img_json.getAsJsonObject().get("path").getAsString();
			String fileName = img_json.getAsJsonObject().get("fileName").getAsString();


			File dir_file_1 =  new File(uploadPath+path+ File.separator+fileName);
			File dir_file_2 =  new File(uploadPath+path+ File.separator+"s"+File.separator+"s_"+fileName);

			log.debug(uploadPath+path+ File.separator+fileName);
			log.debug(uploadPath+path+ File.separator+"s"+File.separator+"s_"+fileName);

			boolean f_delete_result = false;
			if (dir_file_1.exists() && dir_file_2.exists()){

				// 파일 삭제 성공시
				if (dir_file_1.delete() &&  dir_file_2.delete()){

					log.debug("파일 삭제 성공");
					f_delete_result =true;

					//파일 삭제 실패시
				}else{
					log.debug("파일 삭제 실패");
				}

				// 지정한 경로에 파일이 존재안하는 경우 
			}else{
				f_delete_result =true;
				log.debug("파일이없습니다.");
			}


			if(f_delete_result ==  true) {

				String originalFilename = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");
				String imgUploadPath = uploadPath + File.separator +"imgUpload"+File.separator+"product";

				HashMap<String,String> dirMap = UploadFileUtils.calcPath(imgUploadPath ,productVO.getPid());
				String ymdPidImgPath = dirMap.get("img_uploadPath"); 

				String New_fileName = UploadFileUtils.fileUpload(imgUploadPath, originalFilename, file.getBytes(), ymdPidImgPath);


				//데이터 삽입 준비

				String New_path = "/imgUpload/product/"+dirMap.get("year")+"/"+dirMap.get("month")+"/"+dirMap.get("date")+"/"+dirMap.get("product")+"/cover";

				sql_dirMap.put("path",New_path);
				sql_dirMap.put("fileName",New_fileName);

			}

		}


		int result = productService.productUpdate(productVO,sql_dirMap);

		return result;

	}

	@RequestMapping(value= "/delete", method=RequestMethod.POST)
	@ResponseBody
	public int productDelete(
			@RequestParam(value = "pid") String pid,
			@RequestParam(value = "pimg") String pimg

			) {

		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(pimg);

		JsonObject img_json = element.getAsJsonObject().get("img").getAsJsonObject();

		String path = img_json.getAsJsonObject().get("path").getAsString();
		String fileName = img_json.getAsJsonObject().get("fileName").getAsString();

		String delete_path = path.replace("cover", "");
		log.debug(delete_path);

		File rootDir =  new File(uploadPath+delete_path);

		if(rootDir.exists()) {
			deleteFilesRecursively(rootDir);
		}

		int reuslt = productService.productDelete(pid);

		return reuslt;
	}

	static boolean deleteFilesRecursively(File rootFile) {
		File[] allFiles = rootFile.listFiles();
		if (allFiles != null) {
			for (File file : allFiles) {
				deleteFilesRecursively(file);
			}
		}
		System.out.println("Remove file: " + rootFile.getPath());
		return rootFile.delete();

	}

}
