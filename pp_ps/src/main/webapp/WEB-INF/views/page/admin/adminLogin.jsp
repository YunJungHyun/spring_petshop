<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page">
	<div class="container">
		<div class="page-emptied-joinsort"></div>
		<div class="page-contents page-joinsort d-flex flex-column justify-content-center col-lg-4 ">
			
			
			<div class="page-banner-box">
				<h1 class="page-banner-title">관리자 로그인</h1>
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
				
				
				<div class="my-2" id="join-form-collapse">
					<div class="card card-body">
						<form>
							<div class="form-group">
								<label for="formGroupExampleInput">관리자 아이디</label>
								<input type="text" class="form-control" id="adminid" placeholder="ADMINID" value="admin">
							</div>
							<div class="form-group">
								<label for="formGroupExampleInput2">패스워드</label>
								<input type="password" class="form-control" id="adminpw" placeholder="PASSWORD" value="12341234">
							</div> 
						</form>
						<button class="admin-login-btn" id="admin-login-btn">
							로그인
						</button>
						
							
					</div>
				</div>		 
			</div> 
		</div>
		 
	</div>
</div>

<script>
$('.carousel').carousel({
	  interval: 1500,
	  pause : false
	})
	
$("#admin-login-btn").on("click" , function(){
	
	
	
	if($("#adminid").val() == ""){
		
		alert("아이디를 입력해주세요.");
		
		$("#adminid").focus();
		return false;
	}
	if($("#adminpw").val() == ""){
		
		alert("비밀번호를 입력해주세요.");
		
		$("#adminpw").focus();
		return false;
	}
	
	
	
	$.ajax({
		
		url : "/join/admin/login",
		data : {
			
			"adminid" : $("#adminid").val(),
			"adminpw" : $("#adminpw").val()
		},
		success : function(data){
			
			if(data == "idNotFound"){
				
				alert("아이디가 존재하지 않습니다.");
			}else if(data == "pwError"){
				
				alert("비밀번호가 맞지않습니다.")
			}else{
				
				alert("로그인 성공");
				location.href="/view/admin/managementPage";
			}
		}
		
	})
	
})
</script>
