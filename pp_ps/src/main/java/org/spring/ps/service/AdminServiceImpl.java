package org.spring.ps.service;

import javax.inject.Inject;

import org.spring.ps.dao.AdminDAO;
import org.spring.ps.vo.AdminVO;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService{

	@Inject
	private AdminDAO adminDAO;

	
	@Override
	public int adminIdCheck(String adminid) {
		// TODO Auto-generated method stub
		
		
		return adminDAO.adminIdCheck(adminid);
	}

	
	@Override
	public AdminVO adminLogin(String adminid, String adminpw) {
		// TODO Auto-generated method stub
		return adminDAO.adminLogin(adminid,adminpw);
	}

}
