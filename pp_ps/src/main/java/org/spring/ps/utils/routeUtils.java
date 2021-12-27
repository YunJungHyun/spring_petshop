package org.spring.ps.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.spring.ps.vo.PageInfoVO;

public class routeUtils {

	
	public static List<PageInfoVO> pageInfo( Map<Integer, String[]> routeMap){
		
		PageInfoVO pageInfoVO =null;
		System.out.println(routeMap.size());
		
		List<PageInfoVO> pageInfoList = new ArrayList<PageInfoVO>();
		for(int i = 0 ; i <routeMap.size() ; i++) {
			
			String routeArray[] =routeMap.get(i);
			pageInfoVO = new PageInfoVO();
			
			
			pageInfoVO.setPageName(routeArray[0]);
			pageInfoVO.setPageHref(routeArray[1]);
			
			pageInfoList.add(pageInfoVO);
			
		}
		
		return pageInfoList;
		
	}
}
