package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.BrandVO;
import org.springframework.stereotype.Service;

@Service
public class BrandDAOImpl implements BrandDAO{

	

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.brandMapper";
	
	@Override
	public List<BrandVO> getBrandList() {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql ="SELECT * FROM tbl_brand ORDER BY bnum DESC";
		map.put("sql",sql);
		List<BrandVO> result = sqlSession.selectList(Namespace+".getBrandList",map);
		return result;
	}
	
	@Override
	public int brandInsert(BrandVO brandVO, HashMap<String, String> sql_dirMap) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql ="INSERT INTO tbl_brand(bname,bimg) VALUES ('"+brandVO.getBname()+"',";
			sql+= "JSON_OBJECT('img', ";
			sql+= "JSON_OBJECT( 'path','"+sql_dirMap.get("path")+"','fileName','"+sql_dirMap.get("fileName")+"')))";
	
			map.put("sql",sql);
			int result = sqlSession.insert(Namespace+".brandInsert",map);
			
		return result;
	}
	
	@Override
	public int brandDelete(String bnum) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql ="DELETE FROM tbl_brand WHERE bnum ="+bnum;
		map.put("sql",sql);
		int result =sqlSession.delete(Namespace+".brandDelete", map);
		return result;
	}
}
