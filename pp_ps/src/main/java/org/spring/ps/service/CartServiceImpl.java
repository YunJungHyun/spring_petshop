package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.CartDAO;
import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.CartVO;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService{

	
	@Inject
	private CartDAO cartDAO;
	
	@Override
	public int addCart(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartDAO.addCart(cartVO); 
	}
	
	@Override
	public List<CartListVO> getCartList(String userid) {
		// TODO Auto-generated method stub
		return cartDAO.getCartList(userid);
	}
	
	@Override
	public int cartDelete(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartDAO.cartDelete(cartVO);
	}
	@Override
	public int cartCheck(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartDAO.cartCheck(cartVO);
	}
	
	@Override
	public int cntUpdate(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartDAO.cntUpdate(cartVO);
	}
	
	@Override
	public void cartAllDelete(String userid) {
		cartDAO.cartAllDelete(userid);
		
	}
}
