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
import org.spring.ps.service.BrandService;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.QnAService;
import org.spring.ps.service.ReviewService;
import org.spring.ps.service.UserService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.BrandVO;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/adminView")
public class AdminViewController {

	Log log = LogFactory.getLog(this.getClass());


	@Inject
	private CategoryService categoryService;
	@Inject
	private ProductService productService;
	@Inject
	private OrderService orderService;
	@Inject
	private BrandService brandService;
	@Inject
	private UserService userService;
	@Inject
	private QnAService qnAService;
	
	@Inject
	private ReviewService reviewService;
	
	@RequestMapping(value="/member/{unum}", method=RequestMethod.GET)
	public String adminViewMember(
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

			log.debug("[adminView] userInfo : ??????????????????");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('????????? ??????????????? ????????????.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			String mark = null;
		
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
				mark ="userInfo";
				memberPage ="member/MemberDetail";
				break;
			}
			
			UserVO uvo=userService.getOneUser(unum);


			Map<Integer,String[]> routeMap = new HashMap<>();
			String routeArray[][] = {{"????????? ?????????","/adminView/Management"},{"?????? ??????","/adminView/Member"},{uvo.getUsername()+" ???","/user/"+unum}};
			routeMap.put(0,routeArray[0]);
			routeMap.put(1,routeArray[1]);
			routeMap.put(2,routeArray[2]);

			List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);
			model.addAttribute("categoryView","none");
			model.addAttribute("uvo", uvo);
			model.addAttribute("mark",mark);
			model.addAttribute("pageTitle","?????? ( "+uvo.getUsername()+"??? )");
			model.addAttribute("breadcrumb",breadcrumbList);

			return "admin/"+memberPage+".page";
		}
	}
	
	
	@RequestMapping("/{view}")
	public String adminView(
			@PathVariable("view") String view,
			HttpSession session,
			HttpServletResponse response,
			PagingVO pagingVO, 
			@RequestParam(value="pid", required= false) String pid,
			@RequestParam(value="ccoderef", required= false) String ccoderef,
			@RequestParam(value="ccode", required= false) String ccode,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="sortBy", required= false) String sortBy,
			@RequestParam(value="pstate", required= false) String pstate,
			Model model

			) throws IOException {


		//route
		Map<Integer,String[]> routeMap = new HashMap<>();
		


		if(page == null ) {

			page = "1";
		}

		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		log.debug("[adminView] userInfo :"+userInfo);

		List<ProductVO> pList = null;
		List<CategoryVO> cList = null;
		List<BrandVO> bList = null;
		ProductVO pvo = null;

		if(userInfo == null || userInfo.getUlevel() != 2) {

			log.debug("[adminView] userInfo : ??????????????????");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('????????? ??????????????? ????????????.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			String pageTitle = "";

			switch(view) {

			case "Management": 

				String routeArray1[][] = {{"????????? ?????????","/adminView/Management"}};
				routeMap.put(0,routeArray1[0]);
				
				pageTitle = "????????? ?????????";
				break;
			case "Product":
				if(ccoderef== null) {
					ccoderef = "";
				}
				if(ccode== null) {
					ccode = "";
				}
				if(pstate == null) {
					
					pstate = "";
				}
				
				if(sortBy == null) {
					sortBy = "";
				}
				
				
				HashMap<String,String> map = new HashMap();
				map.put("ccode",ccode);
				map.put("ccoderef",ccoderef);
				map.put("openState",pstate);
				map.put("openSortBy",sortBy);
				int total = productService.countProduct(map);
				log.debug("*****************total**********");
				log.debug(total);
				log.debug("*****************total**********");
			
				pagingVO = new PagingVO(total, Integer.parseInt(page), 20);


				pList = productService.getProductList(pagingVO,map);
				cList =categoryService.getCategoryList();

				model.addAttribute("pTotal", total);
				model.addAttribute("pList",pList);
				model.addAttribute("cList",cList);
				model.addAttribute("paging",pagingVO);
				model.addAttribute("pagingMap",map);

				log.debug("--------------------------------------");
				log.debug("ccode :"+ccode);
				log.debug("ccoderef :"+ ccoderef);
				log.debug("pstate :"+ pstate);
				log.debug("sortBy :"+ sortBy);
				log.debug("--------------------------------------");
				
				String routeArray2[][] = {{"????????? ?????????","/adminView/Management"},{"????????????","/adminView/Product"}};
				routeMap.put(0,routeArray2[0]);
				routeMap.put(1,routeArray2[1]);

				pageTitle = "?????? ??????";
				view = "product/ProductList";

				break;
			case "ProductInsert":

				cList =categoryService.getCategoryList();
				model.addAttribute("cList",cList);

				pageTitle = "?????? ??????";
				view = "product/ProductInsert";
				
				String routeArray3[][] = {{"????????? ?????????","/adminView/Management"},{"????????????","/adminView/Product"},{"?????? ??????","/adminView/ProductInsert"}};
				routeMap.put(0,routeArray3[0]);
				routeMap.put(1,routeArray3[1]);
				routeMap.put(2,routeArray3[2]);

				break;
			case "ProductUpdate":


				if(pid==null || pid.equals("undefined")) { 

					response.setContentType("text/html; charset=UTF-8");

					PrintWriter out = response.getWriter();

					out.println("<script>alert('?????? ????????? ?????? ?????? ??? ??? ????????????.'); location.href='/adminView/Product';</script>");

					out.flush();


				}else {
					cList =categoryService.getCategoryList();
					pvo =productService.getProductOne(pid);

					model.addAttribute("cList",cList);
					model.addAttribute("pvo",pvo);
					
					String routeArray4[][] = {{"????????? ?????????","/adminView/Management"},{"????????????","/adminView/Product"},{"?????? ??????","/adminView/ProductUpdate?pid="+pvo.getPid()}};
					routeMap.put(0,routeArray4[0]);
					routeMap.put(1,routeArray4[1]);
					routeMap.put(2,routeArray4[2]);

					pageTitle = "?????? ??????";
					view = "product/ProductUpdate";
				}	
				break;
			case "Member":
				
				
				int uTotal = userService.countUser();
				
				pagingVO = new PagingVO(uTotal, Integer.parseInt(page), 50);
				
				List<UserVO> uList = userService.getUserList(sortBy,pagingVO);
				
				String routeArray6[][] = {{"????????? ?????????","/adminView/Management"},{"?????? ??????","/adminView/Member"}};
				routeMap.put(0,routeArray6[0]);
				routeMap.put(1,routeArray6[1]);
				
				model.addAttribute("uList",uList);
				 

				pageTitle = "?????? ??????";
				view = "member/Member";

				break;
			case "QnA":
				
				
				
				List<QnAVO> qList =  qnAService.getAllQnAList();
				 
				String routeArray7[][] = {{"????????? ?????????","/adminView/Management"},{"?????? ??????","/adminView/QnA"}};
				routeMap.put(0,routeArray7[0]);
				routeMap.put(1,routeArray7[1]);
				
				
				model.addAttribute("qlist",qList);
			
				pageTitle = "Q&A ??????";
				view = "QnA/QnA";
				
				break;
			case "Addition": 
				
				String routeArray4[][] = {{"????????? ?????????","/adminView/Management"},{"????????????/????????? ??????","/adminView/Addition"}};
				routeMap.put(0,routeArray4[0]);
				routeMap.put(1,routeArray4[1]);
				cList =categoryService.getCategoryList();
				List<ProductVO> cpList = productService.getCountCategoryInProduct();
				bList = brandService.getBrandList();
				Gson gson = new GsonBuilder().create();
				String cpJSON = gson.toJson(cpList);
				
				model.addAttribute("cpJSON",cpJSON);
				model.addAttribute("bList",bList);
				model.addAttribute("cList",cList);
				pageTitle = "????????????/????????? ??????";
				view = "addition/Addition";
				

				break;
			case "Order": 
				
				List<OrderVO> oList = orderService.getAllOrderList();
				model.addAttribute("oList",oList);
				pageTitle = "?????? ??????"; 
				view = "order/Order";
				String routeArray5[][] = {{"????????? ?????????","/adminView/Management"},{"?????? ??????","/adminView/Order"}};
				routeMap.put(0,routeArray5[0]);
				routeMap.put(1,routeArray5[1]);
		
				
				break;
			case "Review": 
				
				List<ReviewVO> rList = reviewService.getAllReviewList();
				model.addAttribute("rList",rList);
				pageTitle = "???????????? ??????";
				view = "review/Review";
				String routeArray8[][] = {{"????????? ?????????","/adminView/Management"},{"?????? ?????? ??????","/adminView/Review"}};
				routeMap.put(0,routeArray8[0]);
				routeMap.put(1,routeArray8[1]);
				break;			
			}
			
			
			List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);


			model.addAttribute("breadcrumb", breadcrumbList);
			model.addAttribute("pageTitle", pageTitle);
			model.addAttribute("categoryView","none");
			return "admin/"+view+".page";
		}

	}

}
