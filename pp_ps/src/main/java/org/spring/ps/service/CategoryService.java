package org.spring.ps.service;

import java.util.List;
import java.util.Map;

import org.spring.ps.vo.CategoryVO;

public interface CategoryService {

	int categoryInsert(Map<String, Object> categoryData);

	List<CategoryVO> categoryList();

}
