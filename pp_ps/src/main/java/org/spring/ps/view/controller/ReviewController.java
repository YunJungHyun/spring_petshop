package org.spring.ps.view.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.ReviewService;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/review")
public class ReviewController {
	

	Log log = LogFactory.getLog(this.getClass());


	
	@Inject
	private ProductService productService;
	@Inject
	private ReviewService reviewService;
	@Inject
	private OrderService orderService;
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	@ResponseBody
	public int reviewDelete(
			
			@RequestParam( value = "revNum") String revNum,
			@RequestParam( value="pid") String pid
			) {
		
		int result = reviewService.reviewDelete(revNum);
		productService.updateRating(pid);
		return result;
	}
	
	@RequestMapping(value="/canReviewCnt" , method=RequestMethod.POST)
	@ResponseBody
	public int canReviewCnt(
			
			HttpSession session 
			) {
		
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		
		
		int result = reviewService.canReviewCnt(userVO);
		
		return result;
	}
	@RequestMapping(value = "/reviewCnt" , method=RequestMethod.POST)
	@ResponseBody
	public int reviewCnt(
			HttpSession session
			) {
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		int result = reviewService.reviewCnt(userVO);
		return result;
	}
	
	@RequestMapping(value = "/reviewInsert" , method=RequestMethod.POST)
	@ResponseBody
	public int reviewInsert(
			HttpSession session,
			ReviewVO reviewVO
			) {
		
		UserVO userVO=(UserVO)session.getAttribute("userInfo");
		reviewVO.setUserid(userVO.getUserid());
		log.debug("[reviewInsert] reviewVO.toString() : "+reviewVO.toString());
		
		
		int insertResult = reviewService.reviewInsert(reviewVO);
		int result =0;
		if(insertResult >=1) {
			
			result =orderService.updateReviewState(reviewVO);
			
			productService.updateRating(reviewVO.getPid());
		} 
		return result;
	}
	

}
