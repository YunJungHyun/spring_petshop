package org.spring.ps.view.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.UserService;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import lombok.RequiredArgsConstructor;
import net.sf.json.JSONArray;

@RequiredArgsConstructor
@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());


	@RequestMapping(value="/petshop")
	public String home(
			Model model
			) {


		log.debug("home");  


		String pageTitle = "HOME"; 
		
		model.addAttribute("pageTitle", pageTitle);

		return "home.page"; 
	}
	
	@RequestMapping(value="/login")
	public String userLogin(Model model) {
		
		log.debug("[userLogin]");
		
		String pageTitle = "LOGIN";
		model.addAttribute("pageTitle",pageTitle);
		
		
		return "user/join/login.page";
	}
	@RequestMapping(value="/signUpSort")
	public String signUpSort(Model model) {
		
		log.debug("[signUp]");
		
		String pageTitle = "회원가입유형";
		model.addAttribute("pageTitle",pageTitle);
		
		
		return "user/join/signUpSort.page";
	}
	@RequestMapping(value="/signUp")
	public String signUp(Model model) {
		
		log.debug("[signUp]");
		
		String pageTitle = "PETSHOP 회원가입";
		model.addAttribute("pageTitle",pageTitle);
		
		 
		return "user/join/signUp.page";
	}
	@RequestMapping(value="/signUpAfter")
	public String signUpAfter(Model model) {
		
		log.debug("[signUpAfter]");
		
		String pageTitle = "PETSHOP 회원가입 완료";
		model.addAttribute("pageTitle",pageTitle);
		
		
		return "user/join/signUpAfter.page";
	}

}
