package org.spring.ps.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.UserVO;

public interface UserService {
	
	int userPetShopSignUp(JSONObject jsonUserData);
	
	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);

	List<UserVO> getUserList();
}
 