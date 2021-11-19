package org.spring.ps.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.ProductVO;

public interface ProductService {

	int productBaseInsert(ProductVO productVO);

	int productSlideImgUpload(JSONObject jsonObject, int pnum);

	List<ProductVO> productList();

	
}
