package org.spring.ps.view.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.spring.ps.service.ProductService;
import org.spring.ps.utils.UploadFileUtils;
import org.spring.ps.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class fileUploadController {


	Log log = LogFactory.getLog(this.getClass());


	@Resource(name="uploadPath")
	private String uploadPath;

	@Inject
	private ProductService productService;


	@RequestMapping(value="/editor/image" ,method=RequestMethod.POST)
	@ResponseBody
	public void editorImage(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {

		// 랜덤 문자 생성
		UUID uid = UUID.randomUUID();

		OutputStream out = null;
		PrintWriter printWriter = null;

		// 인코딩
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");


		try {

			String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
			byte[] bytes = upload.getBytes();

			// 업로드 경로
			String ckUploadPath = uploadPath + File.separator + "imgUpload" + File.separator +"product" + File.separator +"editor" + File.separator + uid + "_" + fileName;

			log.debug("[editorImage] uploadPath: "+uploadPath);
			log.debug("[editorImage] ckUploadPath: "+ckUploadPath);

			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush();  // out에 저장된 데이터를 전송하고 초기화

			String callback = request.getParameter("CKEditorFuncNum");

			log.debug("[editorImage] callback: "+callback);
			printWriter = response.getWriter();
			String fileUrl = "/resources/imgUpload/product/editor/" + uid + "_" + fileName;  // 작성화면

			// 업로드시 메시지 출력
			printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");

			printWriter.flush();

		} catch (IOException e) { e.printStackTrace();
		} finally {
			try {
				if(out != null) {
					out.close(); 
					}
				if(printWriter != null) { printWriter.close(); }
			} catch(IOException e) { e.printStackTrace(); }
		}

		return;
	}

	@RequestMapping(value="/slide/upload" , method=RequestMethod.POST)
	@ResponseBody
	public int slideUpload(
			ProductVO productVO,
			@RequestParam("article_file") List<MultipartFile> multipartFile) throws  Exception {

		String pname = new String(productVO.getPname().getBytes("8859_1"),"utf-8");

		productVO.setPname(pname);

		log.debug("[slideUpload] categoryNumber: "+productVO.getCategoryNumber());
		log.debug("[slideUpload] uploadPath: "+uploadPath);
		// C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\pp_ps\resources

		int pnum = productService.productBaseInsert(productVO);

		log.debug("[slideUpload] pnum: "+pnum);
		String slideImgUploadPath =uploadPath + File.separator + "imgUpload"+ File.separator +"product";
		// File.separator >> 구분자 (\)
		log.debug("[slideUpload] slideImgUploadPath: "+slideImgUploadPath);
		// C:\Users\yjh_z\workspace\portpolio_renewal\pp_ps\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\pp_ps\resources\imgUpload\product

		//날짜 디렉토리 생성
		HashMap<String,String> dirMap = UploadFileUtils.calcPath(slideImgUploadPath,pnum);
		String ymdPath = dirMap.get("slideImgPath");
		log.debug("[slideUpload] ymdPath: "+ymdPath);
		//ymdPath: \2021\11\18\product_code_24\slide

		JSONObject jsonObject = new JSONObject();
		JSONObject imgDirJSONObject = new JSONObject();

		jsonObject.put("pnum", pnum);


		for(int i = 0 ; i < multipartFile.size();i++) {

			//저장된 파일 이름
			String fileName = UploadFileUtils.fileUpload(slideImgUploadPath, multipartFile.get(i).getOriginalFilename(), multipartFile.get(i).getBytes(), ymdPath);
			log.debug("[slideUpload] fileName: "+fileName);
			JSONObject imgDirInfoJSONObject = new JSONObject();

			imgDirInfoJSONObject.put("year", dirMap.get("year"));
			imgDirInfoJSONObject.put("month", dirMap.get("month"));
			imgDirInfoJSONObject.put("date", dirMap.get("date"));
			imgDirInfoJSONObject.put("product", dirMap.get("product"));
			imgDirInfoJSONObject.put("fileName", fileName);
			imgDirInfoJSONObject.put("s_fileName", "s_"+fileName);

			int imgNumber = i +1;
			imgDirJSONObject.put("slideImg_"+imgNumber, imgDirInfoJSONObject);
		}

		jsonObject.put("imgDir", imgDirJSONObject);
		log.debug("[slideUpload] jsonObject.toJSONString: "+jsonObject.toJSONString());
		log.debug("[slideUpload] jsonObject.toString: "+jsonObject.toString());

		int productSlideImgUploadResult = productService.productSlideImgUpload(jsonObject, pnum);

		return productSlideImgUploadResult;
	}


}
