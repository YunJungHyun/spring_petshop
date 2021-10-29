package org.spring.ps.service;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.spring.ps.dao.UserDAO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	private UserDAO userDAO;
	
	
	@Override
	public void userPetShopSignUp(JSONObject jsonUserData) {
		userDAO.userPetShopSignUp(jsonUserData);
		
	}

	
	@Override
	public int petShopIdCheck(String userid) {
		// TODO Auto-generated method stub
		return userDAO.petShopIdCheck(userid);
	}
	
	@Override
	public UserVO petShopLogin(String userid, String userpw) {
		// TODO Auto-generated method stub
		return userDAO.petShopLogin(userid,userpw);
	}
}
