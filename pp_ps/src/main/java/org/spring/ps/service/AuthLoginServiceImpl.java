package org.spring.ps.service;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.dao.UserDAO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class AuthLoginServiceImpl implements AuthLoginService {

	Log log =LogFactory.getLog(this.getClass());
	
	
	@Inject
	UserDAO userDAO;
	
	@Override
	public UserVO authJoinInfo(HashMap<String,Object> userInfo) {
		

		
		String userid = (String)userInfo.get("userid");
		String utype = (String)userInfo.get("utype");
		
		
		UserVO userVO= userDAO.getOneUserInfo(userInfo);
		
		if(userVO  == null) {
			log.debug("[userVO] : 회원정보가 없습니다....");
			userDAO.authSignUp(userInfo);
			 
			userVO =userDAO.getOneUserInfo(userInfo);
			 
			log.debug("[userVO] : "+userVO.toString()+" 회원정보가 생겼습니다....");
		
		}else {
			
			log.debug("[userVO] : "+userVO.toString()+"이미 등록된 회원 정보가 있습니다.");
			
			
		}
		//return jsonUserInfo ;
		
		return userVO;
	}
	
	
}
