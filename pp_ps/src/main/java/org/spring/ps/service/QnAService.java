package org.spring.ps.service;

import java.util.List;

import org.spring.ps.vo.QnAVO;

public interface QnAService {

	int QnAInsert(QnAVO qnAVO);

	List<QnAVO> getQnAList(String pid);

}
