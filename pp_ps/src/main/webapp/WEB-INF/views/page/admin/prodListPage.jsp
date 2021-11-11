<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




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
      	<select class="custom-select">
			<option selected>제품 종류</option>
			<option value="1">One</option>
			<option value="2">Two</option>
			<option value="3">Three</option>
		</select>
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
		 				<label class="col-sm-3 m-auto admin-modal-label" for="cname">카테고리 이름</label>
		 				<input type="text" class="form-control col-sm-9" id="cname"  placeholder="카테고리 이름을 입력하세요." value="">
		 			</div>
		 				  
		 		</div>
				
				<div class="form-group">
		 			<div class="row">
		 				<label class="col-sm-3 m-auto admin-modal-label" for="ctype">카테고리 분류</label>
		 				<select class="custom-select col-sm-9" id="ctype">
							<option selected value="">선택 하세요</option>
							<option value="food">사료</option>
							<option value="snack">간식</option>
							<option value="clothes">옷</option>
							<option value="accessories">악세사리</option>
							<option value="toy">장난감</option>
 						</select>
		 			</div>
		 				  
		 		</div>
				
				<div class="form-group">
		 			<div class="row">
		 				<label class="col-sm-3 m-auto admin-modal-label" for="csort">반려동물 종류</label>
		 				<select class="custom-select col-sm-9" id="csort">
							<option selected value="">선택 하세요</option>
							<option value="dog">강아지</option>
							<option value="cat">고양이</option>
							<option value="etc">기타</option> 
 						</select>
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
					html += "<button type='button' class='btn category-list-one-btn' data-toggle='collapse' data-target='.category-editor-"+data[i].cnum+"'>";
					html += data[i].cname;
					html += "</button>";
					
					html += "<button type='button' class='category-editor-"+data[i].cnum+" btn category-editor-btn category-update-btn collapse' data-toggle='collapse' data-target='#category-update-form-"+data[i].cnum+"' aria-haspopup='false' >";
					html += "<i class='far fa-edit'></i>";
					html += "</button>"
					
					html += "<button type='button' class='category-editor-"+data[i].cnum+" btn category-editor-btn category-delete-btn collapse' >";
					html += "<i class='far fa-trash-alt'></i>";
					html += "</button>"
					
					html += "<div class='collapse category-update-form' id='category-update-form-"+data[i].cnum+"'>"
					html += "<div class='card card-body category-update-card-body'>"
					html += "<div class='form-group d-flex flex-row'>";
		 			
		 			html += "<label class='col-sm-3 m-auto text-center' for='cname'>카테고리 이름</label>"
		 			html += "<input type='text' class='col-sm-9 form-control' id='update-cname-"+data[i].cnum+"'  placeholder='카테고리 이름을 입력하세요.' value='"+data[i].cname+"'>"
		 		
	 				  
		 			html += "</div>"
					html += "<div class='form-group d-flex flex-row'>";
					
	 				
		 			html += "<label class='col-sm-3 m-auto  text-center' for='ctype'>카테고리 분류</label>"
		 			html += "<select class='custom-select col-sm-9' id='update-ctype-"+data[i].cnum+"'>"
		 				html += "<option value=''>선택 하세요</option>"
		 				html += "<option value='food'>사료</option>"
				 		html += "<option value='snack'>간식</option>"
				 		html += "<option value='clothes'>옷</option>"
						html += "<option value='accessories'>악세사리</option>"
						html += "<option value='toy'>장난감</option>"
		 			html += "</select>"
		 		
	 				  
		 			html += "</div>"
					html += "<div class='form-group d-flex flex-row'>";
					
	 				
		 			html += "<label class='col-sm-3 m-auto  text-center' for='ctype'>반려동물 종류</label>"
		 			html += "<select class='custom-select col-sm-9' id='update-csort-"+data[i].cnum+"'>"
		 			html += "<option value=''>선택 하세요</option>"
		 			html += "<option value='dog'>강아지</option>"
					html += "<option value='cat'>고양이</option>"
				 	html += "<option value='etc'>기타</option>"
		 			html += "</select>"
		 		
	 				  
		 			html += "</div>"
		 			html += "<div class='d-flex justify-content-end'>"
		 			html +="<button type='button' class='btn btn-success mx-2' id='category-num-"+data[i].cnum+"' name='category-update-btn' >수정하기</button>"
					html +="<button type='button' class='btn btn-secondary mx-2'>취소</button>"
		 			html += "</div>"
					
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

$(document).on("click","button[name=category-update-btn]",function(){
	
	
	
})


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
				$("#category-insert-modal").modal('hide');
				
			}else{
				
				alert("카테고리 등록 실패하였습니다.");
			}
			
		}
		
	})
	
	
	
})

</script>


