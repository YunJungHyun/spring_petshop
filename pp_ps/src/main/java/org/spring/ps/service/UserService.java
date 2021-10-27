package org.spring.ps.service;

import org.json.simple.JSONObject;

public interface UserService {
	
	void userPetShopSignUp(JSONObject jsonUserData);
	
	int petShopIdCheck(String userid);
}
