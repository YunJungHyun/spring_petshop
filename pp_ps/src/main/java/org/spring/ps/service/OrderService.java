package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderVO;

public interface OrderService {

	void orderInfo(OrderVO orderVO);

	void orderInfo_Details(OrderDetailVO orderDetailVO);

	List<OrderVO> getOrderList(String userid);

}
