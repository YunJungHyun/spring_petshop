package org.spring.ps.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.LikeVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class LikeDAOImpl implements LikeDAO{

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.likeMapper";
	@Override
	public int likeCheck(LikeVO likeVO) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		String sql = "SELECT COUNT(*) FROM tbl_like WHERE userid='"+likeVO.getUserid()+"' AND pid='"+likeVO.getPid()+"'";
		map.put("sql",sql);
		
		int result = sqlSession.selectOne(Namespace+".likeCheck",map);
		return result;
	}
	
	@Override
	public int likeInsert(LikeVO likeVO) {
		HashMap<String, String> map = new HashMap<String, String>();
		String sql = "INSERT INTO tbl_like(userid,pid) VALUES('"+likeVO.getUserid()+"','"+likeVO.getPid()+"')";
		map.put("sql",sql);
		
		int result = sqlSession.insert(Namespace+".likeInsert",map);
		return result;
	}
	
	@Override
	public int likeDelete(LikeVO likeVO) {
		HashMap<String, String> map = new HashMap<String, String>();
		String sql = "DELETE FROM tbl_like WHERE pid = '"+likeVO.getPid()+"' AND userid='"+likeVO.getUserid()+"'";
		map.put("sql",sql);
		
		int result = sqlSession.delete(Namespace+".likeDelete",map);
		return result;
	}
	
	@Override
	public int getMyLikeCnt(UserVO userVO) {
		HashMap<String, String> map = new HashMap<String, String>();
		String sql = "SELECT COUNT(*) FROM tbl_like ";
				sql+= " WHERE userid='"+userVO.getUserid()+"'";
		map.put("sql",sql);
		
		int result = sqlSession.selectOne(Namespace+".getMyLikeCnt",map);
		return result;
	}
}
