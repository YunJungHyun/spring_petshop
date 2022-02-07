package org.spring.ps.service;

import org.spring.ps.vo.LikeVO;

public interface LikeService {

	int likeCheck(LikeVO likeVO);

	int likeInsert(LikeVO likeVO);

	int likeDelete(LikeVO likeVO);
	
	
}
