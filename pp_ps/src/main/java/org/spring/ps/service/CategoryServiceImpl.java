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
	public List<CategoryVO> getCategoryList() {
		// TODO Auto-generated method stub
		return categoryDAO.getCategoryList();
	}
	
	@Override
	public int categoryChk(String cname) {
		// TODO Auto-generated method stub
		return categoryDAO.categoryChk(cname);
	}
	
	@Override
	public int categoryInsert(int parentCategory, String cname) {
		// TODO Auto-generated method stub
		return categoryDAO.categoryInsert(parentCategory,cname);
	}
	
	@Override
	public String getCategoryOne(String openCcode) {
		// TODO Auto-generated method stub
		return categoryDAO.getCategoryOne(openCcode);
	}
}
