package org.spring.ps.view.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.QnAService;
import org.spring.ps.service.ReviewService;
import org.spring.ps.service.UserService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

	Log log = LogFactory.getLog(this.getClass());

	@Inject 
	private UserService userService;

	@Inject
	private OrderService orderService;

	@Inject
	private QnAService qnAService;

	@Inject
	private ReviewService reviewService;
	
	@RequestMapping(value="/findUserInfo", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> findUserInfo(
			
			UserVO userVO
			) {
		
		log.debug("[findUserInfo] :" +userVO.toString());
		
		HashMap<String,String > findMap = new HashMap<String, String>();
		String findStr= null;
		if(userVO.getUserid() == null) {
			
			findStr= userService.findUserid(userVO);
			findMap.put("findStr", findStr);
			findMap.put("findSort", "아이디");
		}else {
			findStr= userService.findUserpw(userVO);
			findMap.put("findStr", findStr);
			findMap.put("findSort", "비밀번호");
		}
		
		return findMap;
	}
	
	@RequestMapping(value="/userInfoUpdate" , method=RequestMethod.POST)
	@ResponseBody
	public int userInfoUpdate(
			UserVO userVO,
			HttpSession session
			) {
		
		UserVO userInfo= (UserVO)session.getAttribute("userInfo");
		
		log.debug("[userInfoUpdate] userVO : "+ userVO.toString() );
		
		
		userVO.setUnum(userInfo.getUnum());
		
		int result = userService.userInfoUpdate(userVO);
		return result;
	}
	
	@RequestMapping(value="/memberInfoUpdate" , method=RequestMethod.POST)
	@ResponseBody
	public int userInfoUpdate(
			UserVO userVO
			) {
		
		
		log.debug("[memberInfoUpdate] userVO :" +userVO.toString());
		int result = userService.memberInfoUpdate(userVO);
		return result;
	}
	
	
	

}
