package org.spring.ps.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "org.spring.ps.mapper.userMapper";
	
	@Override
	public UserVO getOneUserInfo(String userid) {
		
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM user WHERE userid = '"+userid+"'";
		
		


		map.put("sql", sql);
		
		UserVO result  = sqlSession.selectOne(Namespace+".getOneUserInfo", map);
		
		
		return null;
		
		
		
	}
	
	
}
