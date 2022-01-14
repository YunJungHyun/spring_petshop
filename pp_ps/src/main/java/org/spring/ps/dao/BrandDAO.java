package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import org.spring.ps.vo.BrandVO;

public interface BrandDAO {

	int brandInsert(BrandVO brandVO, HashMap<String, String> sql_dirMap);

	List<BrandVO> getBrandList();

	int brandDelete(String bnum);

	BrandVO getOneBrand(int bnum);

}
