package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;

public interface ProductService {


	List<ProductVO> getProductList(String openCcode, PagingVO pagingVO);


	ProductVO getProductOne(String pid);




	int countProduct(String openCcode);



	
}
