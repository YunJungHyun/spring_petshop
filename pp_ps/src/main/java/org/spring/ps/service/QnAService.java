package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.QnAVO;

public interface QnAService {

	int insertQnA(QnAVO qnAVO);

	List<QnAVO> getQnAList(String pid);

	List<QnAVO> getAllQnAList();

	List<QnAVO> getReplyList(String qnaid);

	int answerInsert(QnAVO qnaVO);

	List<QnAVO> getQnACntList(String pid);




}
