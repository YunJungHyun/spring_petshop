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
		
		log.debug(userVO);
		//return jsonUserInfo ;
	}
}
