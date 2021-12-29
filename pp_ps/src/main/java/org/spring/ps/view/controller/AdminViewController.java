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
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.OrderListVO;
import org.spring.ps.vo.OrderVO;
import org.spring.ps.vo.PageInfoVO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

	@RequestMapping("/{view}")
	public String adminView(
			@PathVariable("view") String view,
			HttpSession session,
			HttpServletResponse response,
			PagingVO pagingVO, 
			@RequestParam(value="pid", required= false) String pid,
			@RequestParam(value="ccode", required= false) String ccode,
			@RequestParam(value="page", required= false) String page,
			@RequestParam(value="sortBy", required= false) String sortBy,
			@RequestParam(value="state", required= false) String state,
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
		ProductVO pvo = null;

		if(userInfo == null || userInfo.getUlevel() != 2) {

			log.debug("[adminView] userInfo : 접근권한없음");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('페이지 접근권한이 없습니다.'); location.href='/';</script>");

			out.flush();

			return "home.page";
		}else {
			String pageTitle = "";

			switch(view) {

			case "Management": 

				String routeArray1[][] = {{"관리자 페이지","/adminView/Management"}};
				routeMap.put(0,routeArray1[0]);
				
				pageTitle = "관리자 페이지";
				break;
			case "Product":
				

				if(ccode == null) {
					ccode = "000";
				}
				if(sortBy == null) {
					sortBy = "";
				}
				if(state == null) {
					state = "allState";
				}

				HashMap<String,String> map = new HashMap();


				map.put("openCcode",ccode);
				map.put("openSortBy",sortBy);
				map.put("openState",state);

				int total = productService.countProduct(map);

				pagingVO = new PagingVO(total, Integer.parseInt(page), 20);


				pList = productService.getProductList(pagingVO,map);
				cList =categoryService.getCategoryList();

				model.addAttribute("pTotal", total);
				model.addAttribute("pList",pList);
				model.addAttribute("cList",cList);
				model.addAttribute("paging",pagingVO);
				model.addAttribute("pagingMap",map);


				model.addAttribute("openCcode",ccode);
				String routeArray2[][] = {{"관리자 페이지","/adminView/Management"},{"제품관리","/adminView/Product"}};
				routeMap.put(0,routeArray2[0]);
				routeMap.put(1,routeArray2[1]);

				pageTitle = "제품 관리";
				view = "product/ProductList";

				break;
			case "ProductInsert":

				cList =categoryService.getCategoryList();
				model.addAttribute("cList",cList);

				pageTitle = "제품 등록";
				view = "product/ProductInsert";
				
				String routeArray3[][] = {{"관리자 페이지","/adminView/Management"},{"제품관리","/adminView/Product"},{"제품 등록","/adminView/ProductInsert"}};
				routeMap.put(0,routeArray3[0]);
				routeMap.put(1,routeArray3[1]);
				routeMap.put(2,routeArray3[2]);

				break;
			case "ProductUpdate":


				if(pid==null || pid.equals("undefined")) { 

					response.setContentType("text/html; charset=UTF-8");

					PrintWriter out = response.getWriter();

					out.println("<script>alert('제품 아이디 없이 접근 할 수 없습니다.'); location.href='/adminView/Product';</script>");

					out.flush();


				}else {
					cList =categoryService.getCategoryList();
					pvo =productService.getProductOne(pid);

					model.addAttribute("cList",cList);
					model.addAttribute("pvo",pvo);
					
					String routeArray4[][] = {{"관리자 페이지","/adminView/Management"},{"제품관리","/adminView/Product"},{"제품 수정","/adminView/ProductUpdate?pid="+pvo.getPid()}};
					routeMap.put(0,routeArray4[0]);
					routeMap.put(1,routeArray4[1]);
					routeMap.put(2,routeArray4[2]);

					pageTitle = "제품 수정";
					view = "product/ProductUpdate";
				}	
				break;
			case "Member":


				pageTitle = "회원 관리";
				view = "member/Member";

				break;
			case "QnA":

				pageTitle = "Q&A 관리";
				view = "QnA/QnA";

				break;
			case "Notice": 

				pageTitle = "공지사항 관리";
				view = "notice/Notice";

				break;
			case "Order": 
				
				List<OrderVO> oList = orderService.getAllOrderList();
				model.addAttribute("oList",oList);
				pageTitle = "주문 관리"; 
				view = "order/Order";
				String routeArray5[][] = {{"관리자 페이지","/adminView/Management"},{"주문 관리","/adminView/Order"}};
				routeMap.put(0,routeArray5[0]);
				routeMap.put(1,routeArray5[1]);
		
				
				break;
			case "Review": 

				pageTitle = "구매후기 관리";
				view = "review/Review";

				break;			
			}
			
			
			List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);


			model.addAttribute("breadcrumb", breadcrumbList);
			model.addAttribute("pageTitle", pageTitle);
			return "admin/"+view+".page";
		}

	}

}
