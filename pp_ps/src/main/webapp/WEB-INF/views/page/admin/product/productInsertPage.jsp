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
						<input type="text" class="form-control" id="pname" placeholder="제품 이름" >
					
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
						<input type="text" class="form-control" id="pprice" placeholder="제품 가격"  onkeyup="inputNumberFormat(this)" >
					
					</div>
					
					<div class="col-md-6 mb-3">
					<label >제품 수량</label>
						<input type="text" class="form-control" id="pcnt" placeholder="제품 수량"  onkeyup="inputNumberFormat(this)">
					
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
					</div>
 					
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
				<button type="button" class="btn btn-primary" id="product-insert-btn">저장하기</button>
			</form>
 
		</div>
	</div>
</div> 

<script>

$(document).ready(function(){
	
	getCategoryList();
	

})

$("#test-btn").on("click",function(){
	
	console.log($("#img-file")[0].files[0]);
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

$("#product-insert-btn").on("click",function(){
	
 	/*유효성 검사 시작 */
	if($("#pname").val()==""){
		
		alert("제품 이름을 입력해주세요.");
		$("#pname").focus();
		return false;
	}
	
	if($("#pccode").val()==""){
		
		alert("카테고리를 선택해주세요.");
		$("#pccode").focus();
		return false;
	}
	
	if($("#pprice").val()==""){
		
		alert("제품 가격을 입력해주세요.");
		$("#pprice").focus();
		return false;
	}
	if($("#pcnt").val()==""){
	
		alert("제품 수량을 입력해주세요.");
		$("#pcnt").focus();
		return false;
	}
	
 	/*유효성 검사 끝  */
	var formData = new FormData();
	
	
	var pname =  $("#pname").val();
	var pccode =  $("#pccode").val();
	var pprice =  $("#pprice").val();
	var pcnt=  $("#pcnt").val();
	
	
	formData.append("pname",pname);
	formData.append("pccode",pccode);
	formData.append("pprice",pprice);
	formData.append("pcnt",pcnt);
	formData.append("pimgFile",$("#img-file")[0].files[0]);	


	
	 $.ajax({
		
		url :"/admin/product/insert",
		data : formData,
		type : "POST",
		enctype: 'multipart/form-data',  
        processData: false,    
        contentType: false,
        success:function(data){
        	
        	
        	if(data >=1){
        		
        		alert("제품이 등록 되었습니다");
        		
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
 
 

 function getCategoryList(){
 		
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