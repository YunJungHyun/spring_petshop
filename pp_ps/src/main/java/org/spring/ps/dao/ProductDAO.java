package org.spring.ps.dao;

import org.json.simple.JSONObject;
import org.spring.ps.vo.ProductVO;

public interface ProductDAO {

	int productBaseInsert(ProductVO productVO);

	int productSlideImgUpload(JSONObject jsonObject, int pnum);

	
}
