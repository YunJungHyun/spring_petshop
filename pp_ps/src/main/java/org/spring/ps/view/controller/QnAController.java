package org.spring.ps.view.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.QnAService;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/QnA")
public class QnAController {

	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private QnAService qnAService;
	@RequestMapping(value="/QuestionInsert")
	@ResponseBody
	public String QnAInsert(
			HttpSession session,
			HttpServletResponse response,
			QnAVO qnAVO
			) throws IOException {
		
		log.debug(qnAVO.toString());
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		if(userVO == null ) {
			
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('로그인 후 이용가능합니다.'); window.history.back();</script>");

			out.flush();

			return "home.page";
		}else {
			
			
			
			return  "";
		}
	}
}
