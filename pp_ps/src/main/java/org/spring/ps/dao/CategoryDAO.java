package org.spring.ps.dao;

import java.util.List;
import java.util.Map;

import org.spring.ps.vo.CategoryVO;

public interface CategoryDAO {

	int categoryInsert(Map<String, Object> categoryData);

	List<CategoryVO> categoryList();

}
