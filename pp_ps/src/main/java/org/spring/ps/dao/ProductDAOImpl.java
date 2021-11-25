package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

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
		
		
		HashMap<String, String> map = new HashMap();
		
		
		String sql1 = "INSERT INTO product(pid,pname, pcnt,pprice,pccode)"
					+" VALUES('"+productVO.getPid()+"','"+productVO.getPname()+"','"+productVO.getPcnt()+"','"+productVO.getPprice()+"','"+productVO.getPccode()+"')";
		map.put("sql1", sql1);
		
		String sql2 ="SELECT LAST_INSERT_ID() as pnum";
		log.debug("[productBaseInsert] sql1 : "+sql1);
		log.debug("[productBaseInsert] sql2 : "+sql2);
		
		map.put("sql2", sql2);
		sqlSession.insert(Namespace+".productBaseInsert", map);
		
		log.debug("[productBaseInsert] pnum : "+ String.valueOf(map.get("pnum")));
		
		String pnumStr =String.valueOf(map.get("pnum"));
		
		int pnum = Integer.parseInt(pnumStr);
		return pnum;
	}
	
	@Override
	public int productRemainderUpdate(JSONObject jsonObject, String explicate, int pnum) {

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
		
		sql+= ")) , ";
				
		JsonElement element2 =parser.parse(explicate);		
		log.debug("[element2]:"+element2.toString());
		
		JsonObject explicateObj = element2.getAsJsonObject().get("explicate").getAsJsonObject();
		
		String head = explicateObj.getAsJsonObject().get("head").getAsString();
		String body = explicateObj.getAsJsonObject().get("body").getAsString();
		String footerLeft = explicateObj.getAsJsonObject().get("footerLeft").getAsString();
		String footerRight = explicateObj.getAsJsonObject().get("footerRight").getAsString();
		
		//log.debug("[head]:"+head);
		//log.debug("[body]:"+body);
		//log.debug("[footerLeft]:"+footerLeft);
		//log.debug("[footerRight]:"+footerRight);
		
		sql += " pexplicate = JSON_OBJECT('explicate', JSON_OBJECT('head','"+head+"','body','"+body+"','footerLeft','"+footerLeft+"','footerRight','"+footerRight+"'))";
				
		sql += " WHERE pnum ="+pnum;
				
		log.debug("[productSlideImgUpload] updateSQL :"+sql);
		map.put("sql", sql);
		int result =sqlSession.update(Namespace+".productSlideImgUpload", map);
		
		return result;
	}
	
	@Override
	public List<ProductVO> productBaseList() {
		
		HashMap<String,String> map = new HashMap<String, String>();
		
		
		String sql =  "SELECT A.pnum, A.pid, A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice, A.pslideimg,A.pregdate FROM product AS A LEFT JOIN category AS B ON A.pccode = B.ccode ";
			sql	+= "ORDER BY A.pregdate DESC";
		
		map.put("sql", sql);
		
		List<ProductVO> result = sqlSession.selectList(Namespace+".productList" ,map);		
		return result;
	}
}
