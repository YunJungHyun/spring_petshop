package org.spring.ps.dao;

import java.util.List;

import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;

public interface OrderDAO {

	void orderInfo(OrderVO orderVO);

	void orderInfo_Details(OrderDetailVO orderDetailVO);

	List<OrderVO> getOrderList(String userid);

	List<OrderListVO> getOrderDetailList(OrderVO orderVO);

	void orderInfo_Details_Right(OrderDetailVO orderDetailVO);

	List<OrderVO> getAllOrderList();

}
