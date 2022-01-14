package org.spring.ps.view.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.utils.routeUtils;
import org.spring.ps.vo.PageInfoVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {
	
	Log log = LogFactory.getLog(this.getClass());
	
	@RequestMapping(value="/{unum}", method=RequestMethod.GET)
	public String userDetail(
			Model model,
			@PathVariable(value="unum", required = true) String unum
			) {
		
		
		Map<Integer,String[]> routeMap = new HashMap<>();
		String routeArray[][] = {{"회원","/product/view/brand"}};
		routeMap.put(0,routeArray[0]);
		
		List<PageInfoVO> breadcrumbList =routeUtils.pageInfo(routeMap);
		model.addAttribute("breadcrumb",breadcrumbList);
		
		return "admin/member/memberDetail.page";
	}

}
