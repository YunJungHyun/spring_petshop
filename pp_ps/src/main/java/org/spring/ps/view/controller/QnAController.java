package org.spring.ps.view.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.OrderService;
import org.spring.ps.service.QnAService;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/QnA")
public class QnAController {

	Log log = LogFactory.getLog(this.getClass());
	
	@Inject
	private QnAService qnaService;
	
	@Inject 
	private OrderService orderService;
	
	
	
	@RequestMapping(value="/answerInsert",method=RequestMethod.POST)
	@ResponseBody
	public int answerInsert(
			HttpSession session,
			QnAVO qnaVO 
			) {
		
		UserVO userVO =(UserVO)session.getAttribute("userInfo");
		log.debug("[answerInsert] :"+ qnaVO.toString());
		
		qnaVO.setUserid(userVO.getUserid());
		
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		Random random = new Random();

		String randomStr = random.ints(leftLimit,rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
				.limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
				.toString();

		String qnaid = "q_"+randomStr;
		 
		qnaVO.setQnaid(qnaid);
		
		
		int result = qnaService.answerInsert(qnaVO);
		
		
		return result;		
	}
	
	
	@RequestMapping(value="/AdminReplyList", method=RequestMethod.POST)
	@ResponseBody
	public List<QnAVO> AdminReplyList(
		
			@RequestParam(value="qnaid" , required = true) String qnaid
			
			) {
		
		
	
		
		List<QnAVO> qnaList = qnaService.getReplyList(qnaid);
		
		
	
		
		return qnaList;
	}
	
	
	
	@RequestMapping(value="/QuestionInsert")
	@ResponseBody
	public String QnAInsert(
			HttpSession session,
			HttpServletResponse response,
			QnAVO qnAVO
			) throws IOException { 
		
		
		
		UserVO userVO = (UserVO)session.getAttribute("userInfo");
		
		if(userVO == null ) {
			
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('로그인 후 이용가능합니다.'); window.history.back();</script>");

			out.flush();

			return "home.page";
		}else {
			
			qnAVO.setUserid(userVO.getUserid());
			
			int leftLimit = 48; // numeral '0'
			int rightLimit = 122; // letter 'z'
			int targetStringLength = 8;
			Random random = new Random();

			String randomStr = random.ints(leftLimit,rightLimit + 1)
					.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
					.limit(targetStringLength)
					.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
					.toString();

			String qnaid = "q_"+randomStr;
			 
			qnAVO.setQnaid(qnaid);
			
			log.debug(qnAVO.toString());
			
			int result = qnaService.insertQnA(qnAVO);
			
			
			
			return  Integer.toString(result);
		}
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	@ResponseBody
	public String QnADelete(
			@RequestParam(value="qnaid") String qnaid,
			HttpSession session
			,HttpServletResponse response
			) throws IOException {
		UserVO userInfo = (UserVO)session.getAttribute("userInfo");
		int result =0 ;
		if(userInfo == null) {
			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('로그인 후 이용가능합니다.'); window.history.back();</script>");

			out.flush();

			return "home.page";
		}else {
			QnAVO qnaVO = new QnAVO();
			qnaVO.setQnaid(qnaid);
			result = qnaService.QnADelete(qnaVO);
		}
		return Integer.toString(result);
	}
}
