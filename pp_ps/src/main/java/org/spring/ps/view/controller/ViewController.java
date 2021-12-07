package org.spring.ps.view.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.CategoryService;
import org.spring.ps.service.ProductService;
import org.spring.ps.service.UserService;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import lombok.RequiredArgsConstructor;
import net.sf.json.JSONArray;

@RequiredArgsConstructor
@Controller
@RequestMapping("/view")
public class ViewController {



	Log log = LogFactory.getLog(this.getClass());


	@Inject
	private CategoryService categoryService;
	@Inject
	private ProductService productService;
	@Inject
	private UserService userService;

	@RequestMapping(value="/main/petshop")
	public String home(
			Model model
			) {


		log.debug("home");  


		String pageTitle = "HOME"; 
		
		List<CategoryVO> cList = categoryService.getCategoryList();

		model.addAttribute("cList",JSONArray.fromObject(cList));
		model.addAttribute("pageTitle", pageTitle);

		return "main.page"; 
	}


	@RequestMapping(value="/user/signUpSort")
	public String joinsort(
			Model model
			) {


		log.debug("signUpSort"); 

		String pageTitle = "회원가입 유형"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/signUpSort.page"; 
	}

	@RequestMapping(value="/user/signUpPage")
	public String join(
			Model model
			) {

		log.debug("signUpPage"); 

		String pageTitle = "회원가입"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/signUpPetShop.page"; 
	}

	@RequestMapping(value="/user/joinInPage")
	public String joinIn(
			Model model
			) {

		log.debug("joinInPage"); 

		String pageTitle = "로그인"; 

		model.addAttribute("pageTitle", pageTitle);

		return "user/joinIn.page"; 
	}

	@RequestMapping(value="/admin/loginPage")
	public String adminLoginPage(
			Model model
			) {

		log.debug("adminLoginPage"); 

		String pageTitle = "관리자 로그인"; 

		model.addAttribute("page" , "admin");
		model.addAttribute("pageTitle", pageTitle);

		return "admin/adminLogin.page"; 
	}




	@RequestMapping(value="/admin/managementPage")
	public String adminManageMentPage(
			Model model
			) {

		log.debug("[adminManageMentPage]"); 

		String pageTitle = "관리자 페이지"; 

		model.addAttribute("page" , "admin");
		model.addAttribute("pageTitle", pageTitle);

		return "admin/adminManagement.page"; 
	}

	
	@RequestMapping(value="/product", method = RequestMethod.GET)
	public String product(
			Model model,
			@RequestParam(value = "ccode" , required=false) String ccode,
			@RequestParam(value = "ccoderef" , required=false) String ccoderef
			) {
		
		log.debug("[product]");
		String pageTitle = "제품"; 
		
		List<CategoryVO> cList = categoryService.getCategoryList();
		List<ProductVO> pList = productService.getUserProductList(ccode,ccoderef);
		
		Gson gson = new Gson();

		
		model.addAttribute("pList",gson.toJson(pList,List.class).toString());
		model.addAttribute("cList",JSONArray.fromObject(cList));
		model.addAttribute("pageTitle", pageTitle);
		
		
		return "user/product.page";
	}
	

	@RequestMapping(value="/admin/go/{page}")
	public String adminPage(
			@PathVariable("page") String page,
			@RequestParam(value="pid",required= false ) String pid,
			Model model
			) {

		log.debug("[adminPage] :"+page);
		String pageTitle = null; 
		Gson gson = new Gson();
		List<CategoryVO> cList = null;
		List<ProductVO> pList = null;
		List<UserVO> uList = null;
		
		switch(page) {

		case "prodListPage" : 

			pageTitle = "제품 목록";


			cList = categoryService.getCategoryList();
			pList = productService.getProductList();
			page = "product/"+page;

			log.debug("[prodListPage] pList.size():"+pList.size());

			gson = new Gson();

			model.addAttribute("pList",gson.toJson(pList,List.class).toString());
			model.addAttribute("cList",JSONArray.fromObject(cList));

			break;
		case "productInsertPage" : 

			pageTitle = "제품 등록"; 

			cList = categoryService.getCategoryList();

			model.addAttribute("cList",JSONArray.fromObject(cList));
			page = "product/"+page;
			break;

		case "productUpdatePage" : 

			pageTitle = "제품 수정"; 

			log.debug("[productUpdatePage] pid : "+pid);

			ProductVO pvo = productService.getProductOne(pid);
			log.debug("[productUpdatePage] pvo : "+pvo.toString());


			cList = categoryService.getCategoryList();

			model.addAttribute("pvo" , pvo);
			model.addAttribute("cList" , JSONArray.fromObject(cList));

			page = "product/"+page;
			break;

		case "QnAListPage" : 

			pageTitle = "제품 QnA"; 


			page = "QnA/"+page;
			break;		
		case "userListPage" : 
			
			pageTitle = "회원관리"; 
			
			uList = userService.getUserList();
			
			page = "member/"+page;
			break;		
		case "notiseListPage" : 
			
			pageTitle = "공지사항"; 
			
			
			page = "notise/"+page;
			break;		
		}
		


	model.addAttribute("pageTitle" , pageTitle);
	model.addAttribute("page" , "admin");

	return "admin/"+page+".page";
}


}
