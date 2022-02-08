package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.ReviewDetailVO;
import org.spring.ps.vo.ReviewVO;
import org.spring.ps.vo.UserVO;

public interface ReviewService {

	int canReviewCnt(UserVO userVO);

	List<ReviewDetailVO> getCanReviewList(UserVO userVO);

	int reviewInsert(ReviewVO reviewVO);

	int reviewCnt(UserVO userVO);

	List<ReviewDetailVO> getReviewList(UserVO userVO);

	List<ReviewDetailVO> getProdOneReviewList(String pid);

	List<ReviewVO> getAllReviewList();

	int reviewDelete(String revNum);

	
	
}
