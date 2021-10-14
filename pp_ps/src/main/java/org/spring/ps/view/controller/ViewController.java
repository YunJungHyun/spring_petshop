package org.spring.ps.view.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());

	@RequestMapping(value="/main/petshop.do")
	public String home(
			Model model
			) {

		
		log.debug("home"); 
		
		String pageTitle = "HOME"; 
		
		model.addAttribute("pageTitle", pageTitle);
		
		return "main.page"; 
	}
	
	
	@RequestMapping(value="/user/join.do")
	public String join(
			Model model
			) {

		
		log.debug("join.do"); 
		
		String pageTitle = "JOIN"; 
		
		model.addAttribute("pageTitle", pageTitle);
		
		return "user/join.page"; 
	}
}
