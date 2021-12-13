package org.spring.ps.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;

public interface ProductService {

	int productInsert(ProductVO productVO);

	
	int productRegUpdate(int pnum, String imgPath, String fileName);


	List<ProductVO> getProductList(String openCcode);


	ProductVO getProductOne(String pid);


	int productUpdate(ProductVO productVO, String path, String fileName);


	List<ProductVO> getUserProductList(String ccode, String ccoderef);



	
}
