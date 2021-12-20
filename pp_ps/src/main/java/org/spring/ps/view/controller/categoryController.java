package org.spring.ps.view.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/category")
public class categoryController {

	
	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private CategoryService categoryService;
	@Inject
	private ProductService productService;
	
	
	@RequestMapping(value ="/getCategoryList", method=RequestMethod.POST)
	@ResponseBody
	public List<CategoryVO> getCategoryList() { 
		
		List<CategoryVO> categoryList =categoryService.getCategoryList();
		log.debug("[getCategoryList] categoryList.size() :" +categoryList.size());
		return categoryList;
	}
	
	@RequestMapping(value="/{categoryCode}", method=RequestMethod.GET)
	public String categoryProduct(
			PagingVO pagingVO,
			@PathVariable("categoryCode") String openCcode,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="sortBy", required= false) String sortBy,
			Model model
			) {
		
		HashMap<String,String> map = new HashMap();
		
		if(sortBy == null ) {
			
			sortBy = "";
		} 
		
		
		map.put("openCcode",openCcode);
		map.put("openSortBy",sortBy);
		map.put("openState","0");
		 
		if(page == null ) {
			
			page = "1";
		} 
		
		int total = productService.countProduct(map);
		
		pagingVO = new PagingVO(total , Integer.parseInt(page), 8 );
		log.debug("[categoryProduct] total "+openCcode+" :"+total);
		log.debug("[categoryProduct] start/ end "+pagingVO.getStart()+" :"+pagingVO.getEnd());
		
		List<CategoryVO> cList =categoryService.getCategoryList();
		
		List<ProductVO> pList = productService.getProductList(pagingVO,map);
		
		log.debug("[categoryProduct] pList.size() :"+pList.size());
	
		String pageTitle = "제품";  
		model.addAttribute("pageTitle", pageTitle);
		model.addAttribute("pTotal", total);
		model.addAttribute("cList",cList);
		model.addAttribute("pList",pList);
		model.addAttribute("paging",pagingVO);
		
		model.addAttribute("openCcode",openCcode);
		return "user/product/productList.page"; 
		
	}
	
	

	@RequestMapping(value= "/admin/categoryInsert", method=RequestMethod.POST)
	@ResponseBody
	public String categoryInsert(
			@RequestParam(value="parentCategory") int parentCategory,
			@RequestParam(value="cname") String cname
			
			) {
		
		int categoryChk = categoryService.categoryChk(cname);
		
		String message = "";
		
		if(categoryChk >=1) {
			
			log.debug("[categoryInsert] categoryChk :" +categoryChk);
			message = "chkFalse";
		
		}else {
			log.debug("[categoryInsert] 입력 카테고리 이름 :" +parentCategory);
			log.debug("[categoryInsert] 입력 대분류 :" +cname);
			
			
			int insertResult = categoryService.categoryInsert(parentCategory ,cname);
			
			log.debug("[categoryInsert] insertResult :" +insertResult);
			
			if(insertResult >=1 ) {
				
				message = "categoryInsertSuccess";
			}else {
				
				message = "categoryInsertFail";
			}
			
		}
		
		
		log.debug("[categoryInsert] message :" +message);
		
		return message;
	}
}
