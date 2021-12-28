package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderVO;
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
		String sql = "INSERT INTO order_details(orderDetailNum,orderid,pid, cstock) ";
		sql+="SELECT (select max(orderDetailNum)+1 from order_details) as num ,"+orderDetailVO.getOrderid()+", pid , cstock ";
		sql+="FROM cart";


		map.put("sql", sql);

		sqlSession.insert(Namespace+".orderInfo_Details",map);

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
}
