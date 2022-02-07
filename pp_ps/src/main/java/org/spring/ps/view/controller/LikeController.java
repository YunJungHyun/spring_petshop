package org.spring.ps.view.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.LikeService;
import org.spring.ps.vo.LikeVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/like")
public class LikeController {


	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private LikeService likeService;
	
	@RequestMapping(value="/check",method=RequestMethod.POST)
	@ResponseBody
	public int likeCheck(
			HttpSession session,
			@RequestParam(value="pid") String pid
			) {
		
		
		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		
		LikeVO likeVO = new LikeVO();
		
		likeVO.setPid(pid);
		likeVO.setUserid(userInfo.getUserid());
		
		int result = likeService.likeCheck(likeVO);
		
		
		return result;
		
	}
	
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	@ResponseBody
	public int likeInsert(
			HttpSession session,
			@RequestParam(value="pid") String pid
			) {

		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		
		LikeVO likeVO = new LikeVO();
		
		likeVO.setPid(pid);
		likeVO.setUserid(userInfo.getUserid());
		
		
		int result = likeService.likeInsert(likeVO);
		
		
		return result;
	}
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public int likeDelete(
			HttpSession session,
			@RequestParam(value="pid") String pid
			) {
		
		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		
		LikeVO likeVO = new LikeVO();
		
		likeVO.setPid(pid);
		likeVO.setUserid(userInfo.getUserid());
		
		
		int result = likeService.likeDelete(likeVO);
		
		
		return result;
	}
}
