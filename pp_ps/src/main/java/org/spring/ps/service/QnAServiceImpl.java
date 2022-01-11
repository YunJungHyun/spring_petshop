package org.spring.ps.service;

import java.util.List;

import javax.inject.Inject;

import org.spring.ps.dao.QnADAO;
import org.spring.ps.vo.QnAVO;
import org.springframework.stereotype.Service;

@Service
public class QnAServiceImpl implements QnAService{

	@Inject
	private QnADAO qnADAO;
	
	@Override
	public int QnAInsert(QnAVO qnAVO) {
		// TODO Auto-generated method stub
		return qnADAO.QnAInsert(qnAVO);
	}
	
	@Override
	public List<QnAVO> getQnAList(String pid) {
		// TODO Auto-generated method stub
		return qnADAO.getQnAList(pid);
	}
}
