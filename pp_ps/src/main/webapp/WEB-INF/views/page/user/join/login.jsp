<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="pt-4">
</div> 
<div class="page">
		<div class="col-4">
			<div class="page-title-001">
				<span class="ps-span-001">로그인</span>
			</div>
			<div class="page-box"> 
				<div class="ps-slide-001">
					<div class="carousel slide" data-ride="carousel">	
						<div class="carousel-inner  ps-slide-inner-001">
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_1.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_2.jpg" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item ps-slide-item-001">
								<img src="/resources/slideimg/ps_slide_img_3.jpg" class="d-block w-100" alt="...">
							</div>
						</div>
					</div>
				</div>
				<form class="form-signIn">
					<div class="ps-group-001">
						<input type="text" class="ps-input-001" id="userid" placeholder="아이디"  autofocus>
					</div>
					<div class="ps-group-001"> 
						<input type="password" class="ps-input-001" id="userpw" placeholder="패스워드" >
					</div>
					<button class="btn ps-btn ps-btn-001" id="signIn-btn" type="button">로그인</button>
				</form>
				<div class="ps-group-002">
					<span class="ps-span-002">
						<a href="#">아이디 찾기</a>
					</span>
					<span class="ps-division-001"></span> 
					<span class="ps-span-002">
					<a href="#">비밀번호 찾기</a>
					</span>
				</div>
				<div class="ps-title-001">간편 로그인/가입</div>
				<div class="ps-group-002">	
					<span class="ps-span-003 ps-span-004">
						<a href="/view/signUp" class="ps-btn-002">
							<i class="fas fa-2x fa-paw"></i>
						</a>
					</span>
					<span class="ps-division-001"></span> 
					<span class="ps-span-003">
						<a href="#" class="ps-btn-002" onclick="authLogin('kakao_join')">
							<img  src="/resources/icon/kakao-talk.png">
						</a>
					</span>
					<span class="ps-division-001"></span> 
					<span class="ps-span-003">
					<a href="#" class="ps-btn-002" onclick="authLogin('naver_join')">
						<img  src="/resources/icon/naver.png">
					</a>
					</span>
				</div>
			</div> 
		</div>
	</div>


<script>
$(document).ready(function(){
	//슬라이드 순서 랜덤
	var ranNum = Math.random();
	var num = Math.floor(ranNum*3+1);
	$(".ps-slide-item-001").eq(num-1).addClass("active");
	
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
