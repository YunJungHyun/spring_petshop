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
import org.spring.ps.service.LikeService;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.QnAService;
import org.spring.ps.service.ReviewService;
import org.spring.ps.service.UserService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.CartListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.ReviewDetailVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

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

	@Inject
	private ReviewService reviewService;
	
	@Inject
	private ProductService productService;
	
	@Inject
	private UserService userService;
	
	@Inject
	private QnAService qnaService;
	
	@Inject
	private LikeService likeService;
	
	@RequestMapping(value="/leftMenuInfo" , method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,String> leftMenuInfo(
			HttpSession session
			){
		
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		int canReviewCnt = reviewService.canReviewCnt(userVO);
		int reviewCnt = reviewService.reviewCnt(userVO);
		int qnaCnt = qnaService.getMyQnACnt(userVO);
		int likeCnt = likeService.getMyLikeCnt(userVO);
		int orderCnt = orderService.getMyOrderCnt(userVO);
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("orderCnt", Integer.toString(orderCnt));
		map.put("likeCnt", Integer.toString(likeCnt));
		map.put("qnaCnt", Integer.toString(qnaCnt));
		map.put("canReviewCnt", Integer.toString(canReviewCnt));
		map.put("reviewCnt",Integer.toString(reviewCnt) );
		return map;
		
	}
	
	
	@RequestMapping(value="/petshop")
	public String home(
			Model model,
			PagingVO pagingVO
			
			) {
		
		
		/*		
		,
		HttpSession session
		UserVO userInfo = new UserVO(); userInfo.setUlevel(2);
		userInfo.setUserid("admin"); userInfo.setUserpw("1");
		session.setAttribute("userInfo", userInfo);

		
		 */
		
		log.debug("home");  


		String pageTitle = "HOME";  
		
		pagingVO.setStart(1);
		pagingVO.setEnd(10);
		
		String categoryCode = "";
		List<ProductVO> saleList = productService.getSaleProductList(pagingVO,categoryCode);
		List<ProductVO>  recentList= productService.getRecentProductList(pagingVO,categoryCode);
		List<ProductVO> rankList = productService.getRankProductList(pagingVO,categoryCode);
		
		log.debug("saleList.size() :" +saleList.size());
		log.debug("recentList.size() :" +recentList.size());
		log.debug("rankList.size() :" +rankList.size());
		
		model.addAttribute("saleList",saleList);
		model.addAttribute("recentList",recentList);
		model.addAttribute("rankList",rankList);
		
		model.addAttribute("breadcrumb", "none");
		model.addAttribute("pageTitle", pageTitle);

		return "home.page"; 
	}

	@RequestMapping(value="/login")
	public String userLogin(Model model,
			@RequestParam(value="go",required = false) String go) {

		log.debug("[userLogin]");

		String pageTitle = "?????????";


		model.addAttribute("pageTitle",pageTitle);
		model.addAttribute("go",go);

		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"?????????","/view/login"}};
		routeMap.put(0,routeArray[0]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);

		return "user/join/login.page";
	}
	@RequestMapping(value="/signUpSort")
	public String signUpSort(Model model) {

		log.debug("[signUp]");


		String pageTitle = "??????????????????";
		model.addAttribute("pageTitle",pageTitle);


		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"???????????? ??????","/view/signUpSort"}};
		routeMap.put(0,routeArray[0]);
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);

		model.addAttribute("breadcrumbList",breadcrumbList);
		return "user/join/signUpSort.page";
	}
	@RequestMapping(value="/signUp")
	public String signUp(Model model) {

		log.debug("[signUp]");

		String pageTitle = "PETSHOP ????????????";

		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"???????????? ??????","/view/signUpSort"},{"?????? ????????????","/view/signUp"}};
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

		String pageTitle = "PETSHOP ???????????? ??????";
		model.addAttribute("pageTitle",pageTitle);


		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"???????????? ??????","/view/signUpSort"},{"?????? ????????????","/view/signUp"},{"???????????? ??????","/view/signUpAfter"}};
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
		String mark= "";
		if(userVO == null ) {
			
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('????????? ??? ?????????????????????.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			
			
			switch(my) {
				case "myInfo":
					
					
					UserVO uvo = userService.getOneUser(Integer.toString(userVO.getUnum()));
					model.addAttribute("uvo",uvo);
					
					
					String routeArray1[][] = {{"???????????????","/view/mypage/myOrder"},{"??? ??????","/view/mypage/myInfo"}};
					routeMap.put(0,routeArray1[0]);
					routeMap.put(1,routeArray1[1]);
					page = "my/myInfo";
					mark ="myInfo";
					break;
			
				case "myOrder":
					List<OrderVO> orderList = orderService.getOrderList(userVO.getUserid());
					
					model.addAttribute("oList",orderList);
					
					page ="myPageOrder";
					String routeArray2[][] = {{"???????????????","/view/mypage/myOrder"},{"?????? ??????","/view/mypage/myOrder"}};
					routeMap.put(0,routeArray2[0]);
					routeMap.put(1,routeArray2[1]);
					mark ="myOrder";
					break;
				
				case "myCart":
					List<CartListVO> cartList = cartService.getCartList(userVO.getUserid());
					
					model.addAttribute("cartList",cartList);
					
					page ="cart/cart";
					String routeArray4[][] = {{"???????????????","/view/mypage/myOrder"},{"????????????","/view/mypage/myCart"}};
					routeMap.put(0,routeArray4[0]);
					routeMap.put(1,routeArray4[1]);
					break;
				case "myReviewWriter":
				
					
					List<ReviewDetailVO> canReviewList = reviewService.getCanReviewList(userVO);
					
					model.addAttribute("crList",canReviewList);
					
					page ="review/review";
					String routeArray5[][] = {{"???????????????","/view/mypage/myOrder"},{"?????? ??????","/view/mypage/myReviewWriter"}};
					routeMap.put(0,routeArray5[0]);
					routeMap.put(1,routeArray5[1]);
					mark ="myReviewWriter"; 
					break;
				case "myReviewList":
					
					
					List<ReviewDetailVO> reviewList = reviewService.getReviewList(userVO);
					
					log.debug("[check] reviewList :" +reviewList.toString());
					model.addAttribute("rList",reviewList);
					
					page ="review/reviewList";
					String routeArray6[][] = {{"???????????????","/view/mypage/myOrder"},{"?????? ????????? ??????","/view/mypage/myReviewList"}};
					routeMap.put(0,routeArray6[0]);
					routeMap.put(1,routeArray6[1]);
					mark ="myReviewList";
					break;
				case "myWish":
					
					
					List<ProductVO> wishList = productService.getUserLikeProductList(userVO.getUserid());
					model.addAttribute("wishList",wishList);
					page ="like/likeList";
					String routeArray7[][] = {{"???????????????","/view/mypage/myOrder"},{"??????","/view/mypage/myWish"}};
					routeMap.put(0,routeArray7[0]);
					routeMap.put(1,routeArray7[1]);
					mark ="myWish";
					break;
					
				case "myQnA":
					
					List<QnAVO> qnaList = qnaService.getMyQnAList(userVO.getUserid());
					
					List<QnAVO> qCnt =  qnaService.getQnAEachCntList(userVO.getUserid());
					Gson gson = new GsonBuilder().create();
					
					String json = gson.toJson(qCnt);
					
					model.addAttribute("qCnt",json);
					model.addAttribute("qnaList",qnaList);
					page ="QnA/QnAList";
					String routeArray8[][] = {{"???????????????","/view/mypage/myOrder"},{"?????? Q&A","/view/mypage/myQnA"}};
					routeMap.put(0,routeArray8[0]);
					routeMap.put(1,routeArray8[1]);
					mark ="myQnA";
					break;
					
			}
			
		}
		
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);
		model.addAttribute("breadcrumb",breadcrumbList);
		String pageTitle ="???????????????";
		model.addAttribute("mark",mark);
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

			out.println("<script>alert('????????? ?????? ????????? ????????????.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
		
		
		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"????????????","/view/cart"},{"?????? ??????","/view/orderOkay"}};
		routeMap.put(0,routeArray[0]);
		routeMap.put(1,routeArray[1]);
	
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);

		model.addAttribute("breadcrumb",breadcrumbList);


		String pageTitle = "?????? ??????";
		model.addAttribute("pageTitle",pageTitle);
	

		return "user/order/orderOkay.page";
		}
	}
}
