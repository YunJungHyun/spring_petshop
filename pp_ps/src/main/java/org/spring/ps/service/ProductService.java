package org.spring.ps.service;

import java.util.HashMap;
import java.util.List;

import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.ProductVO;

public interface ProductService {


	List<ProductVO> getProductList( PagingVO pagingVO, HashMap<String,String> pagingMap);


	ProductVO getProductOne(String pid);




	int countProduct(HashMap<String,String> pagingMap);


	int stateChange(ProductVO productVO);


	int productInsert(ProductVO productVO, HashMap<String, String> sql_dirMap);


	int productUpdate(ProductVO productVO, HashMap<String, String> sql_dirMap);


	int productDelete(String pid);



	
}
