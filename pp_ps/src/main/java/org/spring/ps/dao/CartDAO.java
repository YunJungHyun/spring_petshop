package org.spring.ps.dao;

import java.util.List;

import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.CartVO;

public interface CartDAO {

	int addCart(CartVO cartVO);

	List<CartListVO> getCartList(String userid);


}
