package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.spring.ps.dao.ProductDAO;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService{

	
	@Inject
	private ProductDAO productDAO;
	
	@Override
	public int productInsert(ProductVO productVO) {
		
		return productDAO.productInsert(productVO);
	}
	 
	@Override
	public int productRegUpdate(int pnum, String imgPath, String fileName) {
		// TODO Auto-generated method stub
		return productDAO.productRegUpdate(pnum,imgPath,fileName);
	}
	@Override
	public List<ProductVO> getProductList() {
		// TODO Auto-generated method stub
		return productDAO.getProductList();
	}
	
	
	@Override
	public ProductVO getProductOne(String pid) {
		// TODO Auto-generated method stub
		return productDAO.getProductOne(pid);
	}
	
	@Override
	public int productUpdate(ProductVO productVO, String path, String fileName) {
		// TODO Auto-generated method stub
		return productDAO.productUpdate(productVO,path,fileName);
	}
}
