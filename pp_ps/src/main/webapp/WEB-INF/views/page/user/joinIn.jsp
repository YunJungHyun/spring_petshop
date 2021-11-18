<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<div class="page">
	<div class="container">
		<div class="page-emptied-joinsort"></div>
		<div class="page-contents page-joinsort d-flex flex-column justify-content-center col-lg-4 ">
			
			
			<div class="page-banner-box">
				<h1 class="page-banner-title">로그인</h1>
			</div>
			<div class="page-box"> 
		 		
		 		<div id="page-joinsort-slide" class="carousel slide" data-ride="carousel" data-interval="1500">
					<div class="carousel-inner joinsort-slide-inner ">
						<div class="carousel-item joinsort-slide-join active " data-interval="1500">
							<img src="/resources/img/karsten-winegeart-oU6KZTXhuvk-unsplash.jpg"  class="d-block w-100" >
						</div>
						<div class="carousel-item joinsort-slide-join" data-interval="1500">
							<img src="/resources/img/alvan-nee-eoqnr8ikwFE-unsplash.jpg" class="d-block w-100" >
						</div>
						<div class="carousel-item joinsort-slide-join" data-interval="1500">
							<img src="/resources/img/karsten-winegeart-Qb7D1xw28Co-unsplash.jpg" class="d-block w-100">
						</div>
					</div>
				</div>
				
				<button class="joinsort-btn kakkao-join mb-1" id="kakao_join" name="join-btn">
					<svg class="MuiSvgIcon-root" focusable="false" viewBox="0 0 28 28" aria-hidden="true" role="img"><path d="M13.9996 7C9.36025 7 5.59961 9.9729 5.59961 13.6407C5.59961 16.0278 7.19305 18.1199 9.58453 19.2904C9.40885 19.9465 8.94841 21.6669 8.85594 22.0349C8.74227 22.4918 9.02356 22.4856 9.20772 22.3626C9.35211 22.2664 11.5096 20.7999 12.4404 20.1669C12.9455 20.2417 13.4667 20.2815 13.9996 20.2815C18.6388 20.2815 22.3996 17.3079 22.3996 13.6407C22.3996 9.9729 18.6388 7 13.9996 7Z" fill="#391B1B"></path></svg> 
					Kakao로 계속하기
				</button>
				
				<button class="joinsort-btn naver-join mt-1 mb-1" id="naver_join" name="join-btn">
					<svg class="MuiSvgIcon-root" focusable="false" viewBox="0 0 28 28" aria-hidden="true" role="img"><path d="M16.0773 21L11.1442 13.7531V21H6V7H11.2158L16.1494 14.2463V7H21.291V21H16.0773Z" fill="white"></path></svg>
					 Naver로 계속하기
				</button>
				<div class="collapse my-2" id="join-form-collapse">
					<div class="card card-body">
						<form>
							<div class="form-group">
								<label for="formGroupExampleInput">회원 아이디</label>
								<input type="text" class="form-control" id="userid" placeholder="USERID" value="userid">
							</div>
							<div class="form-group">
								<label for="formGroupExampleInput2">패스워드</label>
								<input type="password" class="form-control" id="userpw" placeholder="PASSWORD" value="12341234">
							</div>
						</form>
						<button class="petShop-login-btn" id="petShop-login-btn">
							로그인
						</button>
						<div class="d-flex justify-content-around my-2">
							<small class="help-userinfo-lose"><a href="#">아이디를 잊으셨나요?</a></small>
							<small class="help-userinfo-lose"><a href="#">비밀번호를 잊으셨나요?</a></small>
						</div>
							
					</div>
				</div>
				
				<button class="joinsort-btn petshop-join mt-1 d-flex justify-content-center" id="petShop_join" data-toggle="collapse" data-target="#join-form-collapse">
					<i class="fas fa-paw join-petshop-logo"></i> 
					<span class="join-petshop-logo-title">Petshop 로그인</span> 
				</button>
				
			</div> 
		</div>
		 
	</div>
</div>

<script>

$('.carousel').carousel({
	  interval: 1500,
	  pause : false
	})
	
$("button[name='join-btn']").on("click",function(){
		
	var join_sort = $(this).attr("id");
	
	if(join_sort == "petShop_join"){
		
		location.href="/view/user/signUpPage";
	}else{
		
		$.ajax({
			
			url : "/join/getAuthUrl/"+join_sort,
			success :function(data){
			
				location.href=data;
			}
		})
	}
	
})

$("#petShop-login-btn").on("click" , function(){
	
	
	if($("#userid").val() == ""){
		
		alert("아이디를 입력해주세요.");
		
		$("#userid").focus();
		return false;
	}
	if($("#userpw").val() == ""){
		
		alert("비밀번호를 입력해주세요.");
		
		$("#userpw").focus();
		return false;
	}
	
	
	$.ajax({
		
		url : "/join/petShop/login",
		data : {
			
			"userid" : $("#userid").val(),
			"userpw" : $("#userpw").val()
		},
		success : function(data){
			
			if(data == "idNotFound"){
				
				alert("아이디가 존재하지 않습니다.");
			}else if(data == "pwError"){
				
				alert("비밀번호가 틀렸습니다.")
			}else{
				
				alert("로그인 성공");
				location.href="/";
			}
		}
		
	})
	
	
})

	

</script>