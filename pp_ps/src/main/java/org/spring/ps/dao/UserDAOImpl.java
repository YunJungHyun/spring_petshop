package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.PagingVO;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

@Service
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;
	
	Log log =LogFactory.getLog(this.getClass());
	
	private static final String Namespace = "org.spring.ps.mapper.userMapper";
	
	@Override
	public UserVO getOneUserInfo(HashMap<String,Object> userInfo) {
		
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM tbl_user WHERE userid = '"+userInfo.get("userid")+"' "
				+ "AND utype = '"+userInfo.get("utype")+"'";
		
	
		map.put("sql", sql);
		
		UserVO result  = sqlSession.selectOne(Namespace+".getOneUserInfo", map);
		
		
		return result;
		
		
		
	}
	
	@Override
	public void authSignUp(HashMap<String,Object> userInfo) {
		HashMap<String, String> map = new HashMap();
		
		log.debug("[authSignUp] userInfo.toString():" +userInfo.toString());
		String sql ="INSERT INTO "
				+ "tbl_user(userid,username,uemail,ulevel,utype) "
				+ "VALUES ('"+userInfo.get("userid")+"','"+userInfo.get("username")+"','"+userInfo.get("uemail")+"',1,'"+userInfo.get("utype")+"'"
							
						+ ")";			
		map.put("sql", sql);
		
		log.debug("[authSignUp] sql :" +sql);
		int result  = sqlSession.insert(Namespace+".authSignUp", map);
		
		//log.debug("[authSignUp result] :" +result);
	}
	
	
	@Override
	public int userPetShopSignUp(UserVO userVO) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "INSERT INTO tbl_user(userid, username,userpw,uemail) ";
			sql += "VALUES('"+userVO.getUserid()+"','"+userVO.getUsername()+"','"+userVO.getUserpw()+"','"+userVO.getUemail()+"')";
	
		map.put("sql", sql);
		int result  = sqlSession.insert(Namespace+".userPetShopSignUp", map);
		
		
		return result;
	}
	
	@Override
	public int petShopIdCheck(String userid) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT COUNT(*) "
					+"FROM tbl_user "
					+"WHERE userid = '"+userid+"' "
					+"AND utype = 'ps'";
		
		map.put("sql", sql); 
		
		int result = sqlSession.selectOne(Namespace+".petShopIdCheck", map);
		return result;
	}
	
	@Override
	public UserVO petShopLogin(String userid, String userpw) {
		HashMap<String , String> map = new HashMap();
		
		String sql="SELECT * "
				+"FROM tbl_user "
				+"WHERE userid ='"+userid+"' "
				+"AND userpw = '"+userpw+"' "
				+"AND utype = 'ps'";
		
		map.put("sql", sql);
		
		UserVO result =sqlSession.selectOne(Namespace+".petShopLogin", map);
		
		
		
		return result;
	}
	
	@Override
	public int countUser() {
		HashMap<String , String> map = new HashMap();
		
		String sql="SELECT COUNT(*) FROM tbl_user";
		map.put("sql", sql);
		int result =sqlSession.selectOne(Namespace+".countUser", map);
	
		
		return result;
	}
	
	
	@Override
	public List<UserVO> getUserList(String sortBy,PagingVO pagingVO) {
		
				
		
		HashMap<String , String> map = new HashMap();
		String sql =" SELECT * FROM ( ";
		sql+=" SELECT @rownum:=@rownum+1 AS RN, A.* FROM (SELECT @rownum:=0) AS R,(  ";
		sql+= " SELECT tu.*,tbl_o_b.orderCnt,tr_b.reivewCnt,tq_b.qnaCnt FROM tbl_user AS tu ";
		sql+=" LEFT JOIN (SELECT COUNT(*) AS orderCnt ,tbl_o_a.userid FROM tbl_order AS tbl_o_a GROUP BY tbl_o_a.userid) AS tbl_o_b ";
		sql+=" ON tu.userid = tbl_o_b.userid ";
		sql+=" LEFT JOIN (SELECT COUNT(*) AS reivewCnt ,tr_a.userid FROM tbl_review AS tr_a GROUP BY tr_a.userid) AS tr_b ";
		sql+=" ON tu.userid = tr_b.userid ";
		sql+=" LEFT JOIN (SELECT COUNT(*) AS qnaCnt ,tq_a.userid FROM tbl_qna AS tq_a GROUP BY tq_a.userid) AS tq_b ";
		sql+=" ON tu.userid =tq_b.userid ";
		sql+=" ORDER BY tu.user_regdate DESC ";
		sql+="	) AS A ";
		sql+=" 	) AS B WHERE RN BETWEEN "+pagingVO.getStart()+" AND "+pagingVO.getEnd();
				
		
		map.put("sql", sql);
		List<UserVO> result =sqlSession.selectList(Namespace+".getUserList", map);
	
		
		return result;
	}
}
