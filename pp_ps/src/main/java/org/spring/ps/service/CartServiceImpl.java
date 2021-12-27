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
}
