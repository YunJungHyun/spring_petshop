package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.CartVO;
import org.springframework.stereotype.Service;

@Service
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.cartMapper";
	@Override
	public int cartCheck(CartVO cartVO) {
		HashMap<String, String> map = new HashMap();
		String sql = "SELECT COUNT(*) FROM tbl_cart ";
			sql+= "WHERE userid = '"+cartVO.getUserid()+"' ";
			sql+= "AND pid = '"+cartVO.getPid()+"'";
			
		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".cartCheck",map);
		return result;
	}
	@Override
	public int addCart(CartVO cartVO) {

		HashMap<String, String> map = new HashMap();

		String sql = "INSERT INTO tbl_cart(userid,pid,cstock) ";
		sql += "VALUES('"+cartVO.getUserid()+"',";
		sql += "'"+cartVO.getPid()+"',";
		sql += "'"+cartVO.getCstock()+"')";

		map.put("sql", sql);

		int result = sqlSession.insert(Namespace+".addCart",map);
		return result;
	}

	@Override
	public List<CartListVO> getCartList(String userid) {
		HashMap<String, String> map = new HashMap();

		String sql = "SELECT @rownum:=@rownum+1 AS RN, C.* FROM(SELECT @ROWNUM:=0) AS R,(	";
		sql+= "SELECT c.cnum, c.userid, c.pid, c.cstock, c.addDate, p.pname, p.pprice, p.pimg ,p.psale FROM tbl_cart AS c ";
		sql += "INNER JOIN tbl_product AS p ";
		sql += "ON c.pid = p.pid ";
		sql += "WHERE c.userid ='"+userid+"') AS C";


		map.put("sql", sql);

		List<CartListVO> result =sqlSession.selectList(Namespace+".getCartList",map);
		return result;
	}

	@Override
	public int cartDelete(CartVO cartVO) {

		HashMap<String,String > map = new HashMap();

		String sql = "DELETE FROM tbl_cart ";
		sql +=  "WHERE userid = '"+cartVO.getUserid()+"' ";
		sql += "AND pid =  '"+cartVO.getPid()+"'";
		
		map.put("sql",sql);
		int result = sqlSession.delete(Namespace+".cartDelete",map);
		
		return result;
	}
	
	@Override
	public int cntUpdate(CartVO cartVO) {
		HashMap<String,String > map = new HashMap();
		String sql = "UPDATE tbl_cart SET cstock = "+cartVO.getCstock() ;
		sql += " WHERE pid = '"+cartVO.getPid()+"' ";
		sql += " AND userid = '"+cartVO.getUserid()+"'";
		map.put("sql",sql);
		
		int result = sqlSession.update(Namespace+".cntUpdate",map);
		return result;
	}
	
	@Override
	public void cartAllDelete(String userid) {
		HashMap<String,String > map = new HashMap();
		
		String sql = "DELETE FROM tbl_cart WHERE userid = '"+userid+"'";
		map.put("sql", sql);
		
		sqlSession.delete(Namespace+".cartAllDelete",map);
		
	}
}
