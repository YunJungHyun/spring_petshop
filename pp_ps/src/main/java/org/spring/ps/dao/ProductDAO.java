package org.spring.ps.dao;

import java.util.List;

import org.json.simple.JSONObject;
import org.spring.ps.vo.CategoryVO;
import org.spring.ps.vo.ProductVO;

public interface ProductDAO {

	int productInsert(ProductVO productVO);

	int productRegUpdate(int pnum,String imgPath, String fileName);

	List<ProductVO> getProductList();

	ProductVO getProductOne(String pid);

	int productUpdate(ProductVO productVO, String path, String fileName);

	List<ProductVO> getUserProductList(String ccode, String ccoderef); 



	
}
