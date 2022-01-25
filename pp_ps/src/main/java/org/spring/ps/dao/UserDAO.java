package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.UserVO;

public interface UserDAO {
	
	
	
	UserVO getOneUserInfo(HashMap<String,Object> userInfo) ;

	void authSignUp(HashMap<String,Object> userInfo);

	int userPetShopSignUp(UserVO jsonUserData);

	int petShopIdCheck(String userid);

	UserVO petShopLogin(String userid, String userpw);

	List<UserVO> getUserList(String sortBy, PagingVO pagingVO);

	int countUser();

	UserVO getOneUser(String unum);

	int userInfoUpdate(UserVO userVO);

	String findUserid(UserVO userVO);

	String findUserpw(UserVO userVO);

	int memberInfoUpdate(UserVO userVO);

}
 