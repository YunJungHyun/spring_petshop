package org.spring.ps.dao;

import java.util.List;
import java.util.Map;

import org.spring.ps.vo.CategoryVO;

public interface CategoryDAO {

	
	
	List<CategoryVO> getCategoryList();

	int categoryChk(String cname);

	int categoryInsert(int parentCategory, String cname);

	String getCategoryOne(String openCcode);

	int insertSubCategory(CategoryVO categoryVO);

	int insertParentCategory(CategoryVO categoryVO);
	
	int deleteSubCategory(int ccode);

	List<CategoryVO> getNewSaleCategoryList();

	
	
}
