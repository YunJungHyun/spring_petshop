<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="pt-4">
</div> 
<div class="page">
	<div class="col-6"> 
			<div class="page-title-001"> 
				<span class="ps-span-001">회원가입</span>
			</div>
			<div class="page-box"> 
			<form id="form-signUp" name="form-signUp">
		 		<div class="row"> 
		 			<div class="col-12 ps-group-003">
						<label for="userid">아이디</label>
							<input type="text" class="form-control signUp-input" id="userid" name="userid" placeholder="아이디를 입력하세요."  value="">
						<div class="invalid-feedback id-feed">
							<span class="feed-1">아이디를 입력해주세요.</span>
							<span class="feed-2">아이디는 6~20자 영문이나 숫자를 사용하여 작성해주세요.</span>
							<span class="feed-3">중복된 아이디입니다.</span>
							<span class="feed-4" style="color:green">사용 가능한 아이디입니다.</span>
						</div>
					</div>
		 			<div class="col-12  ps-group-003">
						<label for="userid">회원 이름</label>
							<input type="text" class="form-control signUp-input" id="username" name="username" placeholder="이름을 입력하세요." value="" >
						<div class="invalid-feedback">
							<span class="feed-1">이름을 입력해주세요.</span>
							<span class="feed-2">이름은 2자 이상 한글로만 작성해주세요.</span>
						</div> 
					</div>
		 			<div class="col-12  ps-group-003">
						<label for="userpw">비밀번호</label>
							<input type="password" class="form-control signUp-input" id="userpw"  name="userpw" placeholder="비밀번호를  8자리 이상 입력하세요."  value="" >
						<div class="invalid-feedback">
							<span class="feed-1">비밀번호를 입력해주세요.</span>
							<span class="feed-2">비밀번호는 알파벳,숫자,특수문자를 포함하여 8 ~ 24자로 작성해주세요.</span>
						</div>
					</div>
		 			<div class="col-12  ps-group-003 ">
						<label for="firstName">비밀번호 확인</label>
							<input type="password" class="form-control signUp-input"  id="userpwChk"  placeholder="비밀번호를 한 번 더 입력하세요."  value="" >
						<div class="invalid-feedback">
							<span class="feed-1">비밀번호를 한 번 더 입력해주세요.</span>
							<span class="feed-2">작성하신 비밀번호가 다릅니다.</span>
						</div>
					</div>
		 			<div class="col-12  ps-group-003 ">
						<label for="firstName">이메일</label>
							<input type="email" class="form-control signUp-input" id="uemail"  name="uemail" placeholder="이메일을 입력하세요."  value="" >
						<div class="invalid-feedback">
							<span class="feed-1">이메일을 입력해주세요.</span>
							<span class="feed-2">이메일을 정확히 입력해주세요.</span>
						</div>
					</div>
		 		
		 		</div>
		 		<input type="hidden" name="utype" value="ps">
		 		<input type="hidden" name="ulevel" value="1">
		 		<button class="btn ps-btn ps-btn-001" id="signUp-btn" type="button">회원가입</button> 
		 		</form>
			</div> 
		</div>  
	</div> 
  

<script> 
$("#signUp-btn").on("click",function(){ 
	

	var idRegExp = /^[A-Za-z0-9+]{6,20}$/g;
	var nameRegExp = /[가-힣]{2,}/;
	var pwRegExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,24}$/;
	var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	var idChk = false;
	var nameChk = false;
	var pwChk = false;
	var pwCChk = false;
	var emailChk = false;
	
	
	$(".signUp-input").each(function(){
		$(this).next().children("span").css("display","none");
		
		if($(this).val().trim() == ""){
			
			$(this).next().children(".feed-1").css("display","block");
			
		}else{ 
			switch($(this).attr("id")){
				case "userid" :
					if(!idRegExp.test($(this).val())){
						
					
						$(".id-feed span").each(function(){
							
							if($(this).css("display") == "block"){
								
								$(this).css("display","none");
							}
						})
						
						idChk = false;
						$(this).next().children(".feed-2").css("display","block");
						$(this).focus();
						
					}else{
						
						$.ajax({
							
							url : "/join/idCheck",
							data : {
								"userid" : $(this).val()
							},
							async:false,
							success :function(data){
								
								if(data >= 1){ 
									
									$("#userid").next().children(".feed-3").css("display","block");
									
								}else{
									
									$("#userid").next().children(".feed-4").css("display","block");
									idChk = true;
								}
								
							}
						})
						
					}
					break;
				case "username" :
					if(!nameRegExp.test($(this).val())){
						
						nameChk= false;
						$(this).next().children(".feed-2").css("display","block");
						$(this).focus();
					}else{
						nameChk= true;
						$(this).next().children("span").css("display","none");
					}
					break;
				case "userpw" :
					if(!pwRegExp.test($(this).val())){
						
						pwChk= false;
						$(this).next().children(".feed-2").css("display","block");
						$(this).focus();
					}else{
						pwChk= true;
						$(this).next().children("span").css("display","none");
						$(this).focus();
					}
					break;
				case "userpwChk" :
					if($(this).val() != $("#userpw").val()){
						pwCChk = false;
						$(this).next().children(".feed-2").css("display","block");
						$(this).focus();
					}else{
						
						pwCChk = true;
						$(this).next().children("span").css("display","none");
					}
					
					break;
				case "uemail" :
					
					
					if(!emailRegExp.test($(this).val())){
						emailChk = false;
						$(this).next().children(".feed-2").css("display","block");
						$(this).focus();
					}else{
						
						emailChk = true;
						$(this).next().children("span").css("display","none");
					}
					break; 
			
			}
			
		}
		
		
	})
	
	if(idChk == true && nameChk == true && pwChk == true && pwCChk == true && emailChk == true  ){
		
	  
			var queryString = $("form[name=form-signUp]").serialize() ;

		
		$.ajax({
			
			url : "/join/signUp",
			data : queryString,
			success : function(data){ 
				
				if(data == "success"){
					
					location.href="/view/signUpAfter";
				}
				if( data=="sighUpfail"){
					
					alert("회원가입에 실패하였습니다. 고객센터에 문의하세요.");
				}
			}
			
		})
	}
})


	
</script>