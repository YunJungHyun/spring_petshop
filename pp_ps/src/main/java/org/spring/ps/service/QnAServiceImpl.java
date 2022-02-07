package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.QnADAO;
import org.spring.ps.vo.QnAVO;
import org.springframework.stereotype.Service;

@Service
public class QnAServiceImpl implements QnAService{

	@Inject
	private QnADAO qnaDAO;
	
	
	@Override
	public int insertQnA(QnAVO qnAVO) {
		// TODO Auto-generated method stub
		return qnaDAO.insertQnA(qnAVO);
	}
	
	@Override
	public List<QnAVO> getQnAList(String pid) {
		// TODO Auto-generated method stub
		return qnaDAO.getQnAList(pid);
	}
	
	
	@Override
	public List<QnAVO> getAllQnAList() {
		// TODO Auto-generated method stub
		return qnaDAO.getAllQnAList();
	}
	
	@Override
	public List<QnAVO> getReplyList(String qnaid) {
		// TODO Auto-generated method stub
		return qnaDAO.getReplyList(qnaid);
	}
	
	@Override
	public int answerInsert(QnAVO qnaVO) {
		// TODO Auto-generated method stub
		return qnaDAO.answerInsert(qnaVO);
	}
	
	@Override
	public List<QnAVO> getQnACntList(String pid) {
		// TODO Auto-generated method stub
		return qnaDAO.getQnACntList(pid);
	}
}
