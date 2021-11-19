package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.spring.ps.dao.ProductDAO;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService{

	
	@Inject
	private ProductDAO productDAO;
	
	@Override
	public int productBaseInsert(ProductVO productVO) {
		
		return productDAO.productBaseInsert(productVO);
	}
	
	@Override
	public int productSlideImgUpload(JSONObject jsonObject, int pnum) {
		
		return productDAO.productSlideImgUpload(jsonObject, pnum);
	}
	
	@Override
	public List<ProductVO> productList() {
		// TODO Auto-generated method stub
		return productDAO.productList();
	}
}
