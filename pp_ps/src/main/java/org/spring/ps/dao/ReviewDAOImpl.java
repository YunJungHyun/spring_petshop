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

		String sql =" SELECT COUNT(*) FROM tbl_order_details AS d "; 
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

		String sql= "SELECT p.pid,p.psale,p.pname,p.pprice,p.pimg,o.orderDate ,d.cstock,o.orderid FROM tbl_product AS p "; 
		sql += "INNER JOIN tbl_order_details AS d "; 
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
		String sql =" SELECT COUNT(*) FROM tbl_review  "; 
		sql+="WHERE userid = '"+userVO.getUserid()+"' ";
		

		map.put("sql",sql);

		int result = sqlSession.selectOne(Namespace+".reviewCnt",map);

		return result;
	}
	
	@Override
	public List<ReviewDetailVO> getReviewList(UserVO userVO) {
		HashMap<String,String> map = new HashMap();
		String sql= " SELECT tbl_r.* , tbl_p.pname,tbl_p.pimg FROM tbl_review AS tbl_r "; 
		sql += " INNER JOIN tbl_product AS tbl_p "; 
		sql += " ON tbl_p.pid = tbl_r.pid "; 
		sql += " WHERE tbl_r.userid ='"+userVO.getUserid()+"' "; 
		
		
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
	
	@Override
	public List<ReviewVO> getAllReviewList() {
		HashMap<String,String> map = new HashMap<String,String>();
		String sql = " SELECT * FROM tbl_review ";
		map.put("sql", sql);
		
		List<ReviewVO> result = sqlSession.selectList(Namespace+".getAllReviewList",map);
		return result;
	}
	
	@Override
	public int reviewDelete(String revNum) {
		HashMap<String,String> map = new HashMap<String,String>();
		String sql = " DELETE FROM tbl_review WHERE revNum = '"+revNum+"' ";
		map.put("sql", sql);
		
		int result = sqlSession.delete(Namespace+".reviewDelete",map);
		return result;
	}

}
