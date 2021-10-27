<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page">
	<div class="container">
		<div class="page-contents page-join d-flex flex-column justify-content-center col-lg-8 ">
			
			
			<div class="page-banner-box">
				<h1 class="page-banner-title">회원가입</h1>
			</div>
			<div class="page-box"> 
		 		
		 		<form id="pet_join_form" name="pet_join_form">
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 mr-auto" for="userName">아이디</label>
		 					<input type="text" class="form-control col-sm-10" id="userid"  placeholder="아이디를 입력하세요." value="userid">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="useridHelp-reduplication" class="form-text text-muted">중복된 아이디입니다.</small>
		 					<small id="useridHelp-available" class="form-text text-muted">사용가능한 아이디입니다.</small>
		 					<small id="useridHelp-reg" class="form-text text-muted">"아이디는 공백 없이 6~20자 영소문자 또는 숫자이어야 합니다."</small>
		 				</div>  
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">비밀번호</label>
		 					<input type="password" class="form-control col-sm-10" id="userpw" aria-describedby="userpwHelp" placeholder="비밀번호를 입력하세요." value="12341234">
		 				</div>
		 				<div class="join-guide-text col-sm-10 ">
		 					<small id="userpwHelp-reg" class="form-text text-muted">비밀번호는 공백 없이 문자와 숫자를 8 ~ 24자로 작성해주세요.</small>
		 				</div>  
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">비밀번호 확인</label>
		 					<input type="password" class="form-control col-sm-10" id="userpwChk" aria-describedby="userpwChkHelp" placeholder="비밀번호를 다시 입력하세요." value="12341234">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="userpwHelp-chk-yes" class="form-text text-muted">비밀 번호가 확인되었습니다.</small>
		 					<small id="userpwHelp-chk-no" class="form-text text-muted">입력하신 비밀번호가 다릅니다.</small>
		 				</div> 
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="row">
		 					<label class="col-sm-2 m-auto" for="userName">이름</label>
		 					<input type="text" class="form-control col-sm-10" id="username" aria-describedby="usernameHelp" placeholder="이름을 입력하세요." value="윤정현">
		 				</div>
		 				<div class="join-guide-text col-sm-10">
		 					<small id="usernameHelp-reg" class="form-text text-muted">회원님의 이름을 한글로 작성해주세요.</small>
		 				</div>
		 			</div>
		 			<div class="form-group join-form-group">
		 				<div class="d-flex">
		 					<label class="my-auto" for="userName">반려동물 추가</label>
		 				
		 					<button class="d-flex  justify-content-center petAdd-btn">
		 						<i class="fas fa-paw fa-2x align-self-center"></i>
		 					</button> 
		 					 
		 				</div>
		 				<div class="petNameAdd-form">
		 					<div class="petNameAdd-list d-flex flex-column"> 
		 					
		 					</div>  
		 				</div>
		 			</div>  
		 		 	
		 		</form>
		 		
		  		<button class="petShop_reg_btn" id="petShop_reg_btn">회원가입완료</button>
			</div> 
		</div> 
	</div>
</div> 

<script> 

	
	var useridOkay= false;
	var userpwOkay= false;
	var userpwChkOkay= false;
	var usernameOkay= false;
	var userpetOkay = false;

	$(".petAdd-btn").on("click",function(e){
		e.preventDefault();   
		
		 
		var html = "<div class='d-flex my-1' name='pet_info' >";//
			html += "<select class='form-control petSort my-1' name='pet_sort'>";
			html += "<option value=''>선택</option>";
			html += "<option value='dog'>강아지</option>";
			html += "<option value='cat'>고양이</option>";
			html += "<option value='etc'>기타</option>";
			html += "</select>";
			html += "<select class='form-control petGender my-1' name='pet_gender'>";
			html += "<option value=''>성별</option>";
			html += "<option value='female'>암컷</option>";
			html += "<option value='male'>수컷</option>";
			html += "</select>";
			 
			html += "<input type='text' class='form-control petBirth my-1'name='pet_birth' placeholder='생년월일 ex) 20210101'>";
			html += "<input type='text' class='form-control petName my-1' name='pet_name'placeholder='이름을 입력하세요.'>";
			html += "<button class='petRemove-btn'><i class='fas fa-minus fa-2x align-self-center'></i>"
			html += "</button></div>";
			
		$(".petNameAdd-list").append(html);
	})
	
	
	$(document).on("click", ".petRemove-btn", function() {
    	
		
		
		$(this).parent("div").remove();
    	
	});
	
	var idReg =/^[a-z0-9]{5,19}$/;
	var pwReg =/^[A-za-z0-9]{8,24}$/;
	var nameReg =/^[가-힣]{2,6}$/;

	//입력한 회원아이디 존재여부, 표현식테스트
	$(document).on("blur","#userid",function(){
		
		var userid = $("#userid").val().trim();
	
		 
		if(userid != ""){
			
			if(!idReg.test(userid)){
				useridOkay = false;
				$("#useridHelp-reg").css("display","block");
				$("#useridHelp-reduplication").css("display","none");
				$("#useridHelp-available").css("display","none");
				return;
			}else{
				
				$.ajax({
					
					url : "/join/petShop/idCheck",
					async: false,
					data : {
						userid : $("#userid").val()
		
						},
						success:function(data){
							
							if(data >=1){
								
							
								useridOkay = false;
								$("#useridHelp-reg").css("display","none");
								$("#useridHelp-reduplication").css("display","block");
								$("#useridHelp-available").css("display","none");
								
							}else{  
								useridOkay= true;
								
								$("#useridHelp-reg").css("display","none");
								$("#useridHelp-reduplication").css("display","none");
								$("#useridHelp-available").css("display","block");
							}
						}
					})
					
					return useridOkay;
				
			}
			
		}else{
			useridOkay = false;
			$("#useridHelp-reg").css("display","none");
			$("#useridHelp-reduplication").css("display","none");
			$("#useridHelp-available").css("display","none");
		}
	})
	
	//비밀번호 정규표현식 체크
	$("#userpw").keyup(function(){
		 
	   
		if($("#userpw").val() != $("#userpwChk").val()){
			userpwOkay = false;
			$("#userpwChk").val("");
			$("#userpwHelp-chk-no").css("display","none");
			$("#userpwHelp-chk-yes").css("display","none");
		}
		
		if($("#userpw").val() ==""){
			userpwOkay = false;
			userpwChkOkay = false;
			//alert(userpwOkay);
		}
		 
		
		
		if($("#userpw").val()!="" && !pwReg.test($("#userpw").val())){
			userpwOkay = false;
			$("#userpwHelp-reg").css("display","block");
			 
		}else if (pwReg.test($("#userpw").val())){
			 
			userpwOkay =true;
			$("#userpwHelp-reg").css("display","none");
		}
		
		
		
		
	})
	//입력한 비밀번호 확인
	$("#userpwChk").on("propertychange change keyup paste input", function() {
		 if($("#userpw").val() != $("#userpwChk").val()){
			
			$("#userpwHelp-chk-no").css("display","block");
			$("#userpwHelp-chk-yes").css("display","none");
			userpwChkOkay= false;
		}else{
			$("#userpwHelp-chk-no").css("display","none");
			$("#userpwHelp-chk-yes").css("display","block");
			userpwChkOkay= true;
		}
	
	})
	
	//이름 한글 정규표현식
	$("#username").blur(function(){
		
		if( $("#username").val() !=""  && !nameReg.test($("#username").val())){
			
			usernameOkay=false;
			$("#usernameHelp-reg").css("display", "block");
			
			
		}else{
			usernameOkay=true;
			$("#usernameHelp-reg").css("display", "none");
		}
		
	})
	
	
	
	$(document).on("click","#petShop_reg_btn",function(){
		
		
		
		if($("#userid").val()==""){
			
			alert("아이디를 입력해주세요.");
			
			$("#userid").focus();
				
				
			return false;	 
			
		}
		
		
		
		if($("#userpw").val()==""){
			
			alert("비밀번호를 입력해주세요.");
			$("#userpw").focus();
			return false;
		}
		if($("#userpwChk").val()==""){
			
			alert("비밀번호 확인란을 입력해주세요.");
			$("#userpwChk").focus();
			return false;
		}
		if($("#username").val()==""){
			
			alert("이름을 입력해주세요.");
			$("#username").focus();
			return false;
		}
		
		
		
		var userid = $("#userid").val();
		var userpw = $("#userpw").val();
		var username = $("#username").val();
		//var petInfoLen =$("div[name=pet_info]").length;
		
		var petBirthReg =/^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var petNameReg =/^[가-힣]{1,6}$/;
		var userData = new Object();
		
		var pet_info  = { };
		
		if($("div[name=pet_info]").length >= 1){
			
			
			
			$("div[name=pet_info]").each(function(i){
					
				var pet_info_ ={
						
						'i' : "pet_info_"+( i + 1 ) 
				};
				
				
				
				var pet_one_line = new Object();
				
				
				var petSort= $("div[name=pet_info]").eq(i).children("select[name=pet_sort]").val();
				var petGender= $("div[name=pet_info]").eq(i).children("select[name=pet_gender]").val();
				var petBirth = $("div[name=pet_info]").eq(i).children("input[name=pet_birth]").val();
				var petName = $("div[name=pet_info]").eq(i).children("input[name=pet_name]").val();
				/* 펫 정보 유효성 검사  */
				if(petSort == ""){
					$("div[name=pet_info]").eq(i).children("select[name=pet_sort]")[0].focus();
					userpetOkay =false;
					alert("반려동물 종류를 선택해주세요.!");
					return false;
				}
				if(petGender == ""){
					$("div[name=pet_info]").eq(i).children("select[name=pet_gender]")[0].focus();
					userpetOkay =false;
					alert("반려동물 성별을 선택해주세요.!");
					return false;
				}
				if(petBirth == ""){
					$("div[name=pet_info]").eq(i).children("input[name=pet_birth]").focus();
					userpetOkay =false;
					alert("반려동물 생년월일을 입력해주세요.!");
					return false;
				}
				
				if(!petBirthReg.test(petBirth)){
					$("div[name=pet_info]").eq(i).children("input[name=pet_birth]").focus();
					userpetOkay =false;
					alert("반려동물의 생년월일을 특수문자 없이 8자리 정확히 입력해주세요.");
					return false;
				}

				
				if(petName == ""){
					$("div[name=pet_info]").eq(i).children("input[name=pet_name]").focus();
					userpetOkay =false;
					alert("반려동물 이름을 입력해주세요.!");
					return false;
				}
				if(!petNameReg.test(petName)){
					$("div[name=pet_info]").eq(i).children("input[name=pet_name]").focus();
					userpetOkay =false;
					alert("반려동물의 이름을 특수문자 없이 1~6자리 입력해주세요.");
					return false;
				}
				/* 펫 정보 유효성 검사  */
				
				pet_one_line.pet_sort =petSort;
				pet_one_line.pet_gender =petGender;
				pet_one_line.pet_birth =petBirth;
				pet_one_line.pet_name =petName;

				pet_info[pet_info_['i']] =pet_one_line;
				
				userpetOkay =true;
				
			})
			
			
		}else{
			
			userpetOkay = true;
		}
		
		console.log(pet_info);
		
		userData.userid= userid;
		userData.userpw= userpw;
		userData.username= username;
		userData.pet= pet_info;
		
		
	
	 	if(useridOkay == true && userpwOkay == true && userpwChkOkay == true && usernameOkay == true && userpetOkay == true  ){
	  	  $.ajax({
			
				url : "/join/petShop",
				data :userData,
				method: "POST",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "json",
				success : function(data){
				
					console.log(userData);
				}
			
			})   
	 	}else{
	 		
	 		console.log("id : "+useridOkay+"/ pw : "+userpwOkay+"/ pwchk : "+ userpwChkOkay+"/ name :"+ usernameOkay+"/ pet :"+ userpetOkay );
	 		
	 	}
	})  
	
</script>