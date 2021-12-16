package org.spring.ps.view.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.spring.ps.service.AdminService;
import org.spring.ps.service.UserService;
import org.spring.ps.vo.AdminVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/join")
public class JoinController {

	Log log = LogFactory.getLog(this.getClass());

	@Inject
	private UserService userService;
	
	@Inject
	private AdminService adminService;

	private final HttpSession session;

	// oauth_join
	@RequestMapping(value = "/getAuthUrl/{oauth_sort}")
	@ResponseBody
	public String getKakaoAuthUrl(
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

	@RequestMapping(value="/petShop/login")
	@ResponseBody
	public String petShopLogin(
			@RequestParam(value="userid") String userid,
			@RequestParam(value="userpw") String userpw,
			HttpServletRequest request
			) {


		log.debug("[petShopLogin] input userid ,userpw : "+userid+","+userpw);
		String loginResult = "";
		int idResult= userService.petShopIdCheck(userid);
		
		HttpSession session = request.getSession();
		
		
		if(idResult >= 1) {
			
			//비밀번호 체크
			UserVO userVO = userService.petShopLogin(userid, userpw);
			
			if(userVO == null) {
				
				loginResult="pwFail";
				session.setAttribute("userInfo", null);
			
			}else {
				
				session.setAttribute("userInfo", userVO);
				loginResult ="success";
			}
		}else {
			
			session.setAttribute("userInfo", null);
			loginResult = "idFail";
		}
		
		log.debug("[petShopLogin] : "+ loginResult);

		return loginResult;
	}
	

	@RequestMapping(value="/logout")
	public String logout_sort(

			HttpSession session
			) {


		UserVO userInfo =(UserVO)session.getAttribute("userInfo"); 
		if(userInfo == null) {
			
			return "redirect:/";
		}else { 
			log.debug("userInfo.toString() :" +userInfo.toString());
			String utype =(String) userInfo.getUtype();
			
			
			if(utype.equals("ps")) {
			
				session.removeAttribute("userInfo");
			}else if(utype.equals("kakao")) {
			
				return "redirect:/oauth_kakao/logout";
			}else if(utype.equals("naver")) {
			
			
				return "redirect:/oauth_naver/logout";
			 
			}
		}
		
		return "redirect:/";
	}

	
	
	@RequestMapping(value="/idCheck")
	@ResponseBody
	public int petShopIdChk(
			@RequestParam(value="userid") String userid
			) {


		log.debug("[petShopIdChk] input userid : "+userid);

		int result= userService.petShopIdCheck(userid);
		log.debug("[petShopIdChk] input result : "+result+" 결과가 1이라면 중복");
		return result;
	}

	
	@RequestMapping(value="/signUp")
	@ResponseBody
	public String signUp(
			UserVO userVO,
			HttpServletRequest request
			) {
 
		
		log.debug("[signUp] userVO : "+userVO.toString());

		int result = userService.userPetShopSignUp(userVO);
		HttpSession session = request.getSession();
		
		String resultStr = "";
		if(result == 1) {
			resultStr ="success";
			UserVO userInfo = userService.petShopLogin(userVO.getUserid(), userVO.getUserpw());
			session.setAttribute("userInfo", userVO);
		
		}else {
			resultStr ="fail";
			session.setAttribute("userInfo", null);
		}
		return resultStr;
	}

	
}
