package org.spring.ps.view.controller;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class fileUploadController {
	
	
	Log log = LogFactory.getLog(this.getClass());

	
	@RequestMapping(value="/editor/image")
	public void editorImage(@RequestParam Map<String, Object> map, MultipartHttpServletRequest request) throws Exception{
	
		
	}
}
