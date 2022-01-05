package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.spring.ps.vo.UserVO;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		return null;
	}
}
