package org.spring.ps.service;

import java.util.HashMap;
import java.util.List;

import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;

public interface ProductService {


	List<ProductVO> getProductList( PagingVO pagingVO, HashMap<String,String> pagingMap);


	ProductVO getProductOne(String pid);




	int countProduct(HashMap<String,String> pagingMap);



	
}
