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
	public int addCart(CartVO cartVO) {
		
		HashMap<String, String> map = new HashMap();
		
		String sql = "INSERT INTO cart(userid,pid,cstock) ";
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
		sql+= "SELECT c.cnum, c.userid, c.pid, c.cstock, c.addDate, p.pname, p.pprice, p.pimg FROM cart AS c ";
		sql += "INNER JOIN product AS p ";
		sql += "ON c.pid = p.pid ";
		sql += "WHERE c.userid ='"+userid+"') AS C";
		
		 
		map.put("sql", sql);
		
		List<CartListVO> result =sqlSession.selectList(Namespace+".getCartList",map);
		return result;
	}
}
