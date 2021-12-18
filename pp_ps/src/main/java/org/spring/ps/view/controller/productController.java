package org.spring.ps.view.controller;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.ProductService;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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



}
