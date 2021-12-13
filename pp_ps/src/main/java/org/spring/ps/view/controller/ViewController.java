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


}
