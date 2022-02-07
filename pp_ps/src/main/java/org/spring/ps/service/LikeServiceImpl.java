package org.spring.ps.service;

import javax.inject.Inject;

import org.spring.ps.dao.LikeDAO;
import org.spring.ps.vo.LikeVO;
import org.springframework.stereotype.Service;

@Service
public class LikeServiceImpl implements LikeService{
	
	@Inject
	private LikeDAO likeDAO;
	


	@Override
	public int likeCheck(LikeVO likeVO) {
		// TODO Auto-generated method stub
		return likeDAO.likeCheck(likeVO);
	}
	
	@Override
	public int likeInsert(LikeVO likeVO) {
		// TODO Auto-generated method stub
		return likeDAO.likeInsert(likeVO);
	}
	
	@Override
	public int likeDelete(LikeVO likeVO) {
		// TODO Auto-generated method stub
		return likeDAO.likeDelete(likeVO);
	}
}
