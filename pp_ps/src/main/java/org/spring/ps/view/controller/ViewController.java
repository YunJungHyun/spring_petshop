package org.spring.ps.view.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CartService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());

	@Inject
	private CartService cartService;



	@RequestMapping(value="/petshop")
	public String home(
			Model model
			) {


		log.debug("home");  


		String pageTitle = "HOME"; 



		model.addAttribute("breadcrumb", "none");
		model.addAttribute("pageTitle", pageTitle);

		return "home.page"; 
	}

	@RequestMapping(value="/login")
	public String userLogin(Model model,
			@RequestParam(value="go",required = false) String go) {

		log.debug("[userLogin]");

		String pageTitle = "로그인";


		model.addAttribute("pageTitle",pageTitle);
		model.addAttribute("go",go);

		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"로그인","/view/login"}};
		routeMap.put(0,routeArray[0]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);

		return "user/join/login.page";
	}
	@RequestMapping(value="/signUpSort")
	public String signUpSort(Model model) {

		log.debug("[signUp]");


		String pageTitle = "회원가입유형";
		model.addAttribute("pageTitle",pageTitle);


		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"회원가입 유형","/view/signUpSort"}};
		routeMap.put(0,routeArray[0]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);

		model.addAttribute("breadcrumbList",breadcrumbList);
		return "user/join/signUpSort.page";
	}
	@RequestMapping(value="/signUp")
	public String signUp(Model model) {

		log.debug("[signUp]");

		String pageTitle = "PETSHOP 회원가입";

		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"회원가입 유형","/view/signUpSort"},{"펫샵 회원가입","/view/signUp"}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);

		model.addAttribute("pageTitle",pageTitle);


		return "user/join/signUp.page";
	}
	@RequestMapping(value="/signUpAfter")
	public String signUpAfter(Model model) {



		log.debug("[signUpAfter]");

		String pageTitle = "PETSHOP 회원가입 완료";
		model.addAttribute("pageTitle",pageTitle);


		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"회원가입 유형","/view/signUpSort"},{"펫샵 회원가입","/view/signUp"},{"회원가입 완료","/view/signUpAfter"}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
		routeMap.put(2,routeArray[2]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);


		return "user/join/signUpAfter.page";
	}


	@RequestMapping(value="/cart")
	public String cart(Model model,HttpSession session) {

		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		List<CartListVO> cartList = cartService.getCartList(userVO.getUserid());

		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"장바구니","/view/cart"}};
		routeMap.put(0,routeArray[0]);
	
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);


		String pageTitle = "장바구니";
		model.addAttribute("pageTitle",pageTitle);
		model.addAttribute("cartList",cartList);


		return "user/cart/cartList.page";
	}
}
