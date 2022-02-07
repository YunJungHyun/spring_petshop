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
	public int insertQnA(QnAVO qnAVO) {

		HashMap<String,String> map = new HashMap<String, String>();

		String sql = "INSERT INTO tbl_qna(qnaid,userid,qnaContent,pid)  ";
		sql+= " VALUES('"+qnAVO.getQnaid()+"', ";
		sql+= " '"+qnAVO.getUserid()+"', ";
		sql+= " '"+qnAVO.getQnaContent()+"', ";
		sql+= " '"+qnAVO.getPid()+"') ";

		map.put("sql", sql);

		int result = sqlSession.insert(Namespace+".insertQnA",map);


		return result;
	}

	@Override
	public List<QnAVO> getQnAList(String pid) {
		HashMap<String,String> map = new HashMap<String, String>();

		String sql = "SELECT tq.*,  tu.username FROM tbl_qna AS tq ";
		sql+=" 	INNER JOIN tbl_user AS tu ";
		sql+=" ON tu.userid = tq.userid ";
		sql+= " WHERE pid ='"+pid+"'";
		sql+= " ORDER BY qnaDate DESC";

		map.put("sql", sql);

		List<QnAVO> result = sqlSession.selectList(Namespace+".getQnAList",map);
		return result;
	}
	
	@Override
	public List<QnAVO> getAllQnAList() {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql = " SELECT tq.*,tu.username, tp.pname, tp.pimg, tc_a.cname AS cname,tc.cname AS subcname FROM tbl_qna AS tq ";
			sql+= " INNER JOIN tbl_user AS tu ";
			sql+= " ON tq.userid = tu.userid ";
			sql+= " INNER JOIN tbl_product As tp ";
			sql+= " ON tp.pid = tq.pid ";
			sql+= " INNER JOIN tbl_category AS tc ";
			sql+= " ON tc.ccode = tp.pccode ";
			sql+= " INNER JOIN tbl_category AS tc_a ";
			sql+= " ON tc.ccoderef = tc_a.ccode ";
			sql+= " ORDER BY qnaDate DESC ";
		
		map.put("sql", sql);

		List<QnAVO> result = sqlSession.selectList(Namespace+".getAllQnAList",map);
		return result;
	}
	
	@Override
	public List<QnAVO> getReplyList(String qnaid) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql = " SELECT tq.*,tu.username FROM tbl_qna as tq ";
				sql += " INNER JOIN tbl_user as tu ";
				sql += " ON tu.userid = tq.userid ";
				sql+= " WHERE parentid = '"+qnaid+"'";
				sql+=" ORDER BY qnaDate ASC";
		
		
		map.put("sql", sql);
		List<QnAVO> result = sqlSession.selectList(Namespace+".getReplyList",map);
		return result;
	}
	
	@Override
	public int answerInsert(QnAVO qnaVO) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql =" INSERT INTO tbl_qna(qnaid,userid,parentid,qnaContent,pid) ";
				sql+=" VALUES('"+qnaVO.getQnaid()+"','"+qnaVO.getUserid()+"','"+qnaVO.getParentid()+"','"+qnaVO.getQnaContent()+"','"+qnaVO.getPid()+"') ";
		map.put("sql", sql);
		int result = sqlSession.insert(Namespace+".answerInsert",map);
		return result;
	}
	
	@Override
	public List<QnAVO> getQnACntList(String pid) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql="SELECT parentid, COUNT(*) AS eachCnt FROM tbl_qna WHERE pid= '"+pid+"' and parentid is NOT NULL  GROUP BY parentid";
		map.put("sql", sql);
		List<QnAVO> result= sqlSession.selectList(Namespace+".getQnACntList",map);
		return result;
	}
}
