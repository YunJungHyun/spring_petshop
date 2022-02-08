package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.QnAVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class QnADAOImpl implements QnADAO {

 

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.qnaMapper";


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
	
	@Override
	public List<QnAVO> getMyQnAList(String userid) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql=" SELECT tq.* , tp.pimg , tp.pname, tp.pid FROM tbl_qna AS tq  ";
			sql+= " INNER JOIN tbl_product AS tp ";
			sql+= " ON tp.pid = tq.pid  ";
			sql+= " WHERE userid = '"+userid+"' AND parentid IS NULL ";
			sql+= " ORDER BY qnaDate desc; ";
		
		map.put("sql", sql);
		List<QnAVO> result= sqlSession.selectList(Namespace+".getMyQnAList",map);
		return result;
	}
	
	@Override
	public List<QnAVO> getQnAEachCntList(String userid) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql=" SELECT tq_b.parentid,count(*) as eachCnt FROM tbl_qna AS tq_b ";
		sql+=" INNER JOIN ( SELECT qnaid  FROM tbl_qna  WHERE userid ='"+userid+"' ) AS tq_c ";
		sql+=" ON tq_c.qnaid = tq_b.parentid ";
		sql+=" GROUP BY tq_b.parentid ";
		
		map.put("sql", sql);
		List<QnAVO> result= sqlSession.selectList(Namespace+".getQnAEachCntList",map);
		return result;
	}
	
	@Override
	public int QnADelete(QnAVO qnaVO) {
		HashMap<String,String> map = new HashMap<String, String>();
		
		String sql = "DELETE FROM tbl_qna WHERE qnaid='"+qnaVO.getQnaid()+"' OR parentid='"+qnaVO.getQnaid()+"'";
		map.put("sql", sql);
		int result = sqlSession.delete(Namespace+".QnADelete",map);
		return result;
	}
	
	@Override
	public int getMyQnACnt(UserVO userVO) {
		HashMap<String,String> map = new HashMap<String, String>();
		String sql ="SELECT COUNT(*) FROM tbl_qna ";
				sql+= " WHERE userid='"+userVO.getUserid()+"'";
		map.put("sql", sql);
		int result = sqlSession.selectOne(Namespace+".getMyQnACnt",map);
		return result;
	}
}
