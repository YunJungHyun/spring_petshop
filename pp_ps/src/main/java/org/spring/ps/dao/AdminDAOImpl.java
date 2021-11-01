package org.spring.ps.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.AdminVO;
import org.springframework.stereotype.Service;

@Service
public class AdminDAOImpl implements AdminDAO{


	@Inject
	private SqlSession sqlSession;
	
	Log log =LogFactory.getLog(this.getClass());
	
	private static final String Namespace = "org.spring.ps.mapper.adminMapper";
	
	@Override
	public int adminIdCheck(String adminid) {
		
		log.debug("[adminIdCheck] : "+adminid);
		
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT COUNT(*) "
					+"FROM admin "
					+"WHERE adminid = '"+adminid+"'";
		
		map.put("sql", sql);
		
		int result = sqlSession.selectOne(Namespace+".adminIdCheck", map);
		return result;
	}
	
	@Override
	public AdminVO adminLogin(String adminid, String adminpw) {
		HashMap<String, String> map =new HashMap();
		
		String sql = "SELECT * FROM admin "
					+ "WHERE adminid ='"+adminid+"' "
					+"AND adminpw = '"+adminpw+"'";
		map.put("sql", sql);
		
		AdminVO result = sqlSession.selectOne(Namespace+".adminLogin", map);
		return result;
	}
}
