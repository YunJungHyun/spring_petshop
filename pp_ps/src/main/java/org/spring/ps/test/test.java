package org.spring.ps.test;



import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class test {

	Log log = LogFactory.getLog(this.getClass());

	@RequestMapping(value="/sample/openSampleList.do") 
	public ModelAndView openSampleList(Map<String,Object> commandMap) throws Exception{ 

		ModelAndView mv = new ModelAndView(""); 
		log.debug("인터셉터 테스트"); 
		return mv; 
	}

}
