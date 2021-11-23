package org.spring.ps.view.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/product")
public class productController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	@ResponseBody
	public void productInsert(
			ProductVO productVO,
			@RequestParam("article_file") List<MultipartFile> multipartFile) {
		
		log.debug("[productInsert] productVO.toString() :" + productVO.toString());
		log.debug("[productInsert] multipartFile.size() :" + multipartFile.size());
	}

}
