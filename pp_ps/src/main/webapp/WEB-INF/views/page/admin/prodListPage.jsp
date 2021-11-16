<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script src="https://cdn.ckeditor.com/ckeditor5/31.0.0/classic/ckeditor.js"></script>
<script src="/resources/js/ko.js"></script>
<style>
	#psi-input-btn{
	
		display: none;
	}
	.ck-editor__editable {
	    min-height: 500px;
	}
	</style>
<div class="page">
	<div class="container">
		<div class="page-emptied-admin"></div>
		<div class="page-contents d-flex flex-column justify-content-center ">
		
			<div class="prod-list-header d-flex flex-row justify-content-between">
				<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
					<div class="btn-group mr-2" role="group" aria-label="First group">
						<button type="button" class="btn btn-secondary" data-target="#prod-insert-modal" data-toggle="modal">제품 등록</button>
						
					</div>
					<div class="btn-group mr-2" role="group" aria-label="Second group">
						<button type="button" class="btn btn-secondary" data-target="#category-insert-modal" data-toggle="modal">카테고리 등록</button>
					</div>
				</div>
				<div class="nav-right admin-shop-search-form  d-flex justify-content-end">
					<div class="input-group shop-search-group">
						<input type="text" class="form-control shop-search-form-control" placeholder="상품 검색" aria-label="Input group example" aria-describedby="btnGroupAddon">
						<div class="input-group-prepend shop-search-group-text-box">
							<div class="input-group-text shop-search-group-text" id="btnGroupAddon"><i class="fas fa-search"></i></div>
						</div>
 			 		</div>
 	 			</div>
 	 			
 	 			 
			</div>
			
			<div class="prod-list-body d-flex flex-column my-4">
				
				<div class="prod-list-oneLine">
					<div class="prod-list-content d-flex flex-row">
						<div class="prod-list-img-box col-sm-4">
							
						</div>
						<div class="prod-list-info-box">
					
						</div>
					</div>
				</div>
				
			</div>		
	
		</div>
	</div>
</div>  


<!-- Modal -->
<div class="modal fade " id="prod-insert-modal" tabindex="-1" role="dialog" aria-labelledby="prodInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
		<h5 class="modal-title" id="prodInsertModalLabel">제품 등록</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		</div>
		<div class="modal-body">
			<form>
				<div class="form-row">
					<div class="form-group col-sm-6">
						<label for="pname">제품 이름</label>
						<input type="text" class="form-control" id="pname"  placeholder="제품이름을 입력하세요" value="제품이름1">
					</div>	
					<div class="form-group col-sm-6">
						<label for="formGroupExampleInput">제품 카테고리</label>
						
						<select class="custom-select">
								<option value="">카테고리를 선택하세요</option>
							<c:forEach var = "clist" items="${cList}">
								<option value="${clist}">${clist.cname }</option>
							</c:forEach>
						</select>
					</div>	
				</div>
				<div class="form-row">
					<div class="form-group col-sm-6">
						<label for="pcnt">제품 수량</label>
						<input type="text" class="form-control" id="pcnt"  placeholder="제품수량을 입력하세요" value="200">
					</div>	
					<div class="form-group col-sm-6">
						<label for="formGroupExampleInput">제품 가격</label>
						<input type="text" class="form-control" id="pcnt"  placeholder="제품가격을 입력하세요" value="200">
					</div>	
				</div>
				
				<div class="form-group">
					<label for="formGroupExampleInput">제품 슬라이드 이미지 추가</label>
					<button type="button" id="psi-btn">
						<i class="fas fa-plus"></i>
					</button>
					<input type="file" id="psi-input-btn"/>
				</div>
				<%=request.getRealPath("/") %>
				<div class="form-group">
					<div class="d-flex flex-row justify-content-center" id="select-img-list">
						<h2 class="select-img-none-guide show">슬라이드로 사용될 이미지를 업로드해주세요.</h2>
					</div>
				</div>
				<div class="form-group">  
					<label for="formGroupExampleInput">제품 설명</label>
				<div id="pexplicate"></div>
				<script>
				ClassicEditor
					.create( 
							document.querySelector( '#pexplicate' ), 
							{
								ckfinder: {
									uploadUrl: '/admin/editor/image'
								},
								language: 'ko'
								}
						)
					
					.catch( error => {
               				 console.error( error );
           				 } );
    			</script> 
				</div>	
			 
				
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		</div>
	</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade " id="category-insert-modal" tabindex="-1" role="dialog" aria-labelledby="categoryInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
		<h5 class="modal-title" id="categoryInsertModalLabel">카테고리 등록 </h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		</div>
		<div class="modal-body">  
			<form class="my-3 p-3" id="category-insert-form" >
				
				<div class="form-group">
		 			<div class="row">
		 				<div class="col-sm-3 text-center">
		 					<label class="mt-2" for="cname">카테고리 이름</label>
		 				</div>
		 				<div class="col-sm-9">
		 					<input type="text" class="form-control" id="cname"  placeholder="카테고리 이름을 입력하세요." value="">
		 				</div>
		 			</div>
		 				  
		 		</div>
				
				<div class="form-group">
		 			<div class="row">
		 				<div class="col-sm-3 text-center">
		 					<label class="mt-2" for="ctype">카테고리 분류</label>
		 				</div>
		 				<div class="col-sm-9">
		 					<select class="custom-select" id="ctype">
								<option selected value="">선택 하세요</option>
								<option  value="food">사료</option>
								<option value="snack">간식</option>
								<option value="clothes">옷</option>
								<option value="accessories">악세사리</option>
								<option value="toy">장난감</option>
 							</select>
 						</div>
		 			</div>
		 				  
		 		</div>
				
				<div class="form-group">
		 			<div class="row">
		 				<div class="col-sm-3 text-center">
		 					<label class="mt-2" for="csort">반려동물 종류</label>
		 				</div>
		 				<div class="col-sm-9">
		 					<select class="custom-select" id="csort">
								<option selected value="">선택 하세요</option>
								<option value="allKinds">전체</option>
								<option value="dog">강아지</option>
								<option value="cat">고양이</option>
								<option value="etc">기타</option> 
 							</select>
 						</div>
		 			</div>
		 				  
		 		</div>
			</form>
			
			<div class="categoryList" id="categoryList">
			
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" id="category-insert-btn">저장하기</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		</div>
	</div>
	</div>
</div>

<script>
//제품 슬라이드 이미지 인풋버튼 클릭시 파일업로드
$("#psi-btn").on("click",function(){
	

	$('#psi-input-btn').click();

	
})

$('#psi-input-btn').change(function(){ 
	
	if($(".select-list-one").length >=5){
		
		alert("슬라이드 이미지는 5개까지 등록가능합니다.");
		return false;
	}
	
	if(this.files && this.files[0]) {
		
		
		var reader = new FileReader;
		reader.onload = function(data) {
			
			
		   	var html =  "<div class='select-list-one'>";
				html +="<button type='button' class='select-img-cancle badge'><i class='fas fa-times'></i></button>"
				html +=	"<img src='"+data.target.result+"'/>";
				html += "</div>";
			
			if($(".select-img-none-guide").hasClass("show")){
				$(".select-img-none-guide").removeClass("show");
				$(".select-img-none-guide").addClass("hide");
			}
			
			
			$("#select-img-list").append(html); 	 
		}
		reader.readAsDataURL(this.files[0]);
		
		
	} 
	
}) 

$(document).on("click",".select-img-cancle",function(){
	
	$(this).parent().remove();
	
	if($(".select-list-one").length == 0){
		
		$(".select-img-none-guide").removeClass("hide");
		$(".select-img-none-guide").addClass("show");
		
	}
	
})




//카테고리 목록 불러오기
$("#prod-insert-modal").on('show.bs.modal', function (e) {
	
	
	
})

$("#category-insert-modal").on('hidden.bs.modal', function (e) {
	$("#categoryList").children().remove();
	
})
$("#category-insert-modal").on('show.bs.modal', function (e) {
	
	
	$.ajax({
		
		url: "/admin/categoryList",
		method:"POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "JSON",
		success: function(data){
			
			for(var i = 0 ; i < data.length ; i++){
				var html = "<div class='btn-group category-list-one mx-1'>";
					html += "<button type='button' class='btn category-list-one-btn my-2' data-toggle='collapse' data-target='.category-editor-"+data[i].cnum+"'>";
					html += data[i].cname;
					html += "</button>";
					
					html += "<button type='button' class='category-editor-"+data[i].cnum+" btn category-editor-btn category-update-btn collapse' data-toggle='collapse' data-target='#category-update-form-"+data[i].cnum+"' aria-haspopup='false' >";
					html += "<i class='far fa-edit'></i>";
					html += "</button>"
					
					html += "<button type='button' id = 'category-delete-"+data[i].cnum+"' class='category-editor-"+data[i].cnum+" btn category-editor-btn category-delete-btn collapse' >";
					html += "<i class='far fa-trash-alt'></i>";
					html += "</button>"
					
					html += "<div class='collapse category-update-form' id='category-update-form-"+data[i].cnum+"'>"
					html += "<div class='card card-body category-update-card-body'>"
					html += "<form>";
					html += "<div class='form-group d-flex flex-row'>";
		 			html += "<div class='col-sm-3 text-center'>"
		 			html += "<label class='mt-2' for='cname'>카테고리 이름</label>"
		 			html += "</div>"
		 			html += "<div class='col-sm-9'>"
		 			html += "<input type='text' class='form-control' id='update-cname-"+data[i].cnum+"'  placeholder='카테고리 이름을 입력하세요.' value='"+data[i].cname+"'>"
		 			html += "</div>"
	 				  
		 			html += "</div>"
					html += "<div class='form-group d-flex flex-row'>";
					
					html += "<div class='col-sm-3 text-center'>"
		 				html += "<label class='mt-2' for='ctype'>카테고리 분류</label>"
		 			html += "</div>"
		 			html += "<div class='col-sm-9'>"
		 			html += "<select class='custom-select' id='update-ctype-"+data[i].cnum+"'>"
		 				html += "<option value=''>선택 하세요</option>"
		 				html += "<option value='food'>사료</option>"
				 		html += "<option value='snack'>간식</option>"
				 		html += "<option value='clothes'>옷</option>"
						html += "<option value='accessories'>악세사리</option>"
						html += "<option value='toy'>장난감</option>"
		 			html += "</select>"
		 			html += "</div>"
	 				  
		 			html += "</div>"
					html += "<div class='form-group d-flex flex-row'>";
					
					html += "<div class='col-sm-3 text-center'>"
		 			html += "<label class='mt-2' for='ctype'>반려동물 종류</label>"
		 			html += "</div>"
		 				html += "<div class='col-sm-9'>"
		 			html += "<select class='custom-select' id='update-csort-"+data[i].cnum+"'>"
		 				html += "<option value=''>선택 하세요</option>"
		 				html += "<option value='allKinds'>전체</option>"
		 				html += "<option value='dog'>강아지</option>"
						html += "<option value='cat'>고양이</option>"
				 		html += "<option value='etc'>기타</option>"
		 			html += "</select>"
		 				html += "</div>"
		 		
	 				  
		 			html += "</div>"
		 			html += "<div class='d-flex justify-content-end'>"
		 			html +="<button type='button' class='btn btn-success mx-2' id='category-num-"+data[i].cnum+"' name='category-update-btn' >수정하기</button>"
		 			html += "<input type='hidden' id='resetString-"+data[i].cnum+"'value='"+data[i].cname+"/"+data[i].ctype+"/"+data[i].csort+"'>"
					html +="<button type='button' class='btn btn-secondary mx-2' id='category-reset-"+data[i].cnum+"'  onclick='categoryUpdateReset("+data[i].cnum+")'>취소</button>"
				
		 			html += "</div>"
		 			html += "</form>";
					html += "</div>" 
					html += "</div>"
					
					html +="</div>"; 
					
				$("#categoryList").append(html);
				
				$("#update-ctype-"+data[i].cnum).val(data[i].ctype).attr("selected","selected");
				$("#update-csort-"+data[i].cnum).val(data[i].csort).attr("selected","selected");
				
			}
		} 
	})
	 
})

$(document).on("click",".category-list-one-btn",function(){
	
	$(".category-update-form").each(function(){
		
		if($(this).hasClass("show")){
			
			$(this).collapse('hide');
		}
		
	})
	
	$(".category-editor-btn").each(function(){
		
		if($(this).hasClass("show")){
			
			$(this).collapse('hide');
		}
		
	})
		
	
})

$(document).on("click",".category-delete-btn",function(){
	var result = confirm("해당 카테고리를 삭제 하시겠습니까?");
})


$(document).on("click","button[name=category-update-btn]",function(){
	
	var categoryNumberStr= $(this).attr("id");
	var categoryNumberArray = categoryNumberStr.split("-");
	
	var cnum = categoryNumberArray[2];
	
	//alert(categoryNumber);
	
	var cname = $("#update-cname-"+cnum).val();
	var ctype = $("#update-ctype-"+cnum).val();
	var csort = $("#update-csort-"+cnum).val();
	
	$.ajax({
		url : "/admin/categoryUpdate",
		data : {
			"cnum" : cnum,
			"cname" : cname,
			"ctype" : ctype,
			"csort" : csort			
		},
		type: "post",
		success: function(data){
			
			if(data >=1){
				
				alert("카테고리 수정되었습니다.");
				location.reload();
			
				
			}else{
				
				alert("카테고리 수정 실패 하였습니다...");
			}
			
		}
	})
})

//카테고리 리셋
function categoryUpdateReset(cnum){
	
	var str = $("#resetString-"+cnum).val();
	var strArray =str.split("/");
	var cname = strArray[0];
	var ctype = strArray[1];
	var csort = strArray[2];
	
	$("#update-cname-"+cnum).val(cname);

	$("#update-ctype-"+cnum).val(ctype).attr("selected","selected");
	$("#update-csort-"+cnum).val(csort).attr("selected","selected");
	
	$(".category-update-form").each(function(){
		
		if($(this).hasClass("show")){
			
			$(this).collapse('hide');
		}
		
	})
	
	$(".category-editor-btn").each(function(){
		
		if($(this).hasClass("show")){
			
			$(this).collapse('hide');
		}
		
	})
}
 
$("#category-insert-btn").on("click",function(){
	
	var cname = $("#cname").val();
	var ctype = $("#ctype").val();
	var csort = $("#csort").val();
	
	var categoryData = new Object();
	
	categoryData.cname = cname;
	categoryData.ctype = ctype;
	categoryData.csort = csort;
	
	console.log(categoryData);
	
	$.ajax({
		
		url: "/admin/categoryInsert",
		data : categoryData,
		method: "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		success: function(data){
			
			
			if(data >=1){
				
				
				alert("새 카테고리가 등록 되었습니다.");
				location.reload();
				
			}else{
				
				alert("카테고리 등록 실패하였습니다.");
			}
			
		}
		
	})
	
	
	
})


</script>


