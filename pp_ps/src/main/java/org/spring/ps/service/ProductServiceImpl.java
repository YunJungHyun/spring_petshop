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
	
	@Override
	public List<ProductVO> getRankProductList(PagingVO pagingVO,String categoryCode) {
		// TODO Auto-generated method stub
		return productDAO.getRankProductList(pagingVO,categoryCode);
	}
	@Override
	public List<ProductVO> getRecentProductList(PagingVO pagingVO,String categoryCode) {
		// TODO Auto-generated method stub
		return productDAO.getRecentProductList(pagingVO,categoryCode);
	}
	@Override
	public List<ProductVO> getSaleProductList(PagingVO pagingVO,String categoryCode) {
		// TODO Auto-generated method stub
		return productDAO.getSaleProductList(pagingVO,categoryCode);
	}
	
	@Override
	public int findRemainProduct(int ccode) {
		// TODO Auto-generated method stub
		return productDAO.findRemainProduct(ccode);
	}
	@Override
	public List<ProductVO> getCountCategoryInProduct() {
		// TODO Auto-generated method stub
		return productDAO.getCountCategoryInProduct();
	}
	
	
	
	@Override
	public int countRankProduct(String categoryCode) {
		// TODO Auto-generated method stub
		return  productDAO.countRankProduct(categoryCode);
	}
	
	@Override
	public int countRecentProduct(String categoryCode) {
		// TODO Auto-generated method stub
		return  productDAO.countRecentProduct(categoryCode);
	}
	
	@Override
	public int countNewSaleProduct(String categoryCode) {
		// TODO Auto-generated method stub
		return productDAO.countNewSaleProduct(categoryCode);
	}
	
	@Override
	public List<ProductVO> getBrandProductList(HashMap<String, String> sortMap,PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return productDAO.getBrandProductList(sortMap, pagingVO);
	}
	
	@Override
	public int countBrandProduct(HashMap<String, String> sortMap) {
		// TODO Auto-generated method stub
		return productDAO.countBrandProduct(sortMap);
	}
	
	@Override
	public List<ProductVO> userSearch(String q) {
		// TODO Auto-generated method stub
		return productDAO.userSearch(q);
	}
	
	
	@Override
	public List<ProductVO> getUserLikeProductList(String userid) {
		// TODO Auto-generated method stub
		return productDAO.getUserLikeProductList(userid);
	}
	
}
