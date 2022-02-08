package org.spring.ps.service;

import org.spring.ps.vo.LikeVO;
import org.spring.ps.vo.UserVO;

public interface LikeService {

	int likeCheck(LikeVO likeVO);

	int likeInsert(LikeVO likeVO);

	int likeDelete(LikeVO likeVO);

	int getMyLikeCnt(UserVO userVO);
	
	
}
