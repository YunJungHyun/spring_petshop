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
import org.spring.ps.service.CartService;
import org.spring.ps.service.OrderService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
	@Inject
	private OrderService orderService;



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



	
	
	@RequestMapping(value="/mypage/{my}")
	public String order(
			HttpSession session,
			HttpServletResponse response,Model model,
			@PathVariable("my") String my
			) throws IOException {

		log.debug("############## : "+my);
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		Map<Integer,String[]> routeMap = new HashMap<>();
		String page="";
		
		if(userVO == null ) {
			
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('로그인 후 이용가능합니다.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			switch(my) {
			
				case "myOrder":
					List<OrderVO> orderList = orderService.getOrderList(userVO.getUserid());
					
					model.addAttribute("oList",orderList);
					
					page ="myPageOrder";
					String routeArray1[][] = {{"마이페이지","/view/mypage/myOrder"},{"주문 내역","/view/mypage/myOrder"}};
					routeMap.put(0,routeArray1[0]);
					routeMap.put(1,routeArray1[1]);
					break;
				case "myCart":
					List<CartListVO> cartList = cartService.getCartList(userVO.getUserid());
					
					model.addAttribute("cartList",cartList);
					
					page ="cart/cart";
					String routeArray2[][] = {{"마이페이지","/view/mypage/myOrder"},{"장바구니","/view/mypage/myCart"}};
					routeMap.put(0,routeArray2[0]);
					routeMap.put(1,routeArray2[1]);
					break;
					
			}
			
		}
		
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);
		model.addAttribute("breadcrumb",breadcrumbList);
		String pageTitle ="마이페이지";
		model.addAttribute("pageTitle",pageTitle);
		
		return "user/my/"+page+".page";
	}
	
	@RequestMapping(value="/orderOkay")
	public String orderOkay(HttpSession session,
			HttpServletResponse response,Model model) throws IOException {

		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		if(userVO == null ) {
			
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('페이지 접근 권한이 없습니다.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
		
		
		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"장바구니","/view/cart"},{"주문 완료","/view/orderOkay"}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
	
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);


		String pageTitle = "주문 완료";
		model.addAttribute("pageTitle",pageTitle);
	

		return "user/order/orderOkay.page";
		}
	}
}
