package org.spring.ps.view.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.inject.Inject;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.spring.ps.service.AuthLoginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class naverOauth  {


	final static String CLIENT_ID = "w_mKmFnHbZEQdrndRrv7";
	final static String REDIRECT_URI = "http://localhost:8080/oauth_naver/auth";
	final static String CLIENT_SECRET="4xHK0JoeEA";
	Log log = LogFactory.getLog(this.getClass());


	@Inject
	private AuthLoginService authLoginService;

	private final HttpSession session;
	
	@RequestMapping(value="/oauth_naver/auth")
	public String oauthNaver(
			@RequestParam(value = "code", required = false) String code
			, Model model) throws Exception {

		log.debug("인가 코드 : "+code);
		String access_Token = getAccessToken(code);

		log.debug("access_Token :" +access_Token);

		HashMap<String, Object> userInfo = getUserInfo(access_Token);



		JSONObject jsonUserInfo =  new JSONObject(userInfo);
		log.debug("[oauthNaver] jsonUserInfo :"+ jsonUserInfo.toJSONString());
		jsonUserInfo=authLoginService.authJoinInfo(jsonUserInfo);
		session.setAttribute("userInfo", jsonUserInfo);


		return "redirect:/"; //본인 원하는 경로 설정
	}
	@RequestMapping(value="/oauth_naver/logout")
	public String auth_Logout(
			HttpSession session
			) throws Exception {
		JSONObject userInfo = (JSONObject)session.getAttribute("userInfo"); 
		String access_Token = (String)userInfo.get("access_token");
		
		log.debug("[auth_Logout] :" +userInfo.toJSONString());
		log.debug("[auth_Logout] :" +access_Token);
		
		naver_logout(access_Token);
		
		session.removeAttribute("userInfo");
		return "redirect:/"; //본인 원하는 경로 설정
	}

	private String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL ="https://nid.naver.com/oauth2.0/token";

		try {
			URL url = new URL(reqURL);

			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();


			//  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			//	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id="+CLIENT_ID);  //본인이 발급받은 key
			sb.append("&client_secret="+CLIENT_SECRET);  //본인이 발급받은 key
			sb.append("&redirect_uri="+REDIRECT_URI);     // 본인이 설정해 놓은 경로
			sb.append("&code=" + authorize_code);

			bw.write(sb.toString());
			bw.flush();

			//    결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			log.debug("responseCode : " + responseCode);

			//    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("[getAccessToken]response body : " + result);

			//    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			//log.debug("access_token : " + access_Token);
			log.debug("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return access_Token;
	}


	//유저정보조회
	public HashMap<String, Object> getUserInfo (String access_Token) {

		//    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			//    요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			log.debug("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("[getUserInfo]response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();

			String id ="n_";
			id += response.getAsJsonObject().get("id").getAsString();
			String name = response.getAsJsonObject().get("name").getAsString();
			String email = response.getAsJsonObject().get("email").getAsString();

			userInfo.put("userid", id);
			userInfo.put("username", name); 
			userInfo.put("useremail", email);
			
			userInfo.put("access_token", access_Token);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}

	private void naver_logout(String access_Token) {
		 String reqURL = "https://nid.naver.com/oauth2.0/token";
         try {
             URL url = new URL(reqURL);
             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
             //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
 			conn.setRequestMethod("POST");
 			conn.setDoOutput(true);

 			//	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
 			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 			StringBuilder sb = new StringBuilder();
 			sb.append("grant_type=delete");
 			sb.append("&client_id="+CLIENT_ID);  //본인이 발급받은 key
 			sb.append("&client_secret="+CLIENT_SECRET);  //본인이 발급받은 key
 			sb.append("&access_token="+access_Token);     // 본인이 설정해 놓은 경로
 			sb.append("&service_provider=NAVER");

 			bw.write(sb.toString());
 			bw.flush();

 			//    결과 코드가 200이라면 성공
 			int responseCode = conn.getResponseCode();
 			log.debug("responseCode : " + responseCode);

             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

             String result = "";
             String line = "";

             while ((line = br.readLine()) != null) {
                 result += line;
             }
             System.out.println(result);
         } catch (IOException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }
		
	}

}
