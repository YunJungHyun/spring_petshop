package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.CartVO;

public interface CartService {

	int addCart(CartVO cartVO);

	List<CartListVO> getCartList(String userid);

	int cartDelete(CartVO cartVO);

	int cartCheck(CartVO cartVO);

	int cntUpdate(CartVO cartVO);

	void cartAllDelete(String userid);

}
