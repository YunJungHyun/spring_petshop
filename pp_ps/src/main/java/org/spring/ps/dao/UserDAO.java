package org.spring.ps.dao;

import org.json.simple.JSONObject;
import org.spring.ps.vo.UserVO;

public interface UserDAO {
	
	
	
	UserVO getOneUserInfo(String userid) ;

	void authSignUp(JSONObject jsonUserInfo);

	void userPetShopSignUp(JSONObject jsonUserData);

	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);

}
