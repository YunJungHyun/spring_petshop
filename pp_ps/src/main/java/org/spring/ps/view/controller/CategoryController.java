package org.spring.ps.view.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/category")
public class CategoryController {


	Log log = LogFactory.getLog(this.getClass());

	@Inject
	private CategoryService categoryService;
	@Inject
	private ProductService productService;

	
	
	@RequestMapping(value ="/insert", method=RequestMethod.POST)
	@ResponseBody
	public  int insert(
			CategoryVO categoryVO,
			@RequestParam(value="sort" ) String sort
			) { 
		
		log.debug("[insert] :" + categoryVO.toString());
		log.debug("[insert] sort :" + sort);
		
		int result = 0;
		if(sort.equals("sub")) {
			
			result =categoryService.insertSubCategory(categoryVO);
		}
		
		if(sort.equals("parent")) {
			
			result =categoryService.insertParentCategory(categoryVO);
			
		}
		
		return result;
	}
	@RequestMapping(value ="/getCategoryList", method=RequestMethod.POST)
	@ResponseBody
	public List<CategoryVO> getCategoryList() { 

		List<CategoryVO> categoryList =categoryService.getCategoryList();
		log.debug("[getCategoryList] categoryList.size() :" +categoryList.size());
		return categoryList;
	}
	
	@RequestMapping(value="/findRemainProduct", method = RequestMethod.POST)
	@ResponseBody
	public int findRemainProduct(
			@RequestParam(value="ccode", required = false) int ccode
			){
		
		
		log.debug("[findRemainProduct] ccode: "+ccode);
		int result = productService.findRemainProduct(ccode);
		
		return result;
		
	}
	@RequestMapping(value="/deleteSubCategory", method = RequestMethod.POST)
	@ResponseBody
	public int deleteSubCategory(
			@RequestParam(value="ccode", required = false) int ccode
			){
		
		
		log.debug("[deleteSubCategory] ccode: "+ccode);
		int result = categoryService.deleteSubCategory(ccode);
		
		return result;
		
	}
	

	@RequestMapping(value="/{openCcode}", method=RequestMethod.GET)
	public String categoryProduct(
			PagingVO pagingVO,
			@PathVariable("openCcode") String openCcode,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="sortBy", required= false) String sortBy,
			Model model
			) {
		List<PageInfoVO> breadcrumbList =null;
		Map<Integer,String[]> routeMap = new HashMap<>();
		HashMap<String,String> map = new HashMap();
		
		String mapCcode = "";
		String mapCcoderef ="";
		if(sortBy == null ) {

			sortBy = "";
		}  
		if(page == null ) {

			page = "1";
		} 

		//route
		if(openCcode.equals("000")) {
			//route
			String routeArray[][] = {{"??????","/category/000"}};
			routeMap.put(0,routeArray[0]);
			breadcrumbList =routeUtils.pageInfo(routeMap);
			mapCcode = "";
			mapCcoderef = "";
		}else {
			//?????? ???????????? ??????
			if(openCcode.length() >=3 && openCcode.length() <=4) {

				String cname = categoryService.getCategoryOne(openCcode);
				//route
				String routeArray[][] = {{cname,"/category/"+openCcode}};
				routeMap.put(0,routeArray[0]);

				breadcrumbList =routeUtils.pageInfo(routeMap);
				
				mapCcode = "";
				mapCcoderef= openCcode;
				//?????? ???????????? ??????
			}else if(openCcode.length() > 4) {

				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());


				String cnameref = categoryService.getCategoryOne(ccoderef);
				String cname = categoryService.getCategoryOne(ccode);
				//route	
				String routeArray[][] = {{cnameref,"/category/"+ccoderef},{cname,"/category/"+openCcode}};
				routeMap.put(0,routeArray[0]);
				routeMap.put(1,routeArray[1]);

				breadcrumbList =routeUtils.pageInfo(routeMap);
				
				mapCcode = ccode;
				mapCcoderef= ccoderef;
			} 
		}


		map.put("ccode",mapCcode);
		map.put("ccoderef",mapCcoderef);
		map.put("openSortBy",sortBy);
		map.put("openState","POSTING");
		int total = productService.countProduct(map);

		pagingVO = new PagingVO(total , Integer.parseInt(page), 8 );
		log.debug("[categoryProduct] total "+openCcode+" :"+total);
		log.debug("[categoryProduct] start/ end "+pagingVO.getStart()+" :"+pagingVO.getEnd());

		List<CategoryVO> cList =categoryService.getCategoryList();

		List<ProductVO> pList = productService.getProductList(pagingVO,map);

		log.debug("[categoryProduct] pList.size() :"+pList.size());

		String pageTitle = "??????";  

		model.addAttribute("breadcrumb",breadcrumbList);
		model.addAttribute("pageTitle", pageTitle);
		model.addAttribute("pTotal", total);
		model.addAttribute("cList",cList);
		model.addAttribute("pList",pList);
		model.addAttribute("paging",pagingVO);

		model.addAttribute("openCcode",openCcode);
		model.addAttribute("openSortBy",sortBy);
		return "user/product/productList.page"; 

	}

	


}
