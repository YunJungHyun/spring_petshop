package org.spring.ps.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class ProductDAOImpl implements ProductDAO{

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.productMapper";
	
	@Override
	public int productBaseInsert(ProductVO productVO) {
		

		sqlSession.insert(Namespace+".productBaseInsert", productVO);
		
		log.debug("[productBaseInsert] pnum : "+ productVO.getPnum());
		return productVO.getPnum();
	}
	
	@Override
	public int productSlideImgUpload(JSONObject jsonObject, int pnum) {

		HashMap<String, String> map = new HashMap();
		
		
		String sql = "UPDATE product SET " 
				+ "pslideImg = JSON_OBJECT('pnum',"+pnum+", 'imgDir', JSON_OBJECT(";
		
		String jsonString = jsonObject.toString();
		JsonParser parser = new JsonParser();
		JsonElement element =parser.parse(jsonString);
		JsonObject imgDir  = element.getAsJsonObject().get("imgDir").getAsJsonObject();
		
		log.debug("[productSlideImgUpload] imgDir.size() :" +imgDir.size());
		log.debug("[productSlideImgUpload] imgDir.toString() :" +imgDir.toString());
		

		for(int i = 1 ; i <= imgDir.size() ;i++) {
			JsonObject img_info_oneLine = imgDir.getAsJsonObject().get("slideImg_"+i).getAsJsonObject();
			
			String year =img_info_oneLine.getAsJsonObject().get("year").getAsString();
			String month =img_info_oneLine.getAsJsonObject().get("month").getAsString();
			String date =img_info_oneLine.getAsJsonObject().get("date").getAsString();
			String product =img_info_oneLine.getAsJsonObject().get("product").getAsString();
			String fileName =img_info_oneLine.getAsJsonObject().get("fileName").getAsString();
			String s_fileName =img_info_oneLine.getAsJsonObject().get("s_fileName").getAsString();
			
			log.debug("[productSlideImgUpload] slideImg_"+i+":"+year+"/"+month+"/"+date+"/"+product+"/"+fileName+"/"+s_fileName+"/");
			
			String img_info_oneLine_str="'slideImg_"+i+"', "
					+ "JSON_OBJECT('year','"+year+"' ,'month','"+month+"','date','"+date+"','product','"+product+"' ,'fileName','"+fileName+"','s_fileName','"+s_fileName+"')";
		
			if(i < imgDir.size()) {
				img_info_oneLine_str += " , ";
			}
			sql+= img_info_oneLine_str;
		}
		
		sql+= "))"
				+ " WHERE pnum ="+pnum;
				
		log.debug("[productSlideImgUpload] updateSQL :"+sql);
		map.put("sql", sql);
		int result =sqlSession.update(Namespace+".productSlideImgUpload", map);
		log.debug("[productSlideImgUpload] result :"+result);
		return result;
	}
}
