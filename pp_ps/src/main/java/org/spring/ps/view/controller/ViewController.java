package org.spring.ps.view.controller;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());

	@RequestMapping(value="/main/petshop.do")
	public String petshopPage() {

		
		log.debug("petshopPage"); 
		
		
		return "main.page"; 
	}
}
