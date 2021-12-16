package org.spring.ps.view.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/auth")
public class authJoinController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping(value = "/{type}")
	public String intro( @PathVariable("type") String type) throws Exception{
		
		String reqUrl ="";
		log.debug("type : "+type);
		switch(type) {
		
			case "kakao":
				
				reqUrl = "https://kauth.kakao.com/oauth/authorize"
						+ "?client_id=9539c2a2417f7ade53f95908a382dd70"
						+ "&redirect_uri=http://localhost:8080/join/oauth_kakao"
						+ "&response_type=code";
				
				break;
			case "naver":	
				
				reqUrl = "https://nid.naver.com/oauth2.0/authorize"
						+ "?client_id=w_mKmFnHbZEQdrndRrv7"
						+ "&client_secret=4xHK0JoeEA"
						+ "&redirect_uri=http://localhost:8080/auth/oauth_naver"
						+ "&response_type=code";
				break;	
		}
		
		
		return "redirect:"+reqUrl;

	}
	

	
		
	   
}
