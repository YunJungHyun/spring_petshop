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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/cart")
public class CartController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	
	@Inject
	private CartService cartService;
	
	 
	@RequestMapping("/addCart")
	@ResponseBody
	public String addCart(
			
			HttpSession session,
			CartVO cartVO
			
			) {
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		cartVO.setUserid(userVO.getUserid());
		int cartChkResult = cartService.cartCheck(cartVO);
		
		String resutStr = "";
		
		log.debug("[cartChkResult] :" +cartChkResult);
		if(cartChkResult >=1) {
			
			resutStr = "cartChkTrue";
			
		}else {
			
			int result = cartService.addCart(cartVO);
			
			if(result >=1) {
				
				resutStr = "cartAddSuccess";
			}else {
				
				resutStr = "cartAddFail";
			}
		}
		return resutStr;
	}
	
	
	
	@RequestMapping("/cntUpdate")
	@ResponseBody
	public int cntUpdate(
			CartVO cartVO,
			HttpSession session
			
			) {
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		cartVO.setUserid(userVO.getUserid());
		
		int result =cartService.cntUpdate(cartVO);
		
		return result;
	}
	
	@RequestMapping("/addBuyList")
	@ResponseBody
	public void addBuyList() {
		
		
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	public int cartDelete(
			HttpSession session,
			@RequestParam(value="pid", required=true) String pid
			) {
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
	
		CartVO cartVO = new CartVO();
		cartVO.setUserid(userVO.getUserid());
		cartVO.setPid(pid);
		
		int result = cartService.cartDelete(cartVO);
		
		return result;
		
		
	}
}
