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
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.spring.ps.service.AuthLoginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class kakaoOauth {

	final static String CLIENT_ID = "9539c2a2417f7ade53f95908a382dd70";
	final static String REDIRECT_URI = "http://localhost:8080/oauth_kakao/auth";
	
	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private AuthLoginService authLoginService;
 
	private final HttpSession session;
	
	@RequestMapping(value="/oauth_kakao/auth")
	public String oauthKakao(
			@RequestParam(value = "code", required = false) String code
			, Model model
			) throws Exception {

		log.debug("인가 코드 : "+code);
		String access_Token = getAccessToken(code);
		log.debug("access_Token#### : " + access_Token);


		HashMap<String, Object> userInfo = getUserInfo(access_Token);
	
		JSONObject jsonUserInfo =  new JSONObject(userInfo);
		
		
		jsonUserInfo =authLoginService.authJoinInfo(jsonUserInfo);
		
		log.debug("[oauthKakao] jsonUserInfo :"+ jsonUserInfo.toJSONString());
		session.setAttribute("userInfo", jsonUserInfo);
	
		return "redirect:/"; //본인 원하는 경로 설정
	}
	
	@RequestMapping(value="/oauth_kakao/logout")
	public String auth_Logout(
			HttpSession session
			) throws Exception {
		JSONObject userInfo = (JSONObject)session.getAttribute("userInfo"); 
		String access_Token = (String)userInfo.get("access_token");
		
		kakao_logout(access_Token);
		
		session.removeAttribute("userInfo");
		
		return "redirect:/"; //본인 원하는 경로 설정
	}
	
	 //토큰발급
		public String getAccessToken (String authorize_code) {
	        String access_Token = "";
	        String refresh_Token = "";
	        String reqURL = "https://kauth.kakao.com/oauth/token";

	        try {
	            URL url = new URL(reqURL);

	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);

	            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id="+CLIENT_ID);  //본인이 발급받은 key
	            sb.append("&redirect_uri="+REDIRECT_URI);     // 본인이 설정해 놓은 경로
	            sb.append("&code=" + authorize_code);
	            
	            //log.debug("sb.toString() :" +sb.toString());
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

	            log.debug("access_token : " + access_Token);
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
	        String reqURL = "https://kapi.kakao.com/v2/user/me";
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

	            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	            String id = "k_";
	            String name = properties.getAsJsonObject().get("nickname").getAsString();
	            String email = kakao_account.getAsJsonObject().get("email").getAsString();
	            id += element.getAsJsonObject().get("id").getAsString();
	            
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
	    
	    
	    public void kakao_logout(String access_Token) throws IOException {
	    	 String reqURL = "https://kapi.kakao.com/v1/user/logout";
	         try {
	             URL url = new URL(reqURL);
	             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	             conn.setRequestMethod("POST");
	             conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	             int responseCode = conn.getResponseCode();
	             System.out.println("responseCode : " + responseCode);

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
