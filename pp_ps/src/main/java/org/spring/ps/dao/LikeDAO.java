package org.spring.ps.dao;

import org.spring.ps.vo.LikeVO;
import org.spring.ps.vo.UserVO;

public interface LikeDAO {

	int likeCheck(LikeVO likeVO);

	int likeInsert(LikeVO likeVO);

	int likeDelete(LikeVO likeVO);

	int getMyLikeCnt(UserVO userVO);

	
	
}
