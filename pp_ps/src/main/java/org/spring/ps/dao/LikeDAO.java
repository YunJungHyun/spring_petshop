package org.spring.ps.dao;

import org.spring.ps.vo.LikeVO;

public interface LikeDAO {

	int likeCheck(LikeVO likeVO);

	int likeInsert(LikeVO likeVO);

	int likeDelete(LikeVO likeVO);

	
	
}
