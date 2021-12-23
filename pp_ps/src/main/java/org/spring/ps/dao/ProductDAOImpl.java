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

	
	@Override
	public int stateChange(ProductVO productVO) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "UPDATE product SET state =" +productVO.getState();
				sql += " WHERE pid = '"+productVO.getPid()+"'";
		map.put("sql", sql);
		
		int result = sqlSession.update(Namespace +".stateChange",map);
		
		
		return result;
	}
	
	@Override
	public int productInsert(ProductVO productVO, HashMap<String, String> sql_dirMap) {
		HashMap<String, String> map = new HashMap();
		
		String sql ="INSERT INTO product(pid,pname,pbrand,pcnt,pprice,pexplicate,pccode,pimg) ";
		sql+="VALUES( ";
		sql+="'"+productVO.getPid()+"', ";
		sql+="'"+productVO.getPname()+"', ";
		sql+="'"+productVO.getPbrand()+"', ";
		sql+="'"+productVO.getPcnt()+"', ";
		sql+="'"+productVO.getPprice()+"', ";
		sql+="'"+productVO.getPexplicate()+"', ";
		sql+="'"+productVO.getPccode()+"', ";
		sql+="JSON_OBJECT('img', ";
			sql+="JSON_OBJECT('path','"+sql_dirMap.get("path")+"','fileName','"+sql_dirMap.get("fileName")+"')";
		sql+="))";
		
		map.put("sql", sql);
		
		int result = sqlSession.insert(Namespace +".productInsert",map);
		return result;
	}

	
	@Override
	public int productUpdate(ProductVO productVO, HashMap<String, String> sql_dirMap) {
		HashMap<String, String> map = new HashMap();
		
		String sql ="UPDATE product set ";
		sql+="pname ='"+productVO.getPname()+"', ";
		sql+="pbrand ='"+productVO.getPbrand()+"', ";
		sql+="pcnt ='"+productVO.getPcnt()+"', ";
		sql+="pprice ='"+productVO.getPprice()+"', ";
		sql+="pccode ="+productVO.getPccode()+", ";
		sql+="pexplicate ='"+productVO.getPexplicate()+"', ";
		if(sql_dirMap != null) {
		sql+="pimg =";
	
		sql+="JSON_OBJECT('img', ";
			sql+="JSON_OBJECT('path','"+sql_dirMap.get("path")+"','fileName','"+sql_dirMap.get("fileName")+"')";
		sql+=") ";
		
		}
		sql+="WHERE pid = '"+productVO.getPid()+"'";
		map.put("sql", sql);
		
		int result = sqlSession.insert(Namespace +".productUpdate",map);
		return result;
	}
	
	@Override
	public int productDelete(String pid) {
		HashMap<String, String> map = new HashMap();
		String sql ="DELETE FROM product WHERE pid = '"+pid+"'";

		map.put("sql", sql);
		int result = sqlSession.insert(Namespace +".productDelete",map);
		return result;
	}
}
