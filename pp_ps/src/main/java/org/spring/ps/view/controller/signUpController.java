package org.spring.ps.view.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@RequestMapping(value="/auth")
public class signUpController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping(value = "/{signUpType}")
	public String intro( @PathVariable("signUpType") String signUpType) throws Exception{
		
		String reqUrl ="";
		log.debug("signUpType : "+signUpType);
		switch(signUpType) {
		
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
