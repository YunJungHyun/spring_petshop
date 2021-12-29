package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.OrderDAO;
import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.springframework.stereotype.Service;

@Service 
public class OrderServiceImpl implements OrderService{
	
	
	@Inject
	private OrderDAO orderDAO;
	@Override
	public void orderInfo(OrderVO orderVO) {
		
		
		orderDAO.orderInfo(orderVO);
	}
	
	@Override
	public void orderInfo_Details(OrderDetailVO orderDetailVO) {
		orderDAO.orderInfo_Details(orderDetailVO);
		
	}
	@Override
	public void orderInfo_Details_Right(OrderDetailVO orderDetailVO) {
		orderDAO.orderInfo_Details_Right(orderDetailVO);
		
	}
	
	@Override
	public List<OrderVO> getOrderList(String userid) {
		// TODO Auto-generated method stub
		return orderDAO.getOrderList(userid);
	}
	
	@Override
	public List<OrderListVO> getOrderDetailList(OrderVO orderVO) {
		// TODO Auto-generated method stub
		return orderDAO.getOrderDetailList(orderVO);
	}
	
	@Override
	public List<OrderVO> getAllOrderList() {
		// TODO Auto-generated method stub
		return orderDAO.getAllOrderList();
	
	}
}
