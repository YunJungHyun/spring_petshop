<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>

.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    color: #999999;
}

.filebox label {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin: unset;
    text-align: center;
}

.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}

.ck-editor__editable {
	    min-height: 600px;
	}
</style>

<div class="page">
	
	<div class="ps-container">
		<div class="page-title p-2 my-3 bg-dark text-light">
			<h4 class="text-left m-0">제품 기본 정보</h4>
		</div>
		<div class="row m-0">
			<div class="col-lg-6 product-img-box-4 px-0" id="product-img-box">
				<img src="/resources/icon/no-pictures.png" />
			</div>

			<div class="col-lg-6 px-0 pl-3">
				<div class="form-group mb-4">
					<label for="pname">제품 이름</label>
					<input type="text" class="form-control" id="pname" placeholder="제품 이름을 입력하세요."> 
					<div class="invalid-feedback">
							
					</div>
				</div>
				<div class="form-group mb-4">
					<label for="pbrand">브랜드 이름</label>
					<input type="text" class="form-control" id="pbrand" placeholder="브랜드 이름을 입력하세요."> 
					<div class="invalid-feedback">
							
					</div>
				</div>
				<div class="form-row m-0 mb-4">
					<div class="form-group col-lg-6 pl-0" >
						<label for="pcnt">입고량</label>
						<input type="text" class="form-control" id="pcnt" placeholder="입고 수량을 입력해주세요." onkeyup="inputNumberFormat(this)"> 
						<div class="invalid-feedback">
							
						</div>
					</div>
					<div class="form-group col-lg-6 pr-0">
						<label for="pprice">가격</label>
						<input type="text" class="form-control" id="pprice" placeholder="제품 가격을 입력해주세요." onkeyup="inputNumberFormat(this)"> 
						<div class="invalid-feedback">
							
						</div>
					</div>
				</div>
				<div class="form-row m-0 mb-4">
					<div class="form-group col-6 pl-0" >
						<label for="ccoderef">카테고리</label>
						<select class="custom-select" id="ccoderef">
							<option value="">상위 카테고리</option>
							<c:forEach items="${cList }" var ="clist">
								<c:if test="${clist.level == 1 }">
									<option value="${clist.ccode}">
										${clist.cname}
									</option>
								</c:if>
							</c:forEach>
						</select>
						<div class="invalid-feedback">
							
						</div>
					</div>
					<div class="form-group col-6 pr-0">
						<label for="pccode">하위 카테고리</label>
						<select  class="custom-select" id="pccode">
							<option value="">하위 카테고리</option>
							<c:forEach items="${cList }" var ="clist">
								<c:if test="${clist.level == 2 }">
									<option class="${clist.ccoderef }" value="${clist.ccode}" style="display:none">
										${clist.cname}
									</option>
								</c:if>
							</c:forEach>
						</select>
						<div class="invalid-feedback">
							 
						</div>
					</div>
				</div>
				<div class="form-group mb-4">
					<label for="pbrand">제품 이미지</label>
					<div class="filebox d-flex justify-content-center">
						<input class="upload-name col-9" value="첨부파일" placeholder="첨부파일" readonly="readonly" > 
						<label class="col-3" for="pimg">파일 찾기</label>
						<input type="file" id="pimg">
					</div>
					<div class="invalid-feedback">
							
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="ps-container ">
		<div class="page-title p-2 my-3 bg-dark text-light">
			<h4 class="text-left m-0">제품 설명</h4>
		</div>
		<div class="page-box">
			<textarea id="pexplicate">
				
			</textarea>
			
			 
			<script>   
			 var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P
				
					 };
					 
					 CKEDITOR.replace("pexplicate", ckeditor_config);
		
			
				CKEDITOR.instances.pexplicate.setData('<h5><strong>제품 설명</strong></h5><p><br /><h5><strong>제품 특징</strong></h5><p><br />');
			</script>
			 
		</div>
	</div>
	
	<div class="ps-container row justify-content-end p-3 ">
	
		<button type="button" class="btn btn-primary mx-2" id="product-insert-btn">제품 등록</button>

  
		<button type="button" class="btn btn-danger mx-2" id="product-insert-reset-btn">취소</button>
	</div>
</div>

<script>

$("#product-insert-btn").on("click",function(){
	
	
	var pname = $("#pname").val();
	var pbrand = $("#pbrand").val();
	var pcnt = $("#pcnt").val();
	var pprice = $("#pprice").val();
	
	
	
	var pccode = $("#pccode").val();
	var pimgFile = $("#pimg")[0].files[0];
	var pexplicate = CKEDITOR.instances.pexplicate.getData();
	if(pname == ""){
		
		alert("제품 이름을 입력하세요.");
		$("#pname").focus();
		return false;
	}
	if(pbrand == ""){
		
		alert("제품 브랜드를 입력하세요.");
		$("#pbrand").focus();
		return false;
	}
	if(pcnt == ""){
		
		alert("제품 입고량을 입력하세요.");
		$("#pcnt").focus();
		return false;
	}
	if(pprice == ""){
		
		alert("제품 가격을 입력하세요.");
		$("#pprice").focus();
		return false;
	}
	if(pccode == ""){
		
		alert("제품 카테고리를 선택해주세요.");
		$("#pccode").focus();
		return false;
	}
	if(pimgFile == undefined){
		
		alert("제품 이미지를 선택해주세요.");
		$(".upload-name").focus();
		return false;
	}
	
	if(pcnt.indexOf(",") != -1 ){

		pcnt = pcnt.replace(",","");
	}
	
	if(pprice.indexOf(",") != -1 ){

		pprice = pprice.replace(",","");
	}
	

	var formData = new FormData();
	formData.append("pname",pname);
	formData.append("pbrand",pbrand);
	formData.append("pcnt",pcnt);
	formData.append("pprice",pprice);
	formData.append("pccode",pccode);
	formData.append("pimgFile",pimgFile);
	formData.append("pexplicate",pexplicate); 
	/* console.log(formData); */
	  $.ajax({
		
		url : "/product/insert",
		processData : false,
		contentType : false,
		type:"POST",
		data : formData,
		success: function(data){
			
			if(data>=1){
				
				alert("제품이 등록되었습니다.");
				location.href="/adminView/Product";
			}else{
				
				alert("제품 등록 실패하였습니다.");
			}
		}
	}) 
})

$("#ccoderef").on("change",function(){
	
	var ccoderef = $(this).val();

	$("#pccode").children().each(function(){
		
		if($(this).hasClass(ccoderef)){
			$("#pccode").children(":first").css("display","block");
			$(this).css("display","block");
		}else{
			$("#pccode").children(":first").css("display","block");
			$(this).css("display","none");
			
		}
	})
	
})

$("#pimg").on('change',function(){
	
	if(this.files && this.files[0]){
		
		var reader = new FileReader;
		reader.onload = function(data){
			
			 $("#product-img-box img").attr("src", data.target.result);      
		}
		
		reader.readAsDataURL(this.files[0]);
	}
	var fileName = $("#pimg").val();
	$(".upload-name").val(fileName);
});

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
</script> 
