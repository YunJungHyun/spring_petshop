package org.spring.ps.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.spring.ps.dao.CategoryDAO;
import org.spring.ps.vo.CategoryVO;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl implements CategoryService {

	
	@Inject
	private CategoryDAO categoryDAO;
	
	@Override
	public int categoryInsert(Map<String, Object> categoryData) {
	
		return categoryDAO.categoryInsert(categoryData);
	}
	
	@Override
	public List<CategoryVO> categoryList() {
		
		return categoryDAO.categoryList();
	}
	
	@Override
	public int categoryUpdate(CategoryVO categoryVO) {
		// TODO Auto-generated method stub
		return  categoryDAO.categoryUpdate(categoryVO);
	}
}
