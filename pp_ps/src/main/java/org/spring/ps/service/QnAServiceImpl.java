package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.QnADAO;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.UserVO;
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
	@Override
	public List<QnAVO> getMyQnAList(String userid) {
		// TODO Auto-generated method stub
		return qnaDAO.getMyQnAList(userid);
	}
	
	@Override
	public List<QnAVO> getQnAEachCntList(String userid) {
		// TODO Auto-generated method stub
		return qnaDAO.getQnAEachCntList(userid);
	}
	
	@Override
	public int QnADelete(QnAVO qnaVO) {
		// TODO Auto-generated method stub
		return qnaDAO.QnADelete(qnaVO);
	}
	
	@Override
	public int getMyQnACnt(UserVO userVO) {
		// TODO Auto-generated method stub
		return qnaDAO.getMyQnACnt(userVO);
	}
}
