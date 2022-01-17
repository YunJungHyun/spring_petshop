package org.spring.ps.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.UserVO;

public interface UserService {
	
	int userPetShopSignUp(UserVO userVO);
	
	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);

	List<UserVO> getUserList(String sortBy, PagingVO pagingVO);

	int countUser();

	UserVO getOneUser(String unum);

	int userInfoUpdate(UserVO userVO,String auth);
}
 