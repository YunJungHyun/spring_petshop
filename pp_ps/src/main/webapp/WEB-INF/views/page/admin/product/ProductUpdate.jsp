<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
.page-content_title {
	background-color: darkgreen;
	color: #fff;
	font-size: 1.25rem;
	padding: 0.5rem 1rem;
	filter: drop-shadow(1px 1px 2px #000);
}

.page-content_group {
	border-radius: 3px;
	border: 1px solid #dee2e6;
	margin-top: .5rem;
}

.page-content_group_box {
	padding: 1rem;
	display: flex;
	flex-direction: column;
}

.img-box {
	border-right: 1px solid #dee2e6;
	align-items: center;
	justify-content: center;
	overflow: hidden;
}

.img-box_img {
	object-fit: cover;
	max-width: -webkit-fill-available;
	height: auto;
}

.info-box {
	justify-content: space-between;
}

.info-box_row>.info-box_group:nth-child(1) {
	padding-right: 0.25rem;
}

.info-box_row>.info-box_group:nth-child(2) {
	padding-left: 0.25rem;
}

.info-box_row {
	display: flex;
	justify-content: space-between;
}

.info-box_group {
	display: flex;
	flex-direction: column;
	width: 100%;
	margin-bottom: .5rem;
}
.info-box_group_label {
    font-weight: bold;
    margin-bottom: 0.25rem;
    padding-left: 0.5rem;
}
.page-content_btn-group {
 	display: flex;

}

.page-content_btn-group_button {
     height: 70px;
    font-weight: bold;
    width: 100%;
    font-size: 1.5rem;
}
/* 뉴  */
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
	font-weight: bold;
	background-color: darkgreen;
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



</style>


<div class="page">
	<div class="page-container">
		<div class="page-content mt-3">
			<div class="page-content_title">
				<span class="page-content_title_span">제품 기본 정보 업데이트</span>
			</div>
			<div class="page-content_group">
				<div class="row">
					<div class="col-lg-6 page-content_group_box img-box" id="product-img-box">
						<img  class="img-box_img"  id="this-img" src="/resources/icon/no-pictures.png" />
							<script>			
								var pimgStr = JSON.stringify(${pvo.pimg});
								var pimgJSON = JSON.parse(pimgStr);
								var path =pimgJSON.img.path;
								var fileName = pimgJSON.img.fileName;
								
								$("#this-img").attr("src" ,"/resources"+path+"/"+fileName);
							</script>
					</div>

					<div class="col-lg-6 page-content_group_box info-box">
						<div class="info-box_row">
							<div class="info-box_group" >
								<label class="info-box_group_label" for="pccoderef">*상위 카테고리</label>
								<select class="custom-select info-box_group_select input-chk" id="pccoderef">
									<option value="">선택</option>
									<c:forEach items="${cList }" var ="clist">
										<c:if test="${clist.level == 1 }">
											<option value="${clist.ccode}" <c:if test="${clist.ccode == pvo.pccoderef }">selected</c:if>>
												${clist.cname}
											</option>
										</c:if>
									</c:forEach>
								</select>
								<div class="invalid-feedback">
									<span class="feed-1">상위카테고리를 선택해주세요.</span>
								</div>
							</div>
							<div class="info-box_group">
								<label class="info-box_group_label" for="pccode">*하위 카테고리</label>
								<select  class="custom-select info-box_group_select input-chk" id="pccode">
									<option value="">선택</option>
									<c:forEach items="${cList }" var ="clist">
										<c:if test="${clist.level == 2 }">
											<option value="${clist.ccoderef}-${clist.ccode}"  <c:if test="${clist.ccode == pvo.pccode }">selected</c:if> style="display:none">
												${clist.cname}
											</option>
										</c:if>
									</c:forEach>
								</select>
								<div class="invalid-feedback">
								 	<span class="feed-1">하위카테고리를 선택해주세요.</span>
								</div>
							</div>
						</div>
						<div class="info-box_group ">
								<label class="info-box_group_label" for="pbrand">*브랜드</label>
								<input type="text" class="info-box_group_input input-chk" autocomplete='off' id="pbrand" placeholder="브랜드 이름을 입력하세요." value="${pvo.pbrand }"> 
								<div class="invalid-feedback">
									<span class="feed-1">브랜드명을 입력해주세요.</span>
								</div>
							</div>
							<div class="info-box_group "> 
								<label class="info-box_group_label" for="pname">*제품명</label>
								<input type="text" class="info-box_group_input input-chk" autocomplete='off' id="pname" placeholder="제품 이름을 입력하세요." value="${pvo.pname }"> 
								<div class="invalid-feedback">
									<span class="feed-1">제품명을 입력해주세요.</span>
								</div> 
							</div>
						
							<div class="info-box_group "> 
								<label class="info-box_group_label" for="pname">*가격</label>
								<input type="text" class="info-box_group_input input-chk" autocomplete='off' id="pprice" placeholder="가격을 입력해주세요." onkeyup="inputNumberFormat(this)" value="${pvo.pprice }"> 
								<div class="invalid-feedback">
									<span class="feed-1">제품가격을 입력해주세요.</span>
								</div> 
							</div>
							<div class="info-box_group ">
								<label class="info-box_group_label" for="pbrand">입고량</label>
								<input type="text" class="info-box_group_input" autocomplete='off' id="pcnt" placeholder="입고량을 입력해주세요." onkeyup="inputNumberFormat(this)" value="${pvo.pcnt }"> 
								
							</div>
							<div class="info-box_group "> 
								<label class="info-box_group_label" for="pname">할인율</label>
								<input type="text" class="info-box_group_input" autocomplete='off' id="psale" placeholder="할인율을 입력해주세요." value="${pvo.psale }"> 
								
							</div>
						
							<div class="info-box_group ">
								<label for="pimg">제품 이미지</label>
								<div class="filebox d-flex justify-content-center">
									<input class="upload-name col-9" value="첨부파일" placeholder="제품 대표 이미지" readonly="readonly" > 
									<label class="col-3" for="pimg">파일 찾기</label>
									<input type="file" id="pimg">
								</div>
								<div class="invalid-feedback pimg-chk">
									<span class="feed-1">제품 이미지를 입력해주세요.</span>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<div class="page-content mt-3">
			<div class="page-content_title">
				<h4 class="page-content_title_span">제품 설명</h4>
			</div>
			<div class="page-content_group">
				<textarea id="pexplicate">
					${pvo.pexplicate }
				</textarea>
				<script>   
				 	var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P,
					   height :600
						 };
					 
						 CKEDITOR.replace("pexplicate", ckeditor_config);	
							
					</script>
			</div>
		</div>
			
		
		
		<div class="page-content mt-3 ">
			<div class="page-content_btn-group">
				<div class="page-content_btn-group_box col-4">
					<button type="button" class="btn btn-success page-content_btn-group_button" id="product-update-btn">제품 등록</button>
				</div>			
				<div class="page-content_btn-group_box col-4">
					<button type="button" class="btn btn-primary page-content_btn-group_button" id="product-delete-btn">삭제</button>
				</div>			
				<div class="page-content_btn-group_box col-4">
					<button type="button" class="btn btn-danger page-content_btn-group_button" id="product-update-reset-btn">취소</button>
				</div>			
			</div>			
		</div>
		
	</div>
</div> 

<script>

$("#product-update-reset-btn").on("click",function(){
	
	var con = confirm("현재 페이지를 취소하시겠습니까? 작성된 내용은 저장되지 않습니다.");
	
	if(con == true){
		
		window.history.back()
			
	}
})

$(document).ready(function(){
	
	$("#pccode option").each(function(){
		
		if($(this).val().split("-")[0] == "${pvo.pccoderef}"){
			
			$(this).css("display","block");	
		};
		
	})
	
})

$("#product-delete-btn").on("click",function(){
	
	var con = confirm("제품을 삭제 하시겠습니까?");
	
	if(con ==true){
		var pid = "${pvo.pid}";
		var pimg =  JSON.stringify(${pvo.pimg});
		 $.ajax({
				
				url : "/product/delete",
				type:"POST",
				data : {
					
					"pid" : pid,
					"pimg" : pimg
				},
				success: function(data){
					
					 if(data>=1){
						
						alert("제품 삭제되었습니다.");
						location.href="/adminView/Product";
					}else{
						
						alert("제품 삭제 실패하였습니다.");
					}
				}
			}) 
	}else{
		
		
		console.log("NO");
	}
	
})
$("#product-update-btn").on("click",function(){
	
	var pnameChk =false;
	var pbrandChk =false;
	var ppriceChk =false;
	var pccoderefChk =false;
	var pccodeChk =false;
	var pimgFile= true;
	
	$(".input-chk").each(function(){
		$(this).next().children("span").css("display","none");
		if($(this).val().trim() == ""){
			
			$(this).next().children(".feed-1").css("display","block");
			
		}else{
			
			var thisId = $(this).attr("id");
			
			eval(thisId+"Chk = true");
		}
	})
	

	
	
	
	if( pnameChk == true && pbrandChk == true && ppriceChk == true && pccoderefChk == true && pccodeChk == true && pimgFile == true){
		console.log("전부 true");
		var pid = "${pvo.pid}";
		var pccode = $("#pccode").val().split("-")[1];
		var pbrand = $("#pbrand").val();
		var pname = $("#pname").val();
		var pprice = $("#pprice").val();
		var pcnt = $("#pcnt").val();
		var psale = $("#psale").val();
		var pimgFile = $("#pimg")[0].files[0];
		var pexplicate = CKEDITOR.instances.pexplicate.getData();
		var pimg =  JSON.stringify(${pvo.pimg});
		//업데이트
		if(pimgFile == undefined){
			
			console.log("파일 교체 안됨");
			pimgFile = null;
		}
		
		if(pprice.indexOf(",") != -1 ){

			pprice = pprice.replaceAll(",","");
		}
		
		if(pcnt.indexOf(",") != -1 ){

			pcnt = pcnt.replaceAll(",","");
		}
		
		
		if(pcnt ==""){
			
			pcnt = 0;
		}
		if(psale ==""){
			
			psale =0;
		}
		
		console.log("---inputValue---");
		console.log("pccode:"+pccode);
		console.log("pbrand:"+pbrand);
		console.log("pname:"+pname);
		console.log("pprice:"+pprice);
		console.log("pcnt:"+pcnt);
		console.log("psale:"+psale);
		console.log("pimg:"+pimg);
		console.log("pimgFile:"+pimgFile);
		console.log("pexplicate:"+pexplicate); 
	
		var formData = new FormData();
		formData.append("pid",pid);
		formData.append("pccode",pccode);
		formData.append("pbrand",pbrand);
		formData.append("pname",pname);
		formData.append("pprice",pprice);
		formData.append("pcnt",pcnt);
		formData.append("psale",psale);
		formData.append("pimgFile",pimgFile);
		formData.append("pexplicate",pexplicate); 
		formData.append("pimg",pimg); 
		
		$.ajax({
			
			url : "/product/update",
			processData : false,
			contentType : false,
			type:"POST",
			data : formData,
			success: function(data){
				
				 if(data>=1){
					
					alert("제품 수정되었습니다.");
					location.href="/adminView/Product";
				}else{
					
					alert("제품 수정 실패하였습니다.");
				} 
			}
		}) 
		 
	
	
	}else{
		console.log("---무엇인가 false---");
		console.log("pnameChk:"+pnameChk);
		console.log("pbrandChk:"+pbrandChk);
		console.log("ppriceChk:"+ppriceChk);
		console.log("pccoderefChk:"+pccoderefChk);
		console.log("pccodeChk:"+pccodeChk);
		console.log("pimgFile:"+pimgFile);
		$('html').scrollTop(0);
		return false;
	}
})

$("#pccoderef").on("change",function(){
	
	var pccoderef = $(this).val();

	$("#pccode option").each(function(){
		
		if($(this).val().split("-")[0] == pccoderef || $(this).val() == ""){
			
			$(this).css("display","block");
		}else{
			
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
