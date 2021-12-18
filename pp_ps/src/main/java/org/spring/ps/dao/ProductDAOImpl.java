package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

@Service
public class ProductDAOImpl implements ProductDAO{

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.productMapper";


	@Override
	public int countProduct(String openCcode) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT COUNT(*) FROM product AS A ";
		sql	+= "LEFT JOIN category AS B ";
		sql	+="ON A.pccode = B.ccode ";
		
		if(openCcode.equals("000")) {

			sql +="";
		
		}else {
			//상위 카테고리 보기
			if(openCcode.length() >=3 && openCcode.length() <=4) {
				sql+="WHERE B.ccoderef = "+openCcode;
			//하위 카테고리 보기
			}else if(openCcode.length() > 4) {

				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());

				sql+=" WHERE B.ccoderef = "+ccoderef+" AND B.ccode="+ccode;
			} 
		}
		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".countProduct", map);
		return result;
	}
	@Override
	public List<ProductVO> getProductList(String openCcode, PagingVO pagingVO) {



		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM ( ";
		sql += "SELECT @rownum:=@rownum+1 AS RN, C.* FROM (SELECT @ROWNUM:=0) as R , ( ";
		sql +=  "SELECT A.pnum,A.pid,A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice,A.pimg,A.pregdate,A.state,A.pbrand FROM product AS A ";
		sql	+= "LEFT JOIN category AS B ";
		sql	+="ON A.pccode = B.ccode ";
		//전체 보기
		if(openCcode.equals("000")) {

			sql +="";
		 
		}else {
			//상위 카테고리 보기
			if(openCcode.length() >=3 && openCcode.length() <=4) {
				sql+="WHERE B.ccoderef = "+openCcode;
			//하위 카테고리 보기
			}else if(openCcode.length() > 4) {

				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());

				sql+="WHERE B.ccoderef = "+ccoderef+" AND B.ccode="+ccode;
			} 
		}
		sql	+= " ORDER BY A.pregdate DESC ";
		sql += ") AS C ";
		sql += ") AS D WHERE RN BETWEEN "+pagingVO.getStart()+" AND "+ pagingVO.getEnd();
		map.put("sql", sql);
		List<ProductVO> result = sqlSession.selectList(Namespace+".getProductList", map);
		return result;
	}

	
	@Override
	public ProductVO getProductOne(String pid) {
		HashMap<String, String> map = new HashMap();

		String sql = "SELECT  A.* FROM product  AS A ";
		sql +="LEFT JOIN category AS B ON A.pccode =B.ccode ";
		sql	+="WHERE pid = '"+pid+"'";

		map.put("sql", sql);
		ProductVO result = sqlSession.selectOne(Namespace+".getProductOne", map);		
		return result;
	}


}
