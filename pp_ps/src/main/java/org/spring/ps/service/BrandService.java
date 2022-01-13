package org.spring.ps.service;

import java.util.HashMap;
import java.util.List;

import org.spring.ps.vo.BrandVO;

public interface BrandService {

	int brandInsert(BrandVO brandVO, HashMap<String, String> sql_dirMap);

	List<BrandVO> getBrandList();

	int brandDelete(String bnum);

}
