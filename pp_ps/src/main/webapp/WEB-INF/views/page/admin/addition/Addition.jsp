<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.page-content_group_title{
	padding-bottom: .5rem;
	border-bottom : 1px solid #dee2e6;
}
.page-content_group_title-span {
    font-size: 1.5rem;
    font-weight: bold;
    display: inline;
    vertical-align: middle;
}
.flex-group {
    display: flex;
    flex-wrap: wrap;
        margin-top: 1rem;
}
.page-content_group_box {
    max-height: 30rem;
    min-height: 15rem;
    overflow: hidden;
}
.flex-box {
    margin: 0.5rem;
    padding: 1.5rem .5rem 1rem;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    min-height: 10rem;
    display: flex;
    flex-wrap: wrap;
    flex-direction: row;
    min-height: inherit;
    max-height: inherit;
    align-content: baseline;
}
.group-title_span {
  position: absolute;
    top: -5px;
      min-width: fit-content;
    left: 50%;
    text-align: center;
    transform: translate(-50%, 0);
    z-index: 2;
    background-color: #fff;
    font-weight: bold;
    padding-left: 0.5rem;
    padding-right: 0.5rem;
    font-size: 1.25rem; 
}
.flex-box.add-box {
    padding: unset;
    
}
.add-box_btn{
	background: url(/resources/icon/plus.png) no-repeat;
    min-height: inherit;
    width: 100%;
    background-position: center;
    filter: drop-shadow(1px 1px 2px #000);
}
.sub-add-box {
    position: absolute;
    height: auto;
    right: 5px;
    bottom: 5px;
    margin: 1rem;
    background-color: #fff;
    filter: drop-shadow(1px 1px 2px black);
    border: 1px solid #dee2e6;
    border-radius: 10px;
}

span.sub-category-span {
    height: 100%;
    border: 1px solid;
    border-radius: 10px;
    margin: 3px;
    padding: 3px 0.5rem;
    font-size: .75rem;
    font-weight: bold;
}
.sub-category-span:hover{

	cursor: pointer;
	
}
.cpCnt{
	font-size: .75rem;
}
</style>
<div class="page mt-5">
	<div class="page-container">
		
		<div class="page-content mb-5">
			<div class="page-content_group ">
				<div class="page-content_group_title">
					<span class="page-content_group_title-span">카테고리 목록</span>
					
				</div> 
			</div>
			<div class="page-content_group flex-group">
				<c:forEach items="${cList }" var="list">
					<c:if test="${list.level == 1 }"> 
						<div class="page-content_group_box col-3">
							<div class="flex-box" id="parent-${list.ccode}">
								<span class="group-title_span parent-category-span">${list.cname }</span>
								<c:forEach items="${cList }" var="sublist">
									<c:if test="${sublist.level == 2 && list.ccode == sublist.ccoderef }">
										<span class="sub-category-span" id="${sublist.ccode}">
											<input type="hidden" value="${sublist.cname }">
											${sublist.cname }
											<span class="badge badge-info cpCnt">0</span>
										</span>
									</c:if> 
								</c:forEach>
								<span class="sub-add-box">
									<button type="button" class="btn sub-add-box_btn" data-toggle="modal" data-sort="sub" data-cname="${list.cname}" data-ccode="${list.ccode }" data-target="#categoryAddModal">
										<i class="fas fa-plus"></i>
									</button>
								</span>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<div class="page-content_group_box col-3">
					<div class="flex-box add-box">
						<button type="button" class="btn add-box_btn" data-toggle="modal" data-sort="parent"  data-target="#categoryAddModal" >
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="page-content">
			<div class="page-content_group ">
				<div class="page-content_group_title">
					<span class="page-content_group_title-span">브랜드 목록</span>
				</div> 
			</div>
			<div class="page-content_group flex-group">		
				<c:forEach items="${bList }" var="list" varStatus="status">
				<div class="page-content_group_box col-3">
					<div class="flex-box bimg-box justify-content-center" id="bimg-${list.bnum}">
						<input type="hidden" class="bimg_input" id="bimg-${status.count }-input" value="" >
						<span class="group-title_span">${list.bname }</span>
						<img id="bimg-${status.count }"  src="">
						<script>
							
							var pimgStr = JSON.stringify(${list.bimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#bimg-${status.count }").attr("src" ,"/resources"+path+"/"+fileName);
							$("#bimg-${status.count}-input").val(pimgStr);
						
						</script>
					</div>
				</div>
				</c:forEach>
				<div class="page-content_group_box col-3">	
					<div class="flex-box add-box">
						<button type="button" class="btn add-box_btn" data-toggle="modal" data-target="#brandAddModal"   >
						</button>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<!-- Modal -->
<div class="modal fade" id="categoryAddModal" tabindex="-1" role="dialog" aria-labelledby="categoryAddModal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="categoryAddModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form id="categoryInsertFrom" name="categoryInsertFrom">
      		<div class="modal-insert-content">
      		</div>
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="insertCategory-btn">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal -->
<div class="modal fade" id="brandAddModal" tabindex="-1" role="dialog" aria-labelledby="brandAddModal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="brandAddModalLabel">브랜드 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form id="brandInsertForm" name="brandInsertForm">
      		<div class="modal-insert-content">
      			<div class="modal-insert-content_group">
      				<div class="modal-insert-title">
      					<span class="modal-insert-title_span">브랜드 이름</span>
      				</div>
      				<div class="modal-insert-body">
      					<input type="text" name="bname" id="bname" placeholder="브랜드 이름을 입력하세요.">
      				</div>
      			</div>
      			<div class="modal-insert-content_group">
      				<div class="modal-insert-title">
      					<span class="modal-insert-title_span">브랜드 이미지</span>
      				</div>
      				<div class="modal-insert-body">
      					<input type="file" name="bimg" id="bimg" placeholder="브랜드 이름을 입력하세요.">
      					<div class="select-bimg-box">
      						<img src="" class="select-bimg"/>
      					</div>
      					<script>
      						$("#bimg").change(function(){
      							
      							if(this.files && this.files[0]){
      								
      								var reader =new FileReader;
      								reader.onload =function(data){
      								
      										$(".select-bimg").attr("src",data.target.result);
      								}
      								reader.readAsDataURL(this.files[0]);
      								
      							}
      						})
      					</script>
      				</div>
      			</div>
      		</div>
      	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="insertBrand-btn">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<script>
$(".bimg-box").on("click",function(){
	
	var con = confirm("선택한 브랜드를 삭제하시겠습니까?");
	if(con == true){
	
		var bnum = $(this).attr("id").split("-")[1];
		var bimg = $(this).children(".bimg_input").val();
		
		
		$.ajax({
			
			url : "/brand/delete",
			type:"POST",
			data : {
				"bnum" : bnum,
				"bimg" : bimg
				
			},
			success : function(data){
				
				if(data>0){
					
					alert("브랜드가 삭제되었습니다.");
					location.reload();
					
				}else{
					
					alert("브랜드 삭제 실패하였습니다.");
					location.reload();
				}
			}
			
			
		})
	}
})

$(document).on("click","#insertBrand-btn",function(){
	
	var bimgFile =$("#bimg")[0].files[0];
	var bname = $("#bname").val();
	
	var formData = new FormData();
	formData.append("bname",bname);
	formData.append("bimgFile",bimgFile);
	
	$.ajax({
		
		url : "/brand/insert",
		processData : false,
		contentType : false,
		type: "POST",
		data : formData,
		success : function(data){
			
			if(data > 0){
				
				alert("브랜드가 등록 되었습니다.");
				location.reload();
			}else{
				alert("브랜드가 등록에 실패하였습니다.");
				location.reload();
			
				
			}
		}
		
	})

})

$(document).on("click","#insertCategory-btn",function(){
	
	var formData = $("#categoryInsertFrom").serialize(); 
	
	$.ajax({
		
		url: "/category/insert",
		type:"POST",
		data: formData,
		success:function(data){
			
			if(data>0){
				alert("카테고리가 등록 되었습니다.");
				
				location.reload();
			}
			
		}
		
	})
	 
})
$('#categoryAddModal').on('show.bs.modal', function (e) {
	var categorySort= $(e.relatedTarget).data('sort');
	var html ="";	
	
	$(".modal-insert-content").empty();
	
	if(categorySort=="sub"){
		var cname= $(e.relatedTarget).data('cname');
		var ccode =$(e.relatedTarget).data('ccode');
		var modalTitle = "하위 카테고리 등록";
		

			
				html+="<div class='modal-insert-title'>";
					
					html+="<span class='modal-insert-title_span parent-name-span'> - "+cname+"</span>";
				html+="</div>";
				html+="<div class='modal-insert-body'>";
					html+= "<input type='hidden' name='sort' value='sub'>";
					html+= "<input type='hidden' name='ccoderef' value='"+ccode+"'>";
					html+= "<input type='text' name='cname' placeholder='하위 카테고리 이름을 입력하세요.'>";
				html+="</div>";
			
	}
	 
	if(categorySort=="parent"){
		var modalTitle = "상위 카테고리 등록";
		html+="<div class='modal-insert-title'>";
			html+="<span class='modal-insert-title_span'>카테고리 이름</span>";
		html+="</div>";
		html+="<div class='modal-insert-body'>";
			html+= "<input type='hidden' name='sort' value='parent'>";
			html+= "<input type='text' name='cname' placeholder='상위 카테고리 이름을 입력하세요.'>";
		html+="</div>";		
		
	}
	$("#categoryAddModalLabel").text("하위 카테고리 추가");
	$(".modal-insert-content").append(html);
})

$(document).on("click",".sub-category-span",function(){
	
	var ccode = $(this).attr("id");
	var cname = $(this).children("input").val();
	var remainCnt = 0;
	var con = confirm(cname+" 카테고리를 삭제 하시겠습니까?");
	if(con== true){
		$.ajax({
		
			url : "/category/findRemainProduct",
			data : {
				"ccode" : ccode
			},
			type:"POST",
			async: false,
			success:function(data){
			
				remainCnt= data;
			}
		
		}) 
		
		if(remainCnt >0){
			
			alert("카테고리 안에 남아있는 제품이 있어 삭제 할 수 없습니다.");
			return false;
		}else{
			
			$.ajax({
				
				url : "/category/deleteSubCategory",
				data : {
					"ccode" : ccode
				},
				type:"POST",
				success:function(data){
				
					if(data>=1){
						
						alert(cname+" 카테고리가 삭제 되었습니다.");
						location.reload();
					}else{
						
						alert("카테고리 삭제 실패하였습니다.");
						location.reload();
					}
				}
			
			}) 
		}
	}
	
	
})
	$(document).ready(function() {
		
		var cpObj = JSON.parse('${cpJSON}');
		
		for( var i = 0 ; i <cpObj.length ; i++){
			
			$("#"+cpObj[i].pccode).children(".cpCnt").text(cpObj[i].cnt);
		}
	})
</script>