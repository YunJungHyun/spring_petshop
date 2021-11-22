package org.spring.ps.service;

import java.util.List;
import java.util.Map;

import org.spring.ps.vo.CategoryVO;

public interface CategoryService {

	List<CategoryVO> getCategoryList();

	int categoryChk(String cname);

	int categoryInsert(int parentCategory, String cname);

	

}
