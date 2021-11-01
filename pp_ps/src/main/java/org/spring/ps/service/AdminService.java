package org.spring.ps.service;

import org.spring.ps.vo.AdminVO;

public interface AdminService {

	int adminIdCheck(String userid);

	AdminVO adminLogin(String adminid, String adminpw);
	
	

}
