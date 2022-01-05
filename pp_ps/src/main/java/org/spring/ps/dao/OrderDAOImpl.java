package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.ReviewVO;
import org.springframework.stereotype.Service;

@Service
public class OrderDAOImpl implements OrderDAO {

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.orderMapper";

	@Override
	public void orderInfo(OrderVO orderVO) {


		HashMap<String,String> map = new HashMap();
		String sql = "INSERT INTO tbl_order(orderid,userid,orderRec, userAddr1, userAddr2, userAddr3, orderPhon, amount) ";
		sql+= "VALUES('"+orderVO.getOrderid()+"','"+orderVO.getUserid()+"','"+orderVO.getOrderRec()+"',";
		sql+="'"+orderVO.getUserAddr1()+"','"+orderVO.getUserAddr2()+"','"+orderVO.getUserAddr3()+"',";
		sql+="'"+orderVO.getOrderPhon()+"',"+orderVO.getAmount()+")";

		map.put("sql", sql);


		sqlSession.insert(Namespace+".orderInfo",map);

	}

	@Override
	public void orderInfo_Details(OrderDetailVO orderDetailVO) {

		HashMap<String,String> map = new HashMap();
		String sql = "INSERT INTO order_details(orderid,pid, cstock) ";
		sql+="SELECT "+orderDetailVO.getOrderid()+", pid , cstock ";
		sql+="FROM cart";


		map.put("sql", sql);

		sqlSession.insert(Namespace+".orderInfo_Details",map);

	}
	
	@Override
	public void orderInfo_Details_Right(OrderDetailVO orderDetailVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "INSERT INTO order_details(orderid,pid, cstock) ";
		sql+="VALUES('"+orderDetailVO.getOrderid()+"','"+orderDetailVO.getPid()+"','"+orderDetailVO.getCstock()+"')";

		map.put("sql", sql);

		sqlSession.insert(Namespace+".orderInfo_Details_Right",map);
		
	}

	@Override
	public List<OrderVO> getOrderList(String userid) {
		HashMap<String,String> map = new HashMap();
		String sql ="SELECT * FROM tbl_order ";
		sql+="WHERE userid = '"+userid+"'";
		map.put("sql", sql);
		
		List<OrderVO> result= sqlSession.selectList(Namespace+".getOrderList",map);
		return result;
	}
	
	@Override
	public List<OrderListVO> getOrderDetailList(OrderVO orderVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "SELECT  o.orderid,o.userid,o.orderRec,o.userAddr1,o.userAddr2,o.userAddr3,o.orderPhon,o.amount,o.orderDate,o.delivery,";
				sql += "d.orderDetailNum, d.pid, d.cstock,d.delivery as eachDelivery,";
				sql += "p.pname, p.pimg,p.pprice ";
				sql += "FROM tbl_order o ";
				sql += "INNER JOIN order_details d ";
				sql += "	ON	o.orderid = d.orderid ";
				sql += "INNER JOIN tbl_product p ";
				sql += "	ON d.pid = p.pid ";
				sql += "WHERE	o.userid ='"+orderVO.getUserid()+"' ";
				sql += "AND o.orderid = '"+orderVO.getOrderid()+"'";
		map.put("sql", sql);
		List<OrderListVO> result= sqlSession.selectList(Namespace+".getOrderDetailList",map);
		return result;
	}
	
	@Override
	public List<OrderVO> getAllOrderList() {
		HashMap<String,String> map = new HashMap();
		String sql ="SELECT * FROM tbl_order ";
		map.put("sql", sql);
		List<OrderVO> result= sqlSession.selectList(Namespace+".getAllOrderList",map);
		return result;
	}
	
	@Override
	public int orderDetailStateChange(OrderDetailVO orderDetailVO) {
		HashMap<String,String> map = new HashMap();
		
		String sql = "UPDATE order_details SET delivery = 'orderCancle' ";
			sql+= "WHERE orderid = '"+orderDetailVO.getOrderid()+"' ";
			sql+= "AND pid = '"+orderDetailVO.getPid()+"'";
			map.put("sql", sql);
			int result= sqlSession.update(Namespace+".orderDetailStateChange",map);	
		return result;
	}
	
	@Override
	public int orderStateChange(OrderVO orderVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "UPDATE tbl_order SET delivery ='"+orderVO.getDelivery()+"' ";
		sql+= "WHERE orderid = '"+orderVO.getOrderid()+"' ";
		map.put("sql", sql);
		int result= sqlSession.update(Namespace+".orderStateChange",map);	
		return result;
	}
	
	@Override
	public int orderDetailStateChange_1(OrderVO orderVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "UPDATE order_details set delivery ='"+orderVO.getDelivery()+"' ";
			sql+= "WHERE orderid = '"+orderVO.getOrderid()+"' ";
			sql+= "AND delivery <> 'orderCancle'";
		map.put("sql", sql);
		int result= sqlSession.update(Namespace+".orderDetailStateChange_1",map);
		return result;
	}
	
	@Override
	public int orderDetailStateChk(OrderDetailVO orderDetailVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "SELECT COUNT(*) FROM order_details ";
				sql += "WHERE orderid = '"+orderDetailVO.getOrderid()+"' ";
				sql += "AND  delivery <> 'orderCancle'";
		map.put("sql", sql);
		int result= sqlSession.selectOne(Namespace+".orderDetailStateChk",map);
		return result;
	}
	
	@Override
	public void orderCanclePriceUpdate(OrderDetailVO orderDetailVO, String deAmount) {
		HashMap<String,String> map = new HashMap();
		String sql = "UPDATE tbl_order SET amount = amount - "+deAmount;
				sql+= " WHERE orderid ='"+orderDetailVO.getOrderid()+"'";
		map.put("sql", sql);
		sqlSession.selectOne(Namespace+".orderDetailStateChk",map);
	}
	
	@Override
	public List<OrderDetailVO> orderDetailList(String orderid) {
		HashMap<String,String> map = new HashMap();
		String sql = "SELECT * FROM order_details  WHERE orderid = '"+orderid+"'";
		map.put("sql", sql);
		List<OrderDetailVO> result= sqlSession.selectList(Namespace+".orderDetailList",map);
		return result;
	}
	
	@Override
	public int updateReviewState(ReviewVO reviewVO) {
		HashMap<String,String> map = new HashMap();
		String sql = "UPDATE order_details SET review = 'okay' ";
			sql+= "WHERE pid='"+reviewVO.getPid()+"' ";
			sql+= "AND orderid='"+reviewVO.getOrderid()+"' ";
		
			
		map.put("sql", sql);
		int result= sqlSession.update(Namespace+".updateReviewState",map);
		return result;
	}
}
