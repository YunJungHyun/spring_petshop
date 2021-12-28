package org.spring.ps.view.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.spring.ps.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/upload")
public class FileUploadController {


	Log log = LogFactory.getLog(this.getClass());


	@Resource(name="uploadPath")
	private String uploadPath;


	@Inject
	private ProductService productService;


	@RequestMapping(value="/ckEditor" )
	public void ckEditorUpload(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam MultipartFile upload
			)  {

		log.debug("[ckEditorUpload]");

		UUID uid = UUID.randomUUID();

		OutputStream out = null;
		PrintWriter printWriter = null;

		//인코딩
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		try {

			String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
			byte[] bytes = upload.getBytes();

			// 업로드 경로
			String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;

			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush();  // out에 저장된 데이터를 전송하고 초기화

			String callback = request.getParameter("CKEditorFuncNum");
			printWriter = response.getWriter();
			String fileUrl = "/resources/ckUpload/" + uid + "_" + fileName;  // 작성화면

			// 업로드시 메시지 출력
			printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");

			printWriter.flush();

		} catch (IOException e) { e.printStackTrace();
		} finally {
			try {
				if(out != null) { 
					out.close(); 
					}
				if(printWriter != null) {
					printWriter.close(); 
					}
			} catch(IOException e) { 
				e.printStackTrace();
				}
		}

		return; 

	}

}
