package org.spring.ps.service;

import org.json.simple.JSONObject;
import org.spring.ps.vo.UserVO;

public interface UserService {
	
	int userPetShopSignUp(JSONObject jsonUserData);
	
	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);
}
 