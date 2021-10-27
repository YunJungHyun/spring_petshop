package org.spring.ps.service;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.spring.ps.dao.UserDAO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class AuthLoginServiceImpl implements AuthLoginService {

	Log log =LogFactory.getLog(this.getClass());
	
	
	@Inject
	UserDAO userDAO;
	
	@Override
	public void authJoinInfo(JSONObject jsonUserInfo) {
		

		
		String userid = (String)jsonUserInfo.get("id");
		

		
		UserVO userVO= userDAO.getOneUserInfo(userid);
		
		if(userVO  == null) {
			log.debug("[userVO] : 회원정보가 없습니다....");
			userDAO.authSignUp(jsonUserInfo);
			userVO =userDAO.getOneUserInfo(userid);
			
			log.debug("[userVO] : "+userVO.toString()+" 회원정보가 생겼습니다....");
		}else {
			
			log.debug("[userVO] : "+userVO.toString()+"이미 등록된 회원 정보가 있습니다.");
			
		}
		//return jsonUserInfo ;
	}
	
	
}
