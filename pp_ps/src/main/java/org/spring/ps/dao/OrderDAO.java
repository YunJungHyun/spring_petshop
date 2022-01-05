package org.spring.ps.dao;

import java.util.List;

import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.ReviewVO;

public interface OrderDAO {

	void orderInfo(OrderVO orderVO);

	void orderInfo_Details(OrderDetailVO orderDetailVO);

	List<OrderVO> getOrderList(String userid);

	List<OrderListVO> getOrderDetailList(OrderVO orderVO);

	void orderInfo_Details_Right(OrderDetailVO orderDetailVO);

	List<OrderVO> getAllOrderList();

	int orderDetailStateChange(OrderDetailVO orderDetailVO);

	int orderStateChange(OrderVO orderVO);

	int orderDetailStateChange_1(OrderVO orderVO);

	int orderDetailStateChk(OrderDetailVO orderDetailVO);

	void orderCanclePriceUpdate(OrderDetailVO orderDetailVO, String deAmount);

	List<OrderDetailVO> orderDetailList(String orderid);

	int updateReviewState(ReviewVO reviewVO);

}
