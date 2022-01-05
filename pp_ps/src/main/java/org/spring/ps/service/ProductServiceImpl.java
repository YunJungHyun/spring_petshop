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

	@Override
	public int stateChange(ProductVO productVO) {
		// TODO Auto-generated method stub
		return productDAO.stateChange(productVO);
	}
	
	@Override
	public int productInsert(ProductVO productVO, HashMap<String, String> sql_dirMap) {
		// TODO Auto-generated method stub
		return productDAO.productInsert(productVO,sql_dirMap);
	}
	
	@Override
	public int productUpdate(ProductVO productVO, HashMap<String, String> sql_dirMap) {
		// TODO Auto-generated method stub
		return  productDAO.productUpdate(productVO,sql_dirMap);
	}
	
	@Override
	public int productDelete(String pid) {
		// TODO Auto-generated method stub
		return productDAO.productDelete(pid);
	}
	
	@Override
	public void pcntDecrease(String pid, int cstock) {
		// TODO Auto-generated method stub
		
		 productDAO.pcntDecrease(pid,cstock);
		
	}
}
