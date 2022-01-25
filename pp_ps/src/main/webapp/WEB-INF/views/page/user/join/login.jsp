<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.page-container{
	display:flex;
	justify-content: center;
}

.page-content_title {
	text-align: center;
}
.page-content_title_span {
	font-size: 2rem;
	font-weight: bold;
	width: fit-content;
	margin: 0px auto;
}
.ps-slide_inner_item {
	height: 10rem;
	width: 10rem;
	overflow: hidden;
}
.ps-slide{
	padding-top: 2rem;
	padding-bottom: 5rem;
}
.ps-slide_inner {
	height: 10rem;
	width: 10rem;
	margin: 0px auto;
	border-radius: 66%;
}

.ps-slide_inner_item_img {
	object-fit: cover;
	height: -webkit-fill-available;
	border-radius: 60%;
}

.form-signIn_group {
	margin-bottom: 1rem;
}

.form-signIn_group_input {
	font-size: 1.5rem;
}

.form-signIn_button {
	background-color: #7fe7d5;
	width: 100%;
	font-size: 1.5rem;
	font-weight: bold;
	padding: 0.5rem 1rem;
	color: #000;
	margin-bottom: 1rem;
}
.page-content_group_items {
	margin-bottom: 8rem;
	display: flex;
	justify-content: center;
}


.item_span-1_a {
	color: #ccc;
}

.item_span-1_a:hover {
	color: #000;
	font-weight: bold;
}
/* ps-division  */
.division-2{
	width: 1px;
	height: 1rem;
	background-color: #dee2e6;
	align-self: center;
	margin-left: 0.5rem;
	margin-right: 0.5rem;
}

.page-content_group_title-span {
	text-align: center;
	color: #ccc;
	border-bottom: 1px solid #dee2e6;
	margin-bottom: .5rem;
	display: block;
	    padding-bottom: 0.5rem;
}


.item_span-2 {
	width: 3rem;
	height: 3rem;
	border-radius: 50%;
	overflow: hidden;
}

.item_span-2_a_img {
	width: -webkit-fill-available;
	height: -webkit-fill-available;
}

.item-span-option {
	background-color: #7fe7d5;
	padding: 0.5rem;
}

.item_span-2_a {
	color: #fff;
}

.item_span-2_a:hover {
	filter: opacity(0.7);
}

.modal-inner-title{

	font-size:1.25rem;
	font-weight: bold;
	margin-top:.25rem;
	margin-bottom: .25rem;
}

</style>


<div class="page pt-4">
		<div class="page-container">
			<div class="page-content col-4">
				<div class="page-content_title">
					<span class="page-content_title_span">로그인</span>
				</div>
				<div class="page-content_group"> 
					<div class="page-content_group_slide ps-slide">
						<div class="carousel slide" data-ride="carousel">	
							<div class="carousel-inner  ps-slide_inner">
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
								<div class="carousel-item ps-slide_inner_item">
									<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100 ps-slide_inner_item_img" alt="...">
								</div>
							</div>
						</div> 
					</div>
					<form class="page-content_group_form form-signIn ">
						<div class="form-signIn_group">
							<input type="text" class="form-signIn_group_input" autocomplete='off' id="userid" placeholder="아이디"  autofocus>
						</div>
						<div class="form-signIn_group"> 
							<input type="password" class="form-signIn_group_input" autocomplete='off' id="userpw" placeholder="패스워드" >
						</div>
						<button class="btn form-signIn_button" id="signIn-btn" type="button">로그인</button>
					</form>
					<div class="page-content_group_items group_items">
						<span class="item_span-1">
							<a href="#" data-toggle="modal" data-sort="USERID" data-target="#findUserInfo" class="item_span-1_a">아이디 찾기</a>
						</span>
						<span class="division-2"></span> 
						<span class="item_span-1">
							<a href="#" data-toggle="modal" data-sort="USERPW"  data-target="#findUserInfo" class="item_span-1_a">비밀번호 찾기</a>
						</span>
					</div>
				
					<span class="page-content_group_title-span">간편 로그인/가입</span>
					<div class="page-content_group_items group_items">	
						<span class="item_span-2 item-span-option">
							<a href="/view/signUp" class="item_span-2_a">
								<i class="fas fa-2x fa-paw"></i>
							</a>
						</span>
						<span class="division-2"></span>  
						<span class="item_span-2"> 
							<a href="#" class="item_span-2_a" onclick="authLogin('kakao_join')">
								<img  src="/resources/icon/kakao-talk.png" class="item_span-2_a_img">
							</a>
						</span>
						<span class="division-2"></span> 
						<span class="item_span-2">
							<a href="#" class="item_span-2_a" onclick="authLogin('naver_join')">
								<img  src="/resources/icon/naver.png"  class="item_span-2_a_img">
							</a>
						</span>
					</div>
					
			</div> 
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="findUserInfo" tabindex="-1" role="dialog" aria-labelledby="findUserInfo" aria-hidden="true">
  <div class="modal-dialog " role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="findUserInfoLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body find-modal-body">
      	<form id="infoFindForm" name="infoFindForm">
      	
      	</form>
       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="findUserInfo-btn">찾기</button>
      </div>
    </div>
  </div>
</div>

<script>

$("#findUserInfo").on('show.bs.modal', function (e) {
	var findSort= $(e.relatedTarget).data('sort');
	var html ="<div class='modal-inner-content'>";
	if(findSort =="USERID"){
		
		$("#findUserInfoLabel").text("아이디 찾기");
		
	}
	
	if(findSort == "USERPW"){
		
		$("#findUserInfoLabel").text("비밀번호 찾기");
	
		html+="<div class='modal-inner-group'>";
			html+="<div class='modal-inner-title mt-3'>";
				html+="<span class='modal-inner-title_span '>아이디</span>";
			html+="</div>";
			html+="<div class='modal-inner-body'>";
				html+= "<input type='text'  name='userid' placeholder='아이디를 입력해주세요.'>";
			html+="</div>";
		html+="</div>";
	}
	
	html+="<div class='modal-inner-group'>";
		html+="<div class='modal-inner-title mt-3'>";
			html+="<span class='modal-inner-title_span '>이메일 주소</span>";
		html+="</div>";
		html+="<div class='modal-inner-body'>";
			html+= "<input type='text' name='uemail' placeholder='이메일을 입력해주세요.'>";
		html+="</div>";
	html+="</div>";
	html+="<div class='modal-inner-group'>";
		html+="<div class='modal-inner-title mt-3'>";
			html+="<span class='modal-inner-title_span '>이름</span>";
		html+="</div>";
		html+="<div class='modal-inner-body'>";
			html+= "<input type='text' name='username'  placeholder='이름을 입력해주세요.'>";
		html+="</div>";
	html+="</div>";
	html+="</div>";
	
	$("#infoFindForm").append(html);
	
})

$(document).on("click","#findUserInfo-btn",function(){
	
	
	var formData = $("#infoFindForm").serialize();
	
	$.ajax({
		
		
		url : "/user/findUserInfo",
		data : formData,
		type : "POST",
		success : function(data){
			
			
			
			if(data.findStr == undefined ){
				
				
				alert("회원 정보가 없습니다.");
			}else{
				
				alert("회원님의 "+data.findSort+"는 '"+data.findStr+"' 입니다.");
			
				$("#findUserInfo").modal('hide');
			}
			
			
			 
		}
	})
	
})
$("#findUserInfo").on('hidden.bs.modal', function (e) {
	
	$("#infoFindForm").empty();
})
$(document).ready(function(){
	//슬라이드 순서 랜덤
	var ranNum = Math.random();
	var num = Math.floor(ranNum*3+1);
	$(".ps-slide_inner_item").eq(num-1).addClass("active");
	
})



$("#signIn-btn").on("click",function(){
	
	
	var userid = $("#userid").val();
	var userpw = $("#userpw").val();
	
	
	
/* 	if(userid == ""){
		
		alert("아이디를 입력해주세요");
		 $("#userid").focus();
		return false;
	}
	
	if(userpw == ""){
		
		alert("비밀번호를 입력해주세요");
		$("#userpw").focus();
		return false;
		
	} */
	
	 
	$.ajax({
		
		url : "/join/petShop/login",
		data : {
			
			"userid" : userid,
			"userpw" : userpw
		},
		success: function(data){
			
			if(data == "idFail"){
				
				alert("아이디가 존재하지 않습니다.");
				$("#userid").focus();
			}else if(data=="pwFail"){
				
				alert("비밀번호가 맞지 않습니다.");
				$("#userpw").focus();
			}else if(data =="success"){
				
				
				
				if('${go}'!= ""){
					
					location.href = document.referrer;
				}else{
					
					location.href = "/";
				}
			}
			
		}
		
	})
	
})

</script>
