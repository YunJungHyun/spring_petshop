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
	public int countProduct(HashMap<String,String> pagingMap) {

		String openCcode = pagingMap.get("openCcode");//
		String openState = pagingMap.get("openState");
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT COUNT(*) FROM product AS A ";
		sql	+= "LEFT JOIN category AS B ";
		sql	+="ON A.pccode = B.ccode ";
		
		if(openCcode.equals("000")) {

			sql +="";
			if(!openState.equals("allState")) {
				sql+=" WHERE A.state = "+openState;
			}
		}else {
			//상위 카테고리 보기
			if(openCcode.length() >=3 && openCcode.length() <=4) {
				sql+="WHERE B.ccoderef = "+openCcode;
				if(!openState.equals("allState")) {
					sql+=" AND A.state = "+openState;
				}
			//하위 카테고리 보기
			}else if(openCcode.length() > 4) {

				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());

				sql+=" WHERE B.ccoderef = "+ccoderef+" AND B.ccode="+ccode;
				if(!openState.equals("allState")) {
					sql+=" AND A.state = "+openState;
				}
			} 
		}
		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".countProduct", map);
		return result;
	}
	@Override
	public List<ProductVO> getProductList( PagingVO pagingVO ,HashMap<String,String> pagingMap) {

		String openCcode = pagingMap.get("openCcode");//
		String openState = pagingMap.get("openState");
		String openSortBy = pagingMap.get("openSortBy");

		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM ( ";
		sql += "SELECT @rownum:=@rownum+1 AS RN, C.* FROM (SELECT @ROWNUM:=0) as R , ( ";
		sql +=  "SELECT A.pnum,A.pid,A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice,A.pimg,A.pregdate,A.state,A.pbrand FROM product AS A ";
		sql	+= "LEFT JOIN category AS B ";
		sql	+="ON A.pccode = B.ccode ";
		//전체 보기
		if(openCcode.equals("000")) {

			sql +="";
			if(!openState.equals("allState")) {
				sql+=" WHERE A.state = "+openState;
			}
		 
		}else {
			//상위 카테고리 보기
			if(openCcode.length() >=3 && openCcode.length() <=4) {
				sql+="WHERE B.ccoderef = "+openCcode;
				if(!openState.equals("allState")) {
					sql+=" AND A.state = "+openState;
				}
			//하위 카테고리 보기
			}else if(openCcode.length() > 4) {

				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());

				sql+="WHERE B.ccoderef = "+ccoderef+" AND B.ccode="+ccode;
				if(!openState.equals("allState")) {
					sql+=" AND A.state = "+openState;
				}
				
			} 
		}
		switch (openSortBy) {
		
			case "" :
				sql	+= " ORDER BY A.pregdate DESC ";
					break;
			case "ORDER_BY_REGDATE_DESC" :
				sql	+= " ORDER BY A.pregdate DESC ";
				break;
			case "ORDER_BY_REGDATE_ASC" :
				sql	+= " ORDER BY A.pregdate ASC ";
				break;
			case "ORDER_BY_PPRICE_DESC" :
				sql	+= " ORDER BY A.pprice*1 DESC ";
				break;
			case "ORDER_BY_PPRICE_ASC" :
				sql	+= " ORDER BY A.pprice*1 ASC ";
				break;
			case "ORDER_BY_PCNT_DESC" :
				sql	+= " ORDER BY A.pcnt*1 DESC ";
				break;
			case "ORDER_BY_PCNT_ASC" :
				sql	+= " ORDER BY A.pcnt*1 ASC ";
				break;
		}
		
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
