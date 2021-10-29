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
import org.spring.ps.service.UserService;
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

	private final HttpSession session;

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



	@RequestMapping(value="/logout")
	public String logout_sort(

			HttpSession session
			) {


		JSONObject userInfo = (JSONObject)session.getAttribute("userInfo"); 
		log.debug("userInfo.toJSONString() :" +userInfo.toJSONString());
		String userid =(String) userInfo.get("userid");

		if(userid.contains("k_")) {



			return "redirect:/oauth_kakao/logout";

		}else if(userid.contains("n_")) {


			return "redirect:/oauth_naver/logout";

		}else {


			session.removeAttribute("userInfo");

		}
		return "redirect:/";
	}


	@RequestMapping(value="/petShop" , method=RequestMethod.POST)
	@ResponseBody
	public void join_petShop (@RequestParam Map<String, Object> userData) {



		JSONObject jsonUserData = new JSONObject();
		JSONObject jsonPetData = new JSONObject();
		Map<String,Object> map_PetData= new HashedMap();

		log.debug("[join_petShop] Map<String, Object> userData : "+userData.toString());
		for(Map.Entry<String, Object> entry : userData.entrySet()) {

			log.debug("key : "+entry.getKey()+" / value : "+entry.getValue());

			if(entry.getKey().contains("pet[")) {
				map_PetData.put(entry.getKey(), entry.getValue());

			}else {

				jsonUserData.put(entry.getKey(), entry.getValue());
			}
		}
		if(map_PetData.size() >=1) {
			for(int i = 1 ; i <= map_PetData.size()/4 ; i++) {

				String pet_info_number = "pet_info_"+i;

				HashMap<String, Object > pet_info_one = new HashMap<String, Object >();

				for(Map.Entry<String, Object> entry : map_PetData.entrySet()) {

					if(entry.getKey().contains(pet_info_number)) {
						log.debug(i+" [map_PetData] key : "+entry.getKey()+" / value : "+entry.getValue());

						if(entry.getKey().contains("pet_name")) {
							pet_info_one.put("pet_name", entry.getValue());
						}else if(entry.getKey().contains("pet_sort")) {
							pet_info_one.put("pet_sort", entry.getValue());

						}else if(entry.getKey().contains("pet_birth")) {
							pet_info_one.put("pet_birth", entry.getValue());

						}else if(entry.getKey().contains("pet_gender")) {
							pet_info_one.put("pet_gender", entry.getValue());

						}
					}
				}

				//log.debug(i+"pet_info_one.toString() :"+pet_info_one.toString());

				jsonPetData.put(pet_info_number, pet_info_one);
			}

			jsonUserData.put("pet", jsonPetData);

		}else {

			jsonUserData.put("pet", "none");
		}
		log.debug(jsonPetData);
		log.debug(jsonUserData);

		userService.userPetShopSignUp(jsonUserData);

	}

	@RequestMapping(value="/petShop/idCheck")
	@ResponseBody
	public int petShopIdChk(
			@RequestParam(value="userid") String userid
			) {


		log.debug("[petShopIdChk] input userid : "+userid);

		int result= userService.petShopIdCheck(userid);
		log.debug("[petShopIdChk] input result : "+result+" 결과가 1이라면 중복");
		return result;
	}
	@RequestMapping(value="/petShop/login")
	@ResponseBody
	public String petShopLogin(
			@RequestParam(value="userid") String userid,
			@RequestParam(value="userpw") String userpw
			) {


		log.debug("[petShopLogin] input userid ,userpw : "+userid+","+userpw);
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		int resultCnt1= userService.petShopIdCheck(userid);

		String resultStr= "";
		if(resultCnt1 >=1 ) {

			log.debug("[petShopLogin] : 아이디가 존재함" );
			//resultStr ="idFound";
			UserVO userVO= userService.petShopLogin(userid,userpw);

			if(userVO == null) {

				log.debug("[petShopLogin] : 비밀번호가 틀림" );

				resultStr ="pwError";
			}else{

				log.debug("[petShopLogin] : 로그인 성공" );
				userInfo.put("userid", userVO.getUserid());
				userInfo.put("username", userVO.getUsername());
				userInfo.put("uaddress", userVO.getUadress());
				userInfo.put("user_pet_info", userVO.getUser_pet_info());

				JSONObject jsonUserInfo =  new JSONObject(userInfo);

				//log.debug(userInfo.toString());
				//log.debug(jsonUserInfo.toJSONString());
				session.setAttribute("userInfo", jsonUserInfo);
				resultStr="loginSuccess";
			}


		}else {


			log.debug("[petShopLogin] : 아이디가 존재 하지않음");
			resultStr ="idNotFound";
		}



		return resultStr;
	}

}
