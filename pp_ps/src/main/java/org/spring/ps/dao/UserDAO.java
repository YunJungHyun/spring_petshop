package org.spring.ps.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.UserVO;

public interface UserDAO {
	
	
	
	UserVO getOneUserInfo(String userid) ;

	void authSignUp(JSONObject jsonUserInfo);

	int userPetShopSignUp(JSONObject jsonUserData);

	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);

	List<UserVO> getUserList();

}
