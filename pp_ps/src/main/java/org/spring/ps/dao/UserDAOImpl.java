package org.spring.ps.dao;

import java.util.HashMap;

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
	public UserVO getOneUserInfo(String userid) {
		
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT * FROM user WHERE userid = '"+userid+"'";
		
		


		map.put("sql", sql);
		
		UserVO result  = sqlSession.selectOne(Namespace+".getOneUserInfo", map);
		
		
		return result;
		
		
		
	}
	
	@Override
	public void authSignUp(JSONObject jsonUserInfo) {
		HashMap<String, String> map = new HashMap();
		log.debug("[authSignUp jsonUserInfo] :" +jsonUserInfo.get("id")+","+jsonUserInfo.get("name"));
		
		String sql ="INSERT INTO "
				+ "user(userid,username,user_pet_info,user_prod_info) "
				+ "VALUES ('"+jsonUserInfo.get("id")+"','"+jsonUserInfo.get("name")+"',JSON_OBJECT('PET','none'),JSON_OBJECT('BASKETLIST','none','WISHLIST','none','PURCHASELIST','none'))";			
		map.put("sql", sql);
		int result  = sqlSession.insert(Namespace+".authSignUp", map);
		
		log.debug("[authSignUp result] :" +result);
	}
	
	
	@Override
	public void userPetShopSignUp(JSONObject jsonUserData) {
		HashMap<String, String> map = new HashMap();
		
		
		if(jsonUserData.get("pet").equals("none")) {
			log.debug("[userPetShopSignUp] jsonUserData pet none:"+jsonUserData);
			
		}else {
			
			log.debug("[userPetShopSignUp] jsonUserData pet has :"+jsonUserData);
			String jsonString =jsonUserData.toString();
		
			JsonParser parser = new JsonParser();
			JsonElement element =parser.parse(jsonString);
		
			JsonObject pet  = element.getAsJsonObject().get("pet").getAsJsonObject();
		}
		
		
		//	map.put("sql", sql);
	}
	
	@Override
	public int petShopIdCheck(String userid) {
		HashMap<String, String> map = new HashMap();
		
		String sql = "SELECT COUNT(*) "
					+"FROM USER "
					+"WHERE userid = '"+userid+"'";
		
		map.put("sql", sql);
		
		int result = sqlSession.selectOne(Namespace+".petShopIdCheck", map);
		return result;
	}
	
}
