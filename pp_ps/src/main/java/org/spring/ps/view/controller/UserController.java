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
	
	@RequestMapping(value="/userInfoUpdate")
	@ResponseBody
	public int userInfoUpdate(
			UserVO userVO,
			HttpSession session
			) {
		
		UserVO userInfo= (UserVO)session.getAttribute("userInfo");
		
		String auth ="";
		
		if(userInfo.getUlevel() == 2) {
			auth ="admin";
			
		}else {
			
			auth ="nomal";
		}
	
		int result = userService.userInfoUpdate(userVO,auth);
		
		
		return result;
	}
	
	
	@RequestMapping(value="/{unum}", method=RequestMethod.GET)
	public String userDetail(
			Model model,
			@PathVariable(value="unum", required = true) String unum,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="orderBy",required = false) String orderBy,
			@RequestParam(value="sort" ,required = false) String sort ,
			PagingVO pagingVO,
			HttpSession session,
			HttpServletResponse response

			) throws IOException {
		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		if(userInfo == null || userInfo.getUlevel() != 2) {

			log.debug("[adminView] userInfo : 접근권한없음");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('페이지 접근권한이 없습니다.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			String mark = null;
			String subTitle = null;
			String memberPage = null;
			if(sort ==null) {

				sort = "";
			}
			switch(sort) {

			case "shopingList":
				mark ="shopingList";
				break;
			case "reviewList":
				mark ="reviewList";
				break;
			case "QnAList":
				mark ="QnAList";
				break;
			default :
				mark ="userInfoList";
				subTitle= "기본 정보";
				memberPage ="member/MemberDetail";
				break;
			}
			
			UserVO uvo=userService.getOneUser(unum);


			Map<Integer,String[]> routeMap = new HashMap<>();
			String routeArray[][] = {{"관리자 페이지","/adminView/Management"},{"회원 관리","/adminView/Member"},{uvo.getUsername()+" 님","/user/"+unum}};
			routeMap.put(0,routeArray[0]);
			routeMap.put(1,routeArray[1]);
			routeMap.put(2,routeArray[2]);

			List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

			model.addAttribute("uvo", uvo);
			model.addAttribute("mark",mark);
			model.addAttribute("subTitle",subTitle);
			model.addAttribute("pageTitle","회원");
			model.addAttribute("breadcrumb",breadcrumbList);

			return "admin/"+memberPage+".page";
		}
	}

}
