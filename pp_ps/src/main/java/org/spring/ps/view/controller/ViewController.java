package org.spring.ps.view.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import net.sf.json.JSONArray;

@RequiredArgsConstructor
@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());


	@Inject
	private CategoryService categoryService;
	@Inject
	private ProductService productService;

	@RequestMapping(value="/main/petshop")
	public String home(
			Model model
			) {


		log.debug("home");  


		String pageTitle = "HOME"; 

		model.addAttribute("pageTitle", pageTitle);

		return "main.page"; 
	}


	@RequestMapping(value="/user/signUpSort")
	public String joinsort(
			Model model
			) {


		log.debug("signUpSort"); 

		String pageTitle = "회원가입 유형"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/signUpSort.page"; 
	}

	@RequestMapping(value="/user/signUpPage")
	public String join(
			Model model
			) {

		log.debug("signUpPage"); 

		String pageTitle = "회원가입"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/signUpPetShop.page"; 
	}

	@RequestMapping(value="/user/joinInPage")
	public String joinIn(
			Model model
			) {

		log.debug("joinInPage"); 

		String pageTitle = "로그인"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/joinIn.page"; 
	}

	@RequestMapping(value="/admin/loginPage")
	public String adminLoginPage(
			Model model
			) {

		log.debug("adminLoginPage"); 

		String pageTitle = "관리자 로그인"; 

		model.addAttribute("page" , "admin");
		model.addAttribute("pageTitle", pageTitle);

		return "admin/adminLogin.page"; 
	}




	@RequestMapping(value="/admin/managementPage")
	public String adminManageMentPage(
			Model model
			) {

		log.debug("[adminManageMentPage]"); 

		String pageTitle = "관리자 페이지"; 

		model.addAttribute("page" , "admin");
		model.addAttribute("pageTitle", pageTitle);

		return "admin/adminManagement.page"; 
	}



	@RequestMapping(value="/admin/go/{page}")
	public String adminPage(
			@PathVariable("page") String page,
			Model model
			) {

		log.debug("[adminPage] :"+page);
		String pageTitle = null; 
		switch(page) {

		case "prodListPage" : 

			pageTitle = "제품 목록";
			
			List<ProductVO> prodListPage_pList = productService.productBaseList();
			List<CategoryVO> prodListPage_cList = categoryService.getCategoryList();
			page = "product/"+page;
			
			//log.debug("[adminPage] prodListPage pList:"+prodListPage_pList.size());
			
			model.addAttribute("pList",JSONArray.fromObject(prodListPage_pList));
			model.addAttribute("cList",JSONArray.fromObject(prodListPage_cList));
			
			break;
		case "productInsertPage" : 

			pageTitle = "제품 등록"; 
			
			List<CategoryVO> cList = categoryService.getCategoryList();
			model.addAttribute("cList",JSONArray.fromObject(cList));
			page = "product/"+page;
			break;


		}
		model.addAttribute("pageTitle" , pageTitle);
		model.addAttribute("page" , "admin");

		return "admin/"+page+".page";
	}


}
