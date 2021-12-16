package org.spring.ps.service;

import java.util.HashMap;

import org.spring.ps.vo.UserVO;


public interface AuthLoginService {

	
	UserVO authJoinInfo(HashMap<String, Object> userInfo) ;
}
