package org.spring.ps.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.ProductDAO;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService{

	
	@Inject
	private ProductDAO productDAO;
	
	@Override 
	public List<ProductVO> getProductList(PagingVO pagingVO,HashMap<String,String> pagingMap) {
		// TODO Auto-generated method stub
		return productDAO.getProductList(pagingVO, pagingMap);
	}
	
	@Override
	public int countProduct(HashMap<String,String> pagingMap) {
		// TODO Auto-generated method stub
		return productDAO.countProduct(pagingMap);
	} 
	
	
	@Override
	public ProductVO getProductOne(String pid) {
		// TODO Auto-generated method stub
		return productDAO.getProductOne(pid);
	}

	
}
