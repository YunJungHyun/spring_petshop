package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
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
	
	@Override
	public List<CategoryVO> getBrandCategoryList(String bname) {
		HashMap<String, String> map = new HashMap();
		String sql =" WITH recursive cte AS ( ";
		sql+= " SELECT tc_a.cname, 1 as level, tc_a.ccode,tc_a.ccoderef FROM tbl_category as tc_a ";
		sql+= " INNER JOIN 	( ";
		sql+= " SELECT tc_b.ccoderef FROM tbl_category AS tc_b ";
		sql+= " INNER JOIN (SELECT tp_a.pccode FROM tbl_product AS tp_a WHERE pbrand= '"+bname+"') AS tp_b ";
		sql+= " ON tc_b.ccode = tp_b.pccode ";
		sql+= " GROUP BY tc_b.ccoderef ";
		sql+= " ) AS tc_d ";
		sql+= " ON tc_a.ccode =tc_d.ccoderef ";
		sql+= " WHERE tc_a.ccoderef IS null ";
		sql+= " UNION ALL ";
		sql+= " SELECT b.cname, level +1 ,b.ccode,b.ccoderef FROM tbl_category b ";
		sql+= " INNER JOIN cte AS cte_a ";
		sql+= " ON cte_a.ccode = b.ccoderef ";
		sql+= " INNER JOIN 	( ";
		sql+= " SELECT tc_b.ccode FROM tbl_category AS tc_b ";
		sql+= " INNER JOIN (SELECT tp_a.pccode FROM tbl_product AS tp_a WHERE pbrand= '"+bname+"') AS tp_b ";
		sql+= " ON tc_b.ccode = tp_b.pccode ";
		sql+= " GROUP BY tc_b.ccode ";
		sql+= " ) AS tc_d ";
		sql+= " ON b.ccode =tc_d.ccode ) ";
		sql+= " SELECT * FROM cte ";
		sql+= " ORDER BY ccode ASC ";
	
		map.put("sql", sql);
		
		List<CategoryVO> result = sqlSession.selectList(Namespace+".getBrandCategoryList", map);
		return result;
	}
	

	@Override
	public List<CategoryVO> getCountSubCategoryProduct(String bname) {
		HashMap<String, String> map = new HashMap();
		String sql = "SELECT COUNT(*) AS productCnt ,tp.pccode AS ccode FROM tbl_product AS tp WHERE tp.pbrand ='"+bname+"' AND pstate = 'POSTING' group BY tp.pccode";
		map.put("sql", sql);
		List<CategoryVO> result = sqlSession.selectList(Namespace+".getCountSubCategoryProduct",map);
		return result;
	}
	
	@Override
	public List<CategoryVO> getCountParentCategoryProduct(String bname) {
		HashMap<String, String> map = new HashMap();
		String sql = " SELECT COUNT(*) AS productCnt ,tc.ccoderef FROM tbl_product AS tp  ";
		sql+=" 	INNER JOIN tbl_category AS tc ";
		sql+=" ON tp.pccode = tc.ccode";
		sql+=" WHERE tp.pbrand ='"+bname+"' AND pstate = 'POSTING' group BY tc.ccoderef ";
		
		
		map.put("sql", sql);
		List<CategoryVO> result = sqlSession.selectList(Namespace+".getCountParentCategoryProduct",map);
		return result;
	}
}
