package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.QnAVO;
import org.springframework.stereotype.Service;

@Service
public class QnADAOImpl implements QnADAO {

	

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.qnAMapper";
	
	@Override
	public int QnAInsert(QnAVO qnAVO) {
		HashMap<String,String> map = new HashMap<String, String>();
	
		int result = sqlSession.insert(Namespace+".QnAInsert",map);
		return result;
	}
	
	@Override
	public List<QnAVO> getQnAList(String pid) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql ="SELECT * FROM tbl_qna WHERE pid ='"+pid+"' ORDER BY qnaDate DESC";
		map.put("sql", sql);
		List<QnAVO> result = sqlSession.selectList(Namespace+".getQnAList", map);
		return result;
	}
}
