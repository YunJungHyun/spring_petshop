package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.CategoryVO;
import org.springframework.stereotype.Service;

@Service
public class CategoryDAOImpl implements CategoryDAO{

	
	
	@Inject
	private SqlSession sqlSession;
	
	Log log =LogFactory.getLog(this.getClass());
	
	private static final String Namespace = "org.spring.ps.mapper.categoryMapper";
	
	
	@Override
	public int categoryInsert(Map<String, Object> categoryData) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "INSERT INTO category(cname, ctype, csort) "
				+ "VALUES('"+categoryData.get("cname")+"','"+categoryData.get("ctype")+"','"+categoryData.get("csort")+"')";
		
		map.put("sql", sql);
		
		int result = sqlSession.insert(Namespace+".categoryInsert", map);
		return result;
	}
	
	@Override
	public List<CategoryVO> categoryList() {
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM category";
		
		map.put("sql", sql);
		
		List<CategoryVO> result = sqlSession.selectList(Namespace+".categoryList", map);
		return result;
	}
}
