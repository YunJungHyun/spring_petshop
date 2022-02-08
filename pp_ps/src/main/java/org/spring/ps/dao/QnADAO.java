package org.spring.ps.dao;

import java.util.List;

import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.UserVO;

public interface QnADAO {

	int insertQnA(QnAVO qnAVO);

	List<QnAVO> getQnAList(String pid);

	List<QnAVO> getAllQnAList();

	List<QnAVO> getReplyList(String qnaid);

	int answerInsert(QnAVO qnaVO);

	List<QnAVO> getQnACntList(String pid);

	List<QnAVO> getMyQnAList(String userid);

	List<QnAVO> getQnAEachCntList(String userid);

	int QnADelete(QnAVO qnaVO);

	int getMyQnACnt(UserVO userVO);


	
	
}
