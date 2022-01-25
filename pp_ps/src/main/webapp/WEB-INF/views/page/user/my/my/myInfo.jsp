<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

.myPageBody_title-group{

	
}
.userInfoForm_label{
	padding : .25rem;
	font-weight: bold;
}
.userInfoForm_span{
	display: block;
	background-color: #e9ecef;
	border-radius: 5px;
	padding:.5rem 1rem;
	min-height: 2.5rem;
}

.userInfoForm_input{

	background-color: #e9ecef;
	border : unset;
}

</style> 


<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>
<div class="d-flex">

	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10">
		<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">내 정보 - 나의 기본 정보</span>
		</div>
		<div class="myPageBody_content-group col-6 py-3">
			<form id="userInfoForm" name="userInfoForm">
				<div class="form-group">
					<label class="userInfoForm_label" for="userid">회원 아이디</label>
					<span class="userInfoForm_span" id="userid">
					<c:if test="${uvo.utype eq 'ps' }">
						${uvo.userid }
					</c:if>
					
					<c:if test="${uvo.utype eq 'kakao' }">
						카카오 로그인 입니다.
					</c:if>
					
					<c:if test="${uvo.utype eq 'naver' }">
						네이버 로그인 입니다.
					</c:if>
					
					</span>
				</div> 
				<div class="form-group">
					<label class="userInfoForm_label" for="username">이름</label>
					<input type="text" class="userInfoForm_input" name="username" id="username" value="${uvo.username }">
				</div>
				<div class="form-group">
					<label class="userInfoForm_label" for="uemail">이메일</label>
					<input type="text" class="userInfoForm_input" name="uemail" id="uemail" value="${uvo.uemail }">
				</div>
				<div class="form-group">
					<label class="userInfoForm_label" for="userAddr1">우편번호</label>
					<input type="text" class="userInfoForm_input" name="userAddr1" id="userAddr1" value="${uvo.userAddr1 }">
					<label class="userInfoForm_label" for="userAddr2">주소</label>
					<input type="text" class="userInfoForm_input" name="userAddr2" id="userAddr2" value="${uvo.userAddr2 }">
					<label class="userInfoForm_label" for="userAddr3">상세주소</label>
					<input type="text" class="userInfoForm_input" name="userAddr3" id="userAddr3" value="${uvo.userAddr3 }">
				</div>
				<div class="form-group">
					<label class="userInfoForm_label" for="username">가입날짜</label>
					<span class="userInfoForm_span "  id="username">${uvo.user_regdate }</span>
				</div>
				<div class="form-group">
					<label class="userInfoForm_label" for="username">회원 권한</label>
					<span class="userInfoForm_span" id="username">
						<c:if test="${uvo.ulevel == 1 }">일반 회원</c:if>
						<c:if test="${uvo.ulevel == 2 }">관리자</c:if>
					</span>
				</div>
				<div class="form-group">
					<button type="button" id="userInfoUpdate" class="btn btn-outline-primary float-right">수정하기</button>
				</div>
			</form>
		</div>
	</div>
	
</div>
<script>
$("#userInfoUpdate").on("click",function(){
	
	var con = confirm("변경된 회원 정보를 저장하시겠습니까?");
	
	if(con == true){
		
		var formData = $("#userInfoForm").serialize();
		
		$.ajax({
		
			url : "/user/userInfoUpdate",
			data : formData,
			type: "POST",
			success : function(data){
				
				if(data >= 1){
					
					location.reload();
					
				}else{
					
					alert("회원정보 수정에 실패하였습니다.");
					
				}
			}
		
		})	
	}
})

</script>
