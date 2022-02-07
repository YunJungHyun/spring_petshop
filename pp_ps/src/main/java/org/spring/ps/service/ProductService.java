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


	void pcntDecrease(String pid, int cstock);


	List<ProductVO> getSaleProductList(PagingVO pagingVO,String categoryCode);


	List<ProductVO> getRecentProductList(PagingVO pagingVO,String categoryCode); 


	List<ProductVO> getRankProductList(PagingVO pagingVO,String categoryCode);


	int findRemainProduct(int ccode);


	List<ProductVO> getCountCategoryInProduct();




	int countRankProduct(String categoryCode);


	int countRecentProduct(String categoryCode);


	int countNewSaleProduct(String categoryCode);


	List<ProductVO> getBrandProductList(HashMap<String, String> sortMap,PagingVO pagingVO);


	int countBrandProduct(HashMap<String, String> sortMap);


	List<ProductVO> userSearch(String q);


	List<ProductVO> getUserLikeProductList(String userid);




}
