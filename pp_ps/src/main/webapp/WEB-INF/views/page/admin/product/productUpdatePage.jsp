<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	


<style>
@media ( min-width : 1200px) {
	.page>.container {
		max-width: 1200px;
		padding: 1rem;
	}
}

#img-file{
	 display : none;
}
</style>


<div class="page">
	<div class="container">
		<div class="page-emptied-admin"></div>
		<div class="page-contents d-flex flex-column justify-content-center ">

			<form>
				<div class="form-row">
					<div class="col-md-6 mb-3">
					<label >제품 이름</label>
						<input type="text" class="form-control" id="pname" placeholder="제품 이름" value="${pvo.pname }">
					
					</div>
					<div class="col-md-3 mb-3">
					<label >분류</label>
						<select class="custom-select" id="parentCategory">
							<option value="">선택하세요</option>		
						</select>
					</div>
					<div class="col-md-3 mb-3">
					<label >카테고리 이름</label>
						<select class="custom-select" id="pccode">
							<option value="">선택하세요</option>
							
						</select>
						
					</div>
					
				

				</div>
				<div class="form-row">
					<div class="col-md-6 mb-3">
					<label >제품 가격</label>
						<input type="text" class="form-control" id="pprice" placeholder="제품 가격"  onkeyup="inputNumberFormat(this)" value="${pvo.pprice }" >
					
					</div>
					
					<div class="col-md-6 mb-3">
					<label >제품 수량</label>
						<input type="text" class="form-control" id="pcnt" placeholder="제품 수량"  onkeyup="inputNumberFormat(this)" value="${pvo.pcnt }">
					
					</div>
					

				</div>
				
				<div class="form-group">
					<label>제품 대표 이미지</label> 
					<button type="button" class="select-img-btn" id="select-img-btn">
						<i class="fas fa-plus fa-2x"></i>
					</button>
					<input type="file" id="img-file">
					<div class="img-box col-lg-4 col-sm-12">  
						<img src=""/>
						<input type="hidden" id="existing-path" value="">
						<input type="hidden" id="existing-fileName" value="">
					</div>
 					
 					<script>
						
						var src_json = JSON.parse(`${pvo.pimg}`);
						
						var path = src_json.img.path;
						var fileName =src_json.img.fileName;
						//console.log(path);
						//console.log(fileName);
						$(".img-box > img").attr("src",path+"/"+fileName);
						$("#existing-path").val(path);
						$("#existing-fileName").val(fileName);
						
 					</script>
	
				</div> 
	
				
				
				<div class="form-group" id="explicate-group">
				
					<label>제품 본문</label> 
					
					<div id='explicateHead' class='explicate'  contenteditable="true">
				  		
					</div>
					<div id='explicateBody' class='explicate' contenteditable="true">
						
					</div>
					<div class="form-group d-flex">
						<div id='explicateFooterLeft' class="explicate col-md-6" contenteditable="true">
							
						</div>

						<div id='explicateFooterRight' class="explicate col-md-6" contenteditable="true" >
						
						</div>
					</div> 
				</div> 
				<!--  ck에디터 -->
				<script>
				
					var ckeditor_config = {
							filebrowserUploadUrl : "/admin/upload/ckEditor",
							
							editorplaceholder: '내용을 입력해주세요',
						     
						 }; 
				 
				    CKEDITOR.inline( 'explicateHead',ckeditor_config );
				    CKEDITOR.inline( 'explicateBody',ckeditor_config );
				    CKEDITOR.inline( 'explicateFooterLeft',ckeditor_config );
				    CKEDITOR.inline( 'explicateFooterRight',ckeditor_config );
				     
				 
				</script>
				
				
				<button type="button" class="btn btn-primary" id="test-btn">테스트</button>
				<button type="button" class="btn btn-primary" id="product-update-btn">수정하기</button>
			</form>
 
		</div>
	</div>
</div> 

<script>
$(document).ready(function(){
	
	getCategoryList('${pvo.pccoderef}');
	getChildrenCategoryList('${pvo.pccode}','${pvo.pccoderef}');
})

$("#test-btn").on("click",function(){
	
	var pname = $("#pname").val();
	var pprice = $("#pprice").val();
	var pcnt = $("#pcnt").val();
	var pccode = $("#pccode").val();
	
	var pimgFile = $("#img-file")[0].files[0];
	console.log(pname+"/"+pprice+"/"+pcnt+"/"+pccode+"/"+pimgFile);
})


$("#select-img-btn").on("click",function(){
	
	$("#img-file").click();
})

$("#img-file").on("change",function(){
	if(this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".img-box img").attr("src", data.target.result);       
		}
		reader.readAsDataURL(this.files[0]);
		}
	
})


$("#product-update-btn").on("click",function(){
	
	var formData = new FormData();
	
	var pnum = '${pvo.pnum}';
	var pid = '${pvo.pid}';
	var pname = $("#pname").val();
	var pprice = $("#pprice").val();
	var pcnt = $("#pcnt").val();
	var pccode = $("#pccode").val();
	
	var pimgFile = $("#img-file")[0].files[0];
	
	var path = $("#existing-path").val();
	var fileName = $("#existing-fileName").val();
	
	formData.append("pnum",pnum);
	formData.append("pid",pid);
	formData.append("pname",pname);
	formData.append("pprice",pprice);
	formData.append("pcnt",pcnt);
	formData.append("pccode",pccode);
	
	formData.append("path",path);
	formData.append("fileName",fileName);
	
	if(pimgFile != undefined){
		formData.append("pimgFile",pimgFile);
		console.log("파일있음")
	}else{
		
		
		console.log("파일없음")
	}
	
	$.ajax({
		
		url :"/product/admin/update",
		data : formData,
		type : "POST",
		enctype: 'multipart/form-data',  
        processData: false,    
        contentType: false,
        success:function(data){
        	
        
        	if(data >=1){
        		
        		alert("제품이 수정 되었습니다");
        		
        		location.href="/view/admin/go/prodListPage"
        	}else{
        		
        		alert("제품 등록에 실패하였습니다.");
        	}  
        	
        }
		
	})
})



	//가격 포맷
function inputNumberFormat(obj) {
     obj.value = comma(uncomma(obj.value));
	}

function comma(str) {
     str = String(str);
     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
 }

 function uncomma(str) {
     str = String(str);
     return str.replace(/[^\d]+/g, '');
 }
 
function getChildrenCategoryList(pccode,pccoderef){
	
	var jsonData = JSON.parse('${cList}');
	var categoryArray = new Array();
	var categoryobj = new Object();
	
	for(var i = 0 ; i < jsonData.length ; i++){
			
			if(jsonData[i].ccoderef !="" && jsonData[i].ccoderef == pccoderef ){
			categoryobj = new Object;
				
			categoryobj.ccode = jsonData[i].ccode;
			categoryobj.cname = jsonData[i].cname;
			categoryobj.ccoderef = jsonData[i].ccoderef;
			categoryArray.push(categoryobj);
		}
	}
	
	var categorySelect =$("#pccode"); 
		
		categorySelect.children().remove();
		
		categorySelect.append("<option value=''>선택하세요</option>");
		
		
	for(var i = 0; i < categoryArray.length; i++) {
			  
			var option =$("<option>",{"value":categoryArray[i].ccode,"text":categoryArray[i].cname});
			
			categorySelect.append(option);
			
	}
	
	$("#pccode").val(pccode).prop("selected", true);

	
	
} 

function getCategoryList(pccoderef){
 		
 	var jsonData = JSON.parse('${cList}');

 	var parentCategoryArray = new Array;
 	var parentCategoryObj = new Object;
 	
 	for(var i = 0 ; i < jsonData.length ; i++){
 		
 		if(jsonData[i].ccoderef ==""){
 			parentCategoryObj = new Object;
 			
 			parentCategoryObj.ccode = jsonData[i].ccode;
 			parentCategoryObj.cname = jsonData[i].cname;
 			parentCategoryArray.push(parentCategoryObj);
 		}
 	}
 	 
 	var parentCategorySelect =$("#parentCategory"); 
 	
 	for(var i = 0 ; i <parentCategoryArray.length; i++){
 		
 		parentCategorySelect.append("<option value='"+parentCategoryArray[i].ccode+"'>"+parentCategoryArray[i].cname+"</option>");
 		
 	}
 	
 	$("#parentCategory").val(pccoderef).prop("selected", true);
 	
 	
 	//카테고리 change
 	$(document).on("change","#parentCategory",function(){
 		
 		
 	
 		var categoryArray = new Array();
 		var categoryobj = new Object();
 		
 		
 		for(var i = 0 ; i < jsonData.length ; i++){
 			
 			if(jsonData[i].ccoderef !=""){
 				categoryobj = new Object;
 				
 				categoryobj.ccode = jsonData[i].ccode;
 				categoryobj.cname = jsonData[i].cname;
 				categoryobj.ccoderef = jsonData[i].ccoderef;
 				categoryArray.push(categoryobj);
 			}
 		} 
 		 
 		var categorySelect =$("#pccode"); 
 		
 		categorySelect.children().remove();
 		
 		categorySelect.append("<option value=''>선택하세요</option>");
 		
 		var selectParentCategory = $(this).val();
 		
 		for(var i = 0; i < categoryArray.length; i++) {
 			  
 			if(selectParentCategory == categoryArray[i].ccoderef ){
 			  categorySelect.append("<option value='" + categoryArray[i].ccode + "'>"+categoryArray[i].cname + "</option>");
 			}
 		}
 		
 	})
 	

 	
 }
 
</script>
