package org.spring.ps.view.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CartService;
import org.spring.ps.vo.CartVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/cart")
public class cartController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	
	@Inject
	private CartService cartService;
	
	
	@RequestMapping("/addCart")
	@ResponseBody
	public int addCart(
			
			HttpSession session,
			CartVO cartVO
			
			) {
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		cartVO.setUserid(userVO.getUserid());
		int result = cartService.addCart(cartVO);
		
		return result;
	}
	
	@RequestMapping("/addBuyList")
	@ResponseBody
	public void addBuyList() {
		
		
	}
}
