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
	public List<CategoryVO> getCategoryList() {
		// TODO Auto-generated method stub

		HashMap<String,String> map = new HashMap<String, String>();

		String sql ="WITH recursive cte AS (";
		sql+= " SELECT cname, 1 as level, ccode,ccoderef FROM tbl_category WHERE ccoderef IS null ";
		sql+= " UNION all";
		sql+= " SELECT b.cname, level +1 ,b.ccode,b.ccoderef FROM tbl_category b"; 
		sql+= " INNER JOIN cte a" ;
		sql+= " ON a.ccode = b.ccoderef";
		sql+= " )";

		sql+=" SELECT * FROM cte ORDER BY ccode ";

 

		map.put("sql", sql);


		List<CategoryVO> result = sqlSession.selectList(Namespace + ".getCategoryList", map);
		return result;
	}

	@Override
	public int categoryChk(String cname) {

		HashMap<String,String> map = new HashMap<String, String>();

		String sql = "SELECT COUNT(*) FROM tbl_category WHERE cname= '"+cname+"'";

		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".categroyChk", map);

		return result;
	}

	@Override
	public int categoryInsert(int parentCategory, String cname) {
		HashMap<String,String> map = new HashMap<String, String>();

		int maxCategoryCode = parentCategory+99;
		String sql = "INSERT INTO tbl_category(cname,ccode,ccoderef) "
				+ "VALUES('"+cname+"', ( SELECT MAX(ccode + 1) AS ccode FROM category AS a WHERE ccode BETWEEN "+parentCategory+" AND "+maxCategoryCode+" ), "+parentCategory+")";


		map.put("sql", sql);

		int result = sqlSession.insert(Namespace+".categoryInsert", map);
		return result;
	}

	@Override
	public String getCategoryOne(String openCcode) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql = "SELECT cname FROM tbl_category WHERE ccode = "+openCcode;
		map.put("sql", sql);
		
		String result = sqlSession.selectOne(Namespace+".getCategoryOne",map);
		return result;
	}
	
	@Override
	public int insertSubCategory(CategoryVO categoryVO) {
		HashMap<String,String> map = new HashMap<String, String>();
		
				 
				
		String sql = "INSERT INTO tbl_category(cname,ccode,ccoderef) VALUES( ";
			sql+="'"+categoryVO.getCname()+"',(SELECT MAX(ccode) +1 FROM tbl_category AS B ";
			sql+= " WHERE (CASE WHEN ( SELECT COUNT(*) AS cnt FROM tbl_category AS C WHERE ccoderef ="+categoryVO.getCcoderef()+") = 0  ";
			sql+= " THEN ccode ELSE ccoderef END ) =  "+categoryVO.getCcoderef()+")";
			sql+= ", "+categoryVO.getCcoderef()+")";
		map.put("sql", sql);
		
		int result = sqlSession.insert(Namespace+".insertSubCategory",map);
		return result;
	}
	@Override 
	public int insertParentCategory(CategoryVO categoryVO) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql = "INSERT INTO tbl_category(cname,ccode) VALUES( ";
				sql+="'"+categoryVO.getCname()+"',(SELECT MAX(ccode)+100 FROM tbl_category AS B WHERE ccoderef IS NULL))";
		map.put("sql", sql);
		
		int result = sqlSession.insert(Namespace+".insertParentCategory",map);
		return result;
	}
	
	@Override 
	public int deleteSubCategory(int ccode) {
		HashMap<String, String> map = new HashMap();
		String sql ="DELETE FROM tbl_category WHERE ccode = "+ccode;		
		 
		map.put("sql", sql);
		
		int result = sqlSession.delete(Namespace+".deleteSubCategory", map);
		return result;
	}
	
	@Override
	public List<CategoryVO> getNewSaleCategoryList() {
		HashMap<String, String> map = new HashMap();
		
		String sql = " SELECT tc_a.* ,tp_in_tc.productCnt  FROM tbl_category AS tc_a  ";
		sql+=" 	INNER JOIN ( ";
		sql+=" SELECT COUNT(*) AS productCnt, tc_b.* FROM tbl_category as tc_b ";
		sql+=" INNER JOIN ( ";
		sql+=" SELECT * FROM tbl_product AS  tp_a	WHERE tp_a.pregdate BETWEEN DATE_ADD(NOW(),INTERVAL - 1 WEEK) AND NOW() and tp_a.pstate = 'POSTING' AND tp_a.psale <> 0 ";
		sql+=" ) AS tp_b ";
		sql+=" ON tc_b.ccode = tp_b.pccode ";
		sql+=" GROUP BY tc_b.ccoderef ";
		sql+=" ) AS tp_in_tc ";
		sql+="	ON tc_a.ccode = tp_in_tc.ccoderef ";
		
		map.put("sql", sql);
		
		List<CategoryVO> result = sqlSession.selectList(Namespace+".getNewSaleCategoryList", map);
		return result;
	}
}
