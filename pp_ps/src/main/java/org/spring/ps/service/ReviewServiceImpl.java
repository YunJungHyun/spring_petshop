package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.ReviewDAO;
import org.spring.ps.vo.ReviewDetailVO;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	
	@Inject
	ReviewDAO reviewDAO;
	
	@Override
	public int canReviewCnt(UserVO userVO) {
		// TODO Auto-generated method stub
		return reviewDAO.canReviewCnt(userVO);
	}
	
	
	@Override
	public List<ReviewDetailVO> getCanReviewList(UserVO userVO) {
		// TODO Auto-generated method stub
		return  reviewDAO.getCanReviewList(userVO);
	}
	
	@Override
	public int reviewInsert(ReviewVO reviewVO) {
		// TODO Auto-generated method stub
		return reviewDAO.reviewInsert(reviewVO);
	}
	
	@Override
	public int reviewCnt(UserVO userVO) {
		// TODO Auto-generated method stub
		return  reviewDAO.reviewCnt(userVO);
	}
	
	@Override
	public List<ReviewDetailVO> getReviewList(UserVO userVO) {
		// TODO Auto-generated method stub
		return reviewDAO.getReviewList(userVO);
	}
	
	@Override
	public List<ReviewDetailVO> getProdOneReviewList(String pid) {
		// TODO Auto-generated method stub
		return reviewDAO.getProdOneReviewList(pid);
	}
	
	@Override
	public List<ReviewVO> getAllReviewList() {
		// TODO Auto-generated method stub
		return reviewDAO.getAllReviewList();
	}
	
	@Override
	public int reviewDelete(ReviewVO reviewVO ) {
		// TODO Auto-generated method stub
		return reviewDAO.reviewDelete(reviewVO);
	}
	
}
