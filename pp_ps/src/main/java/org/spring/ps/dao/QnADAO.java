package org.spring.ps.dao;

import java.util.List;

import org.spring.ps.vo.QnAVO;

public interface QnADAO {

	int QnAInsert(QnAVO qnAVO);

	List<QnAVO> getQnAList(String pid);

	
	
}
