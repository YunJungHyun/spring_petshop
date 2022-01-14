package org.spring.ps.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.BrandDAO;
import org.spring.ps.vo.BrandVO;
import org.springframework.stereotype.Service;

@Service
public class BrandServiceImpl implements BrandService{
	
	@Inject
	private BrandDAO brandDAO;
	@Override
	public int brandInsert(BrandVO brandVO, HashMap<String, String> sql_dirMap) {
		// TODO Auto-generated method stub
		return brandDAO.brandInsert(brandVO,sql_dirMap);
	}
	@Override
	public List<BrandVO> getBrandList() {
		// TODO Auto-generated method stub
		return brandDAO.getBrandList();
	}
	@Override
	public int brandDelete(String bnum) {
		// TODO Auto-generated method stub
		return brandDAO.brandDelete(bnum);
	}
	
	@Override
	public BrandVO getOneBrand(int bnum) {
		// TODO Auto-generated method stub
		return brandDAO.getOneBrand(bnum);
	}
}
