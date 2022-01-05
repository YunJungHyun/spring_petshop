package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.ReviewDetailVO;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class ReviewDAOImpl implements ReviewDAO{


	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.reviewMapper";

	@Override
	public int canReviewCnt(UserVO userVO) {


		HashMap<String,String> map = new HashMap();

		String sql =" SELECT COUNT(*) FROM order_details AS d "; 
		sql+="INNER JOIN tbl_order o "; 
		sql+="ON o.orderid = d.orderid "; 
		sql+="WHERE o.userid = '"+userVO.getUserid()+"' ";
		sql+="AND d.delivery = 'deliveryComplete' ";
		sql+="AND d.review = 'none'";

		map.put("sql",sql);

		int result = sqlSession.selectOne(Namespace+".canReviewCnt",map);

		return result;
	}

	@Override
	public List<ReviewDetailVO> getCanReviewList(UserVO userVO) {
		HashMap<String,String> map = new HashMap();

		String sql= "SELECT p.pid,p.pname,p.pprice,p.pimg,o.orderDate ,d.cstock,o.orderid FROM tbl_product AS p "; 
		sql += "INNER JOIN order_details AS d "; 
		sql += "ON p.pid = d.pid "; 
		sql += "INNER JOIN tbl_order AS o "; 
		sql += "ON d.orderid = o.orderid ";
		sql += "WHERE d.review = 'none' AND d.delivery = 'deliveryComplete' AND o.userid = '"+userVO.getUserid()+"'";

		map.put("sql",sql);

		List<ReviewDetailVO> result = sqlSession.selectList(Namespace+".getCanReviewList",map);

		return result;
	}

	@Override
	public int reviewInsert(ReviewVO reviewVO) {
		HashMap<String,String> map = new HashMap();

		String sql ="INSERT INTO tbl_review(pid,userid,revContent,rating ) ";
		sql+="VALUES('"+reviewVO.getPid()+"','"+reviewVO.getUserid()+"','"+reviewVO.getRevContent()+"','"+reviewVO.getRating()+"')";


		map.put("sql", sql);

		int result = sqlSession.insert(Namespace+".reviewInsert",map);
		return result;
	}

	@Override
	public int reviewCnt(UserVO userVO) {
		HashMap<String,String> map = new HashMap();
		String sql =" SELECT COUNT(*) FROM order_details AS d "; 
		sql+="INNER JOIN tbl_order o "; 
		sql+="ON o.orderid = d.orderid "; 
		sql+="WHERE o.userid = '"+userVO.getUserid()+"' ";
		sql+="AND d.delivery = 'deliveryComplete' ";
		sql+="AND d.review = 'okay'";

		map.put("sql",sql);

		int result = sqlSession.selectOne(Namespace+".reviewCnt",map);

		return result;
	}
	
	@Override
	public List<ReviewDetailVO> getReviewList(UserVO userVO) {
		HashMap<String,String> map = new HashMap();
		String sql= "SELECT p.pid,p.pname,p.pprice,p.pimg,o.orderDate ,d.cstock,o.orderid ,r.revContent ,r.rating, r.revDate FROM tbl_product AS p "; 
		sql += "INNER JOIN order_details AS d "; 
		sql += "ON p.pid = d.pid "; 
		sql += "INNER JOIN tbl_order AS o "; 
		sql += "ON d.orderid = o.orderid ";
		sql += "INNER JOIN tbl_review AS r "; 
		sql += "ON p.pid = r.pid ";
		sql += "WHERE d.review = 'okay' AND d.delivery = 'deliveryComplete' AND o.userid = '"+userVO.getUserid()+"'";
		
	
		
		map.put("sql",sql);

		List<ReviewDetailVO> result = sqlSession.selectList(Namespace+".getReviewList",map);

		return result;
	}
	
	@Override
	public List<ReviewDetailVO> getProdOneReviewList(String pid) {
		HashMap<String,String> map = new HashMap();
		String sql = "SELECT r.* , u.username FROM tbl_review AS r "; 
				sql += "INNER JOIN tbl_product AS p "; 
				sql += "ON r.pid = p.pid ";
				sql += "INNER JOIN tbl_user AS u "; 
				sql += "ON r.userid = u.userid ";
				sql += "WHERE p.pid = '"+pid+"' ";
		
		map.put("sql",sql);
		List<ReviewDetailVO> result = sqlSession.selectList(Namespace+".getProdOneReviewList",map);
		return result;
	}

}
