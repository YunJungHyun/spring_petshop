package org.spring.ps.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Service;

@Service
public class ProductDAOImpl implements ProductDAO{

	@Inject
	private SqlSession sqlSession;

	Log log =LogFactory.getLog(this.getClass());

	private static final String Namespace = "org.spring.ps.mapper.productMapper";

	@Override
	public int productInsert(ProductVO productVO) {


		HashMap<String, String> map = new HashMap();


		String sql1 = "INSERT INTO product(pid,pname, pcnt,pprice,pccode)"
				+" VALUES('"+productVO.getPid()+"','"+productVO.getPname()+"','"+productVO.getPcnt()+"','"+productVO.getPprice()+"','"+productVO.getPccode()+"')";
		map.put("sql1", sql1);

		String sql2 ="SELECT LAST_INSERT_ID() as pnum";

		map.put("sql2", sql2);
		sqlSession.insert(Namespace+".productInsert", map);

		//log.debug("[productBaseInsert] pnum : "+ String.valueOf(map.get("pnum")));

		String pnumStr =String.valueOf(map.get("pnum"));

		int pnum = Integer.parseInt(pnumStr);
		return pnum;
	}

	@Override
	public int productRegUpdate(int pnum, String imgPath, String fileName) {

		log.debug("[productRegUpdate] imgPath:"+imgPath);
		HashMap<String, String> map = new HashMap();

		String sql = "UPDATE product set pimg = JSON_OBJECT('img',JSON_OBJECT('path','"+imgPath+"','fileName','"+fileName+"')) "
				+ "WHERE pnum = "+pnum;

		map.put("sql", sql);
		int result = sqlSession.update(Namespace+".productRegUpdate", map);
		return result;
	}


	@Override
	public List<ProductVO> getProductList(String openCcode) {

		

		HashMap<String, String> map = new HashMap();

		String sql =  "SELECT A.pnum,A.pid,A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice,A.pimg FROM product AS A ";
			sql	+= "LEFT JOIN category AS B ";
			sql	+="ON A.pccode = B.ccode ";
			if(openCcode.length() >=3 && openCcode.length() <=4) {
				sql+="WHERE B.ccoderef = "+openCcode;
			}else if(openCcode.length() > 4) {
				
				String ccoderef =openCcode.substring(0, openCcode.length()/2);
				String ccode =openCcode.substring(openCcode.length()/2, openCcode.length());
				
				sql+="WHERE B.ccoderef = "+ccoderef+" AND B.ccode="+ccode;
			}else if(openCcode.equals("000")) {
				
				sql +="";
			}

			sql	+= " ORDER BY A.pregdate DESC ";
		map.put("sql", sql);
		List<ProductVO> result = sqlSession.selectList(Namespace+".getProductList", map);
		return result;
	}

	@Override
	public ProductVO getProductOne(String pid) {
		HashMap<String, String> map = new HashMap();

		String sql = "SELECT  A.pnum,A.pid,A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice,A.pimg,A.pexplicate FROM product  AS A ";
		sql +="LEFT JOIN category AS B ON a.pccode =b.ccode ";
		sql	+="WHERE pid = '"+pid+"'";

		map.put("sql", sql);
		ProductVO result = sqlSession.selectOne(Namespace+".getProductOne", map);		
		return result;
	}

	@Override
	public int productUpdate(ProductVO productVO, String path, String fileName) {

		log.debug("[productUpdate] path:"+path);
		HashMap<String, String> map = new HashMap();

		String sql = "UPDATE product set pimg = JSON_OBJECT('img',JSON_OBJECT('path','"+path+"','fileName','"+fileName+"')) "
				+ ", pname = '"+productVO.getPname()+"' "
				+ ", pccode = "+productVO.getPccode()+" "
				+ ", pprice = '"+productVO.getPprice()+"' "
				+ ", pcnt = '"+productVO.getPcnt()+"' "
				+ "WHERE pnum = "+productVO.getPnum();

		map.put("sql", sql);
		int result = sqlSession.update(Namespace+".productRegUpdate", map);
		return result;
	}


	@Override
	public List<ProductVO> getUserProductList(String ccode, String ccoderef) {
		log.debug("[getUserProductList] ccode :"+ccode);
		log.debug("[getUserProductList] ccoderef :"+ccoderef);

		HashMap<String, String> map = new HashMap();

		String sql =  "SELECT A.pnum,A.pid,A.pname,A.pcnt,A.pccode,B.ccoderef pccoderef,A.pprice,A.pimg FROM product AS A LEFT JOIN category AS B ON A.pccode = B.ccode ORDER BY A.pregdate DESC";

		map.put("sql", sql);
		List<ProductVO> result = sqlSession.selectList(Namespace+".getUserProductList", map);
		return result;
	}
}
