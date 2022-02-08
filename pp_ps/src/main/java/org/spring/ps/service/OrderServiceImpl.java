package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.OrderDAO;
import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;
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
	
	@Override
	public int orderDetailStateChange(OrderDetailVO orderDetailVO) {
		// TODO Auto-generated method stub
		return orderDAO.orderDetailStateChange(orderDetailVO);
	}
	
	@Override
	public int orderStateChange(OrderVO orderVO) {
		// TODO Auto-generated method stub
		return orderDAO.orderStateChange(orderVO);
	}
	
	@Override
	public int orderDetailStateChange_1(OrderVO orderVO) {
		// TODO Auto-generated method stub
		return orderDAO.orderDetailStateChange_1(orderVO);
	}
	@Override
	public int orderDetailStateChk(OrderDetailVO orderDetailVO) {
		// TODO Auto-generated method stub
		return orderDAO.orderDetailStateChk(orderDetailVO);
	}
	@Override
	public void orderCanclePriceUpdate(OrderDetailVO orderDetailVO, String deAmount) {
		orderDAO.orderCanclePriceUpdate(orderDetailVO,deAmount);
		
	}
	
	@Override
	public List<OrderDetailVO> orderDetailList(String orderid) {
		// TODO Auto-generated method stub
		return orderDAO.orderDetailList(orderid);
	}
	
	@Override
	public int updateReviewState(ReviewVO reviewVO) {
		// TODO Auto-generated method stub
		return orderDAO.updateReviewState(reviewVO);
	}
	
	@Override
	public List<OrderVO> getOrderCancleList(String userid) {
		// TODO Auto-generated method stub
		return orderDAO.getOrderCancleList(userid);
	}
	
	@Override
	public int getMyOrderCnt(UserVO userVO) {
		// TODO Auto-generated method stub
		return orderDAO.getMyOrderCnt(userVO);
	}
}
