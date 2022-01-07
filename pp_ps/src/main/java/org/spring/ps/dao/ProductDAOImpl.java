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

		String ccode = pagingMap.get("ccode");//
		String ccoderef = pagingMap.get("ccoderef");//
		String openState = pagingMap.get("openState");

		HashMap<String, String> map = new HashMap();

		String addSql1="";
		String addSql2="";
		//카테고리선택 X
		if( ccoderef.equals("") && ccode.equals("") ) {

			addSql1 =" ";
		}
		//상위 카테고리 선택
		if ( !ccoderef.equals("") && ccode.equals("") ) {

			addSql1 =" WHERE tc.ccoderef = "+ccoderef;
		}
		//하위 카테고리 선택
		if(!ccoderef.equals("") && !ccode.equals("") ) {

			addSql1=" WHERE tc.ccoderef = "+ccoderef+" AND tc.ccode="+ccode;
		}
		if(!openState.equals("")) {
			addSql2 = " WHERE tp.pstate = '"+openState+"'";
		}


		String sql = "SELECT COUNT(*) FROM tbl_product AS tp ";
		sql	+= "LEFT JOIN tbl_category AS tc ";
		sql	+="ON tp.pccode = tc.ccode ";
		sql += " "+addSql1+" ";
		sql += " "+addSql2+" ";


		log.debug("************countProduct************");
		log.debug(sql);
		log.debug("*************************************");

		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".countProduct", map);
		return result;
	}


	@Override
	public List<ProductVO> getProductList(PagingVO pagingVO, HashMap<String, String> pagingMap) {

		String ccode = pagingMap.get("ccode");//
		String ccoderef = pagingMap.get("ccoderef");// 
		String openState = pagingMap.get("openState");
		String openSortBy = pagingMap.get("openSortBy");

		HashMap<String, String> map = new HashMap();
		String addSql1="";
		String addSql2 = "";
		String addSql3 = "";
		//카테고리선택 X
		if( ccoderef.equals("") && ccode.equals("") ) {

			addSql1 =" ";
		}
		//상위 카테고리 선택
		if ( !ccoderef.equals("") && ccode.equals("") ) {

			addSql1 =" WHERE tc.ccoderef = "+ccoderef;
		}
		//하위 카테고리 선택
		if(!ccoderef.equals("") && !ccode.equals("") ) {

			addSql1=" WHERE tc.ccoderef = "+ccoderef+" AND tc.ccode="+ccode;
		}

		if(!openState.equals("")) {
			addSql2 = " WHERE tp.pstate = '"+openState+"'";
		}
		switch(openSortBy) {
		//최신순
		case "ORDER_BY_REGDATE_DESC" :
			addSql3	= " ORDER BY tp.pregdate DESC ";
			break;
			//오래된 순
		case "ORDER_BY_REGDATE_ASC" :
			addSql3	= " ORDER BY tp.pregdate ASC ";
			break;
			//비싼 순
		case "ORDER_BY_PPRICE_DESC" :
			addSql3	= " ORDER BY tp.pprice*1 DESC ";
			break;
			//싼 순
		case "ORDER_BY_PPRICE_ASC" :
			addSql3	= " ORDER BY tp.pprice*1 ASC ";
			break;
			//재고 많은 순
		case "ORDER_BY_PCNT_DESC" :
			addSql3	= " ORDER BY tp.pcnt*1 DESC ";
			break;
			//재고 적은 순
		case "ORDER_BY_PCNT_ASC" :
			addSql3	= " ORDER BY tp.pcnt*1 ASC ";
			break;
			//평점 좋은 순
		case "ORDER_BY_PRATING_DESC" :
			addSql3	= " ORDER BY tp.prating DESC ";
			break;
			//평점 안 좋은 순
		case "ORDER_BY_PRATING_ASC" :
			addSql3	= " ORDER BY tp.prating ASC ";
			break;
			//리뷰 많은 순
		case "ORDER_BY_REVIEW_CNT_DESC" :
			addSql3	= " ORDER BY tr.cnt DESC ";
			break;
			//리뷰 적은 순
		case "ORDER_BY_REVIEW_CNT_ASC" :
			addSql3	= " ORDER BY tr.cnt ASC ";
			break;
		default : 
			addSql3	= " ORDER BY tp.pregdate DESC " ;
		}

		String sql= "SELECT * FROM ( SELECT @rownum:=@rownum+1 AS RN,  A.* FROM (SELECT @ROWNUM:=0) as R, ";
		sql += "( SELECT tc.ccoderef pccoderef,tr.cnt AS reviewCnt,tp.pid,tp.pccode,tp.pname,tp.pcnt,tp.pprice,tp.pregdate,tp.pimg,tp.pbrand,tp.prating,tp.psale,tp.pstate ";
		sql += "FROM tbl_product AS tp ";
		sql += "LEFT JOIN tbl_category AS tc ";
		sql += "ON tp.pccode = tc.ccode ";
		sql += "LEFT JOIN ( ";
		sql +="SELECT pid, COUNT(*) AS cnt FROM tbl_review GROUP BY pid ";
		sql += ") AS tr ";
		sql += "ON tr.pid = tp.pid ";
		sql += " "+addSql1+" ";
		sql += " "+addSql2+" ";
		sql += " "+addSql3+" "; 
		sql += ") AS A ";
		sql += ") AS B ";
		sql += "WHERE RN BETWEEN "+pagingVO.getStart()+" AND "+ pagingVO.getEnd();

		log.debug("************getProductList************");
		log.debug(sql);
		log.debug("*************************************");
		map.put("sql", sql);
		List<ProductVO> result = sqlSession.selectList(Namespace+".getProductList", map);
		return result;
	}


	@Override
	public ProductVO getProductOne(String pid) {
		HashMap<String, String> map = new HashMap();

		String sql = "SELECT  A.*,B.ccoderef AS pccoderef FROM tbl_product  AS A ";
		sql +="LEFT JOIN tbl_category AS B ON A.pccode =B.ccode ";
		sql	+="WHERE pid = '"+pid+"'";

		map.put("sql", sql);
		ProductVO result = sqlSession.selectOne(Namespace+".getProductOne", map);		
		return result;
	}


	@Override
	public int stateChange(ProductVO productVO) {
		HashMap<String, String> map = new HashMap();

		String sql = "UPDATE tbl_product SET pstate ='" +productVO.getPstate()+"'";
		sql += " WHERE pid = '"+productVO.getPid()+"'";
		map.put("sql", sql);

		int result = sqlSession.update(Namespace +".stateChange",map);


		return result;
	}

	@Override
	public int productInsert(ProductVO productVO, HashMap<String, String> sql_dirMap) {
		HashMap<String, String> map = new HashMap();

		String sql ="INSERT INTO tbl_product(pid,pname,pbrand,pexplicate,pccode,pcnt,pprice,psale,pimg) ";
		sql+="VALUES( ";
		sql+="'"+productVO.getPid()+"', ";
		sql+="'"+productVO.getPname()+"', ";
		sql+="'"+productVO.getPbrand()+"', ";
		sql+="'"+productVO.getPexplicate()+"', ";
		sql+=productVO.getPccode()+", ";
		sql+=productVO.getPcnt()+", ";
		sql+=productVO.getPprice()+", ";
		sql+=productVO.getPsale()+", ";
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

		String sql ="UPDATE tbl_product set ";
		sql+="pname ='"+productVO.getPname()+"', ";
		sql+="pbrand ='"+productVO.getPbrand()+"', ";
		sql+="pcnt ='"+productVO.getPcnt()+"', ";
		sql+="pprice ="+productVO.getPprice()+", ";
		sql+="pccode ="+productVO.getPccode()+", ";
		sql+="psale ="+productVO.getPsale()+", ";
		sql+="pexplicate ='"+productVO.getPexplicate()+"' ";
		if(sql_dirMap != null) {
			sql+=", pimg =";

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
		String sql ="DELETE FROM tbl_product WHERE pid = '"+pid+"'";

		map.put("sql", sql);
		int result = sqlSession.insert(Namespace +".productDelete",map);
		return result;
	}

	@Override
	public void pcntDecrease(String pid, int cstock) {
		HashMap<String, String> map = new HashMap();
		String sql ="UPDATE tbl_product ";
		sql+= "SET pcnt = pcnt -"+cstock;
		sql += " WHERE pid =  '"+pid+"'";

		map.put("sql", sql);
		sqlSession.update(Namespace +".pcntDecrease",map);

	}
}
