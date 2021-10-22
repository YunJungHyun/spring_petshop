package org.spring.ps.view.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/join")
public class JoinController {

	Log log = LogFactory.getLog(this.getClass());
	
	// oauth_join
	@RequestMapping(value = "/getAuthUrl/{oauth_sort}")
	public @ResponseBody String getKakaoAuthUrl(
			HttpServletRequest request,
			@PathVariable("oauth_sort") String oauth_sort) throws Exception {
		
		log.debug("oauth_sort :" +oauth_sort);
		
		String REQ_URL ="";
		String CLIENT_ID = "";
		String CLIENT_SECRET ="";
		String REDIRECT_URI ="";
		String RESPONSE_TYPE = "code";
		String SESSION_STATE ="oauth_state";
		
		if(oauth_sort.equals("kakao_join")) {
			 
			CLIENT_ID = "9539c2a2417f7ade53f95908a382dd70";
			REDIRECT_URI ="http://localhost:8080/oauth_kakao/auth";
			
			REQ_URL ="https://kauth.kakao.com/oauth/authorize"
				+ "?client_id="+CLIENT_ID
				+ "&redirect_uri="+REDIRECT_URI
				+ "&response_type="+RESPONSE_TYPE;
			
			
		}else {
			
			CLIENT_ID ="w_mKmFnHbZEQdrndRrv7";
			CLIENT_SECRET="4xHK0JoeEA";
			REDIRECT_URI ="http://localhost:8080/oauth_naver/auth";
			
			REQ_URL ="https://nid.naver.com/oauth2.0/authorize"
					+ "?client_id="+CLIENT_ID
					+ "&client_secret="+CLIENT_SECRET
					+ "&redirect_uri="+REDIRECT_URI
					+ "&response_type="+RESPONSE_TYPE;
			
		}
		log.debug("REQ_URL :" +REQ_URL);
		return REQ_URL; //본인 원하는 경로 설정
	}




}
