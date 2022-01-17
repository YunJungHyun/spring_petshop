<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.user-content {
	display: flex;
	min-height: 40rem;
}
.page-content_group{
	
}
.sub-title-span{
	font-size: 1.5rem;
	font-weight: bold;
	
	display: block
	
}

.user-content_group-sub-title{

	border-bottom : 1px solid #dee2e6;
}
.user-content_group{
	padding : 1rem;
}
.memberInfoForm_label{
	padding : .25rem;
	font-weight: bold;
}
.memeberInfoForm_span{
	display: block;
	background-color: #e9ecef;
	border-radius: 5px;
	padding:.5rem 1rem;
}
.infoUpdate{

	 background-color: #7fe7d552;
	 font-weight: bold;
}
.btn-box {
    text-align: right;
}
</style>
<div class="page">
	<div class="page-container">
		<%@ include
			file="/WEB-INF/views/page/admin/member/MemberDetailHeader.jsp"%>
		<div class="page-content user-content">
			<%@ include
				file="/WEB-INF/views/page/admin/member/MemberDetailLeft.jsp"%>

			<div class="col-10 page-content_group">
				<div class="user-content_group user-content_group-sub-title">
					<span class="sub-title-span">
						회원 기본 정보 
					</span>
				</div>
				
				<div class="user-content_group col-6">
					<form id="memberInfoForm" name="memberInfoForm">
						<input type="hidden" id="unum" name="unum" value="${uvo.unum }">
						
						
						<div class="form-group">
							<label class="memberInfoForm_label" for="utype">가입유형</label> 
							<span class="memeberInfoForm_span">${uvo.utype }</span>
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="userid">회원 아이디</label> 
							<span class="memeberInfoForm_span">${uvo.userid }</span>
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="username">이름</label> 
							<input type="text" class="form-control" readonly="readonly"  id="username" name="username" value="${uvo.username }">
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="uemail">이메일</label> 
							<input type="text" class="form-control" readonly="readonly"  id="uemail" name="uemail" value="${uvo.uemail }">
						</div>
						<div class="form-group">
							<label class="memberInfoForm_label" for="ulevel">권한</label> 
							<select class="custom-select" name="ulevel" id="ulevel" onFocus="this.initialSelect = this.selectedIndex;" onChange="this.selectedIndex = this.initialSelect;">
								<option value="1" <c:if test="${uvo.ulevel ==1 }"> selected </c:if> >일반 회원</option>
								<option value="2" <c:if test="${uvo.ulevel ==2}"> selected </c:if> >관리자</option>
							</select>
						</div>
					
						<div class="form-group btn-box">
							<button type="button" class="btn btn-primary" id="update-userInfo-confirm-btn">수정하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

$("#update-userInfo-confirm-btn").on("click",function(){
	
	
	if($("#update-userInfo-btn").length > 0){
		
		
		return false;
		
	}
	
	var con = confirm("회원정보를 수정하시겠습니까?")
	
	if( con == true){
		
		var btnHtml ="<button type='button' class='btn btn-outline-success ' id='update-userInfo-btn'>완료</button>";
			btnHtml +="<button type='reset' class='btn btn-outline-danger ml-1'>취소</button>";
		$("#username").attr("readonly",false);
		$("#uemail").attr("readonly",false);
		$("#ulevel").attr("onFocus","");
		$("#ulevel").attr("onChange","");
		
		$("#username").addClass("infoUpdate");
		$("#uemail").addClass("infoUpdate");
		$("#ulevel").addClass("infoUpdate");
		
		$("#username").focus();
		
		$(".btn-box").append(btnHtml);
	}
	
})

$(document).on("click","#update-userInfo-btn",function(){
	
	var con =confirm("바뀐 회원 정보를 저장하시겠습니까?");
	
	
	
	if(con == true){
		var formData = $("#memberInfoForm").serialize();
	
		$.ajax({
			
			url : "/user/userInfoUpdate",
			data : formData,
			type: "POST",
			success : function(data){
				
				if(data>=1){
					
					alert("회원정보가 수정되었습니다.");
					location.reload();
				}else{
					
					alert("회원정보 수정 실패하였습니다.");
					location.reload();
				}
				
			}
			
		})
	}
	
})
</script>

