package org.spring.ps.view.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/adminView")
public class AdminViewController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping("/management")
	public ModelAndView adminManagement(Model model, HttpSession session,HttpServletResponse response) throws IOException {
		
		
		String pageTitle = "관리자 페이지";
		model.addAttribute("pageTitle",pageTitle);
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
	
		ModelAndView mav = new ModelAndView();
		String chkStr= adminChk(userVO); 
	

		log.debug("[adminManagement] chkStr :"+chkStr);
		
		if(chkStr.equals("adminNo") || chkStr.equals("")  ) {
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			 
			out.println("<script>alert('해당 페이지에 접근권한이 없습니다.'); location.href='/';</script>");
			 
			out.flush();
			  
			
		}else {
			mav.setViewName("/admin/management.page");
			
		}
		
		return mav;
		
	}
	
	public String adminChk(UserVO userVO) {
		
		String chkStr ="";
		
		if(userVO == null) {
			
			chkStr = "adminNo";
		}else {
			
			if(userVO.getUlevel() !=2) {
				chkStr = "adminNo";
			}else {
			
			chkStr = "adminOkay";
			}
		}
		return chkStr;
	}
	
}
