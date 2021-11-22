package org.spring.ps.view.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class productController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping(value="/product/getOneProductInfo" ,method=RequestMethod.POST)
	@ResponseBody
	public void getOneProductInfo() {
		
		
		log.debug("[getOneProductInfo]");
	}

}
