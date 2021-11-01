package org.spring.ps.view.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());

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
			@PathVariable("page") String page
			) {
		
		log.debug("[adminPage] :"+page);
		
		
		return "admin/"+page+".page";
	}
	
	
}
