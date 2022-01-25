package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.spring.ps.dao.UserDAO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	private UserDAO userDAO;
	
	
	@Override
	public int userPetShopSignUp(UserVO userVO) {
		
		return userDAO.userPetShopSignUp(userVO);
		 
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
	
	@Override
	public List<UserVO> getUserList(String sortBy ,PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return userDAO.getUserList(sortBy,pagingVO);
	}
	@Override
	public int countUser() {
		// TODO Auto-generated method stub
		return userDAO.countUser();
	}
	
	@Override
	public UserVO getOneUser(String unum) {
		// TODO Auto-generated method stub
		return userDAO.getOneUser(unum);
	}
	@Override
	public int userInfoUpdate(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.userInfoUpdate(userVO);
	}
	
	@Override
	public String findUserid(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.findUserid(userVO);
	}
	@Override
	public String findUserpw(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.findUserpw(userVO);
	}
	@Override
	public int memberInfoUpdate(UserVO userVO) {
		// TODO Auto-generated method stub
		return userDAO.memberInfoUpdate(userVO);
	}
}
