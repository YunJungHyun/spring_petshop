package org.spring.ps.view.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.vo.CategoryVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class categoryController {

	
	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private CategoryService categoryService;
	
	@RequestMapping(value="/categoryInsert")
	@ResponseBody
	public int categoryInsert(@RequestParam Map<String, Object> categoryData) {
		
		log.debug(categoryData.toString());
		
		int result=categoryService.categoryInsert(categoryData);
		
		return result;
	}
	
	@RequestMapping(value="/categoryList")
	@ResponseBody
	public List<CategoryVO> categoryList() {
		
		log.debug("[categoryList]");
		
		List<CategoryVO> categoryList = categoryService.categoryList();
		log.debug(categoryList.toString());
		
		return categoryList;
	}
	
	
	@RequestMapping(value="/categoryUpdate")
	@ResponseBody
	public int categoryList(
			CategoryVO categoryVO
			) {
		
		log.debug("[categoryUpdate]");
	
		int result = categoryService.categoryUpdate(categoryVO);
	
		log.debug("result : "+result);
		return result;
	}
	
	
}
