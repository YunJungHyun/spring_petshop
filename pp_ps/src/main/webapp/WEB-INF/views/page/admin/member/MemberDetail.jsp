<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.user-content_group-sub-title{

	border-bottom : 1px solid #dee2e6;
}

.memberInfoForm_label{
	padding : .25rem;
	font-weight: bold;
}
.memberInfoForm_span{
	display: block;
	background-color: #e9ecef;
	border-radius: 5px;
	padding:.5rem 1rem;
	min-height: 2.5rem;
}
.memberInfoForm_input{

	background-color: #e9ecef;
	border : unset;
} 


</style> 

<%@ include file="/WEB-INF/views/page/admin/member/MemberDetailHeader.jsp"%>
<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/admin/member/MemberDetailLeft.jsp"%>
		<div class="memberPageBody col-10 ">
			<div class="memberPageBody_title-group">
				<span class="memberPageBody_title-group_span">회원 기본 정보</span>
			</div>
				
				<div class="user-content_group col-6">
					<form id="memberInfoForm" name="memberInfoForm">
						<div class="form-group"> 
							<label class="memberInfoForm_label" for="unum">회원 번호</label>
							<input type="text" class="memberInfoForm_input" name="unum" id="unum" readonly="readonly" value="${uvo.unum }">
						</div> 
						<div class="form-group">
							<label class="memberInfoForm_label" for="utype">회원 유형</label>
							<span class="memberInfoForm_span" id="utype">
								<c:if test="${uvo.utype eq 'ps' }">펫샵</c:if>
								<c:if test="${uvo.utype eq 'kakao' }">카카오</c:if>
								<c:if test="${uvo.utype eq 'naver' }">네이버</c:if>
							</span>
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for=userid>회원아이디</label>
							<span class="memberInfoForm_span" id="userid">
								${uvo.userid }
							</span>
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="username">이름</label>
							<input type="text" class="memberInfoForm_input" name="username" id="username" value="${uvo.username }">
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="uemail">이메일</label>
							<input type="text" class="memberInfoForm_input" name="uemail" id="uemail" value="${uvo.uemail }">
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="userAddr1">우편번호</label>
							<input type="text" class="memberInfoForm_input" name="userAddr1" id="userAddr1" value="${uvo.userAddr1 }">
							<label class="memberInfoForm_label" for="userAddr2">주소</label>
							<input type="text" class="memberInfoForm_input" name="userAddr2" id="userAddr2" value="${uvo.userAddr2 }">
							<label class="memberInfoForm_label" for="userAddr3">상세주소</label>
							<input type="text" class="memberInfoForm_input" name="userAddr3" id="userAddr3" value="${uvo.userAddr3 }">
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="user_regdate">가입날짜</label>
							<span class="memberInfoForm_span "  id="user_regdate">${uvo.user_regdate }</span>
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="username">회원 권한</label>
							
							<select class="custom-select" id="ulevel" name="ulevel">
								<option value="1" <c:if test="${uvo.ulevel == 1 }">selected</c:if>>일반 회원</option>
								<option value="2" <c:if test="${uvo.ulevel == 2 }">selected</c:if>>관리자</option>
							</select>
							
						</div>
						<div class="form-group">
							<button type="button" id="memberInfoUpdate" class="btn btn-outline-primary float-right">수정하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>


<script>

$("#memberInfoUpdate").on("click",function(){
	
	var con = confirm("변경된 회원 정보를 저장하시겠습니까?");
	if(con == true){
		
		var formData = $("#memberInfoForm").serialize();
		
		$.ajax({
			
			url : "/user/memberInfoUpdate",
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

