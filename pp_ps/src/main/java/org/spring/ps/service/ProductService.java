package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;

public interface ProductService {

	int productInsert(ProductVO productVO);

	
	int productRegUpdate(int pnum, String imgPath, String fileName);


	List<ProductVO> getProductList(String openCcode, PagingVO pagingVO);


	ProductVO getProductOne(String pid);


	int productUpdate(ProductVO productVO, String path, String fileName);


	List<ProductVO> getUserProductList(String ccode, String ccoderef);


	int countProduct(String openCcode);



	
}
