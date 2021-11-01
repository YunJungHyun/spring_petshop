package org.spring.ps.dao;

import org.spring.ps.vo.AdminVO;

public interface AdminDAO {
	
	

	public int adminIdCheck(String adminid);

	public AdminVO adminLogin(String adminid, String adminpw);

}
