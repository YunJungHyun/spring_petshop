package org.spring.ps.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.BrandService;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.BrandVO;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
	
	@Inject
	private ProductService productService;
	@Inject
	private CategoryService categoryService;
	
	@RequestMapping(value="/{bnum}", method=RequestMethod.GET)
	public String goBrand(
			@PathVariable(value="bnum",required = true) int bnum,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="parent",required = false) String parentCode,
			@RequestParam(value="sort",required = false) String sort,
			@RequestParam(value="categoryCode",required = false) String categoryCode,
			@RequestParam(value="orderBy",required = false) String orderBy,
			PagingVO pagingVO,
			Model model
			) {
		String selectCategory = "";
		String selectSort = "";
		String selectParent = "";
		String cname = categoryService.getCategoryOne(categoryCode);
		
		if(orderBy == null) {
			
			orderBy="";
		}
		if(page == null ) {
			
			page="1";
			
		}
		HashMap<String,String> sortMap = new HashMap<String, String>();
		// 브랜드 하나에대한 정보를 가져옴
		BrandVO brandVO = brandService.getOneBrand(bnum);
		
		if(sort == null) {
			
			sortMap.put("sort","");
			sortMap.put("categoryCode", "");
			selectSort ="";
			selectCategory = "";
			parentCode ="";
			
					
		}else {
			selectSort = sort;
			selectCategory = categoryCode;	
			
			sortMap.put("sort",sort);
			
			if(sort.equals("all")) {
				selectParent =categoryCode;

				categoryCode = categoryCode.substring(0, categoryCode.length() -2);
				sortMap.put("categoryCode", categoryCode);
			
			}
			if(sort.equals("sub")) {
				selectParent =parentCode;
				
				sortMap.put("categoryCode", categoryCode);
			}
		}
		
		sortMap.put("bname",brandVO.getBname());
		sortMap.put("orderBy",orderBy);
		
		int total = productService.countBrandProduct(sortMap);
		
		pagingVO = new PagingVO(total , Integer.parseInt(page), 10 );
		
		log.debug("[goBrand] : "+bnum);
		
		// 브랜드 이름으로 같은 브랜드의 제품을 가져옴
		List<ProductVO> pList = productService.getBrandProductList(sortMap,pagingVO);
		// 카테고리랑 조인해서 있는 카테고리만 리스트에 담아서 출력
		List<CategoryVO> cList = categoryService.getBrandCategoryList(brandVO.getBname());
		
		//부모카테고리별 갯수
		List<CategoryVO> pparentCntList = categoryService.getCountParentCategoryProduct(brandVO.getBname());
		Gson gson_parent = new GsonBuilder().create();
		String pparentCntJSON = gson_parent.toJson(pparentCntList);
		
		//서브카테고리별 갯수
		List<CategoryVO> psubCntList = categoryService.getCountSubCategoryProduct(brandVO.getBname());
		Gson gson_sub = new GsonBuilder().create();
		String psubCntJSON = gson_sub.toJson(psubCntList);
		//카테고리 하나의 정보
		
		String pageTitle= brandVO.getBname();
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"브랜드","/product/view/brand"},{brandVO.getBname(),"/brand/"+bnum}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
		
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);
		
		
		model.addAttribute("pTotal",total);
		model.addAttribute("cname",cname);
		model.addAttribute("selectOrderBy",orderBy);
		model.addAttribute("selectParent",selectParent);
		model.addAttribute("selectSort",selectSort);
		model.addAttribute("selectCategory",selectCategory);
		model.addAttribute("pparentCntJSON", pparentCntJSON);
		model.addAttribute("psubCntJSON", psubCntJSON);
		model.addAttribute("bvo", brandVO);
		model.addAttribute("pList", pList);
		model.addAttribute("cList", cList);
		model.addAttribute("pageTitle",pageTitle);
		model.addAttribute("breadcrumb",breadcrumbList);
		
		return "user/product/listView/brandDetail.page";
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
