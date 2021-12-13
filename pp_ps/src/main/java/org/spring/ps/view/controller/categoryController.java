package org.spring.ps.view.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.beans.factory.annotation.Required;
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
			@PathVariable("categoryCode") String openCcode,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="sortBy", required= false) String sortBy,
			Model model
			) {
		log.debug("[categoryProduct] openCcode :" +openCcode);
		log.debug("[categoryProduct] page :" +page);
		String pageTitle = "제품";  
		
		model.addAttribute("pageTitle", pageTitle);
		
		List<CategoryVO> cList =categoryService.getCategoryList();
		
		List<ProductVO> pList = productService.getProductList(openCcode);
		
		model.addAttribute("cList",cList);
		model.addAttribute("pList",pList);
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
