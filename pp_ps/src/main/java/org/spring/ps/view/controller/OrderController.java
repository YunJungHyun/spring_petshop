package org.spring.ps.view.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CartService;
import org.spring.ps.service.OrderService;
import org.spring.ps.vo.OrderDetailVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/order")
public class OrderController {
 

	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private OrderService orderService;
	@Inject
	private CartService cartService;

	@RequestMapping(value="/orderInsert", method=RequestMethod.POST)
	@ResponseBody
	public String orderInsert(
			HttpSession session,
			OrderVO orderVO,
			OrderDetailVO orderDetailVO
			) {
		
		log.debug("[orderInsert] orderVO.toString :"+orderVO.toString());
		log.debug("[orderInsert] orderDetailVO.toString :"+orderDetailVO.toString());
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		String userid = userVO.getUserid();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym= year + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		for (int i= 1 ; i<=6; i++) {
			
			subNum += (int)(Math.random()*10);
		}
		
		String orderid = ymd+subNum;
		
		orderVO.setOrderid(orderid);
		orderVO.setUserid(userid);
		
		orderService.orderInfo(orderVO);  
		orderDetailVO.setOrderid(orderid);
		orderService.orderInfo_Details(orderDetailVO); 
		
		cartService.cartAllDelete(userid);
		String result ="success";
		
		return result;
	}
	@RequestMapping(value="/orderInsertRight", method=RequestMethod.POST)
	@ResponseBody
	public String orderInsertRight(
			HttpSession session,
			OrderVO orderVO,
			OrderDetailVO orderDetailVO
			) {
		log.debug("[orderInsertRight] orderVO :"+orderVO.toString());
		log.debug("[orderInsertRight] orderDetailVO :"+orderDetailVO.toString());

		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		String userid = userVO.getUserid();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym= year + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";
		for (int i= 1 ; i<=6; i++) {
			
			subNum += (int)(Math.random()*10);
		}
		
		String orderid = ymd+subNum;
		
		orderVO.setOrderid(orderid);
		orderVO.setUserid(userid);
		
		orderService.orderInfo(orderVO);  
		orderDetailVO.setOrderid(orderid);
		orderService.orderInfo_Details_Right(orderDetailVO); 
		
		String result ="success";
		
		return result;
	}
	
	@RequestMapping(value="/orderDetailList")
	@ResponseBody
	public List<OrderListVO> orderDetailList(
			HttpSession session,
			@RequestParam(value="orderid") String orderid,
			@RequestParam(value="userid", required = false) String userid
			
			) {
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		OrderVO orderVO = new OrderVO();
		orderVO.setOrderid(orderid);
		if(userid == null) {
			orderVO.setUserid(userVO.getUserid());
		}else {
			
			orderVO.setUserid(userid);
		}
		List<OrderListVO> olList = orderService.getOrderDetailList(orderVO);
		
		
		return olList;
	}
}
