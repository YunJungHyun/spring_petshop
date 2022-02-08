<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="/resources/css/user-product.css" rel="stylesheet" type="text/css">
<style>
	.question-box_input{
	    padding: 1rem;
    	border-top-right-radius: unset;
   	 border-bottom-right-radius: unset;
    }
	
	.question-box_button{
	
		 background-color: #70e1ce;
		 border-top-left-radius : unset;
		 border-bottom-left-radius:unset;
	}
	
	.QnA-relpyList-one {
    padding: 0.5rem 1rem;
    background-color: #d6f7f2;
        display: flex;
	
	    border-radius: 5px;
    margin: 0.5rem 0rem;
}
.reply-content-span {
    display: inline-flex;
    flex-direction: column;
    margin: 0px 1rem;
    width: 100%;
}

.reply-writer-info{
    font-size: .75rem;
    font-weight: bold;
    margin-bottom: 0.25rem;
    padding: 0.25rem;

}
.reply-icon-span {
 
    align-self: center;
}

.reply-content { 
    padding: 0.75rem 0.5rem;
}
span.QnA-relpyList-span {
    padding: 1rem;
    background-color: #d6f7f2;
    width: 100%;
    display: block;
    border-radius: 5px;
    font-weight: bold;
    font-size: 1.25rem;
}

.empty-info {
    border-radius: 5px;
    border: 1px solid #dee2e6;
    padding: 3rem 2rem;
    font-size: 1.25rem;
    font-weight: bold;
    background-color: #d6f7f2;
}

.pbrand {
    display: block;
    text-align: left;
}

.plike{
	float:right;
	
}
.plike_img{
	width:2.5rem;
}
 
</style>
<div class="page pt-3">
	<div class="page-container">
		<div class="page-content">
			<div class="page-content_group">
				<div class="row">
					<div class="col-lg-6 page-content_group_box">
						<img id="this-img" src="" />
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
							<div class="info-box_group pname-pbrand">
								<span class="badge pname-pbrand_span pbrand">
									<a href="#" class="pname-pbrand_span_a">${pvo.pbrand}</a>
								</span>
								<span class="pname-brand_span pname">${pvo.pname }</span>
								<span class="badge pname-brand_span plike" id="plike_span">
									<button type="button" onclick="like('${pvo.pid}')">
										<img src="/resources/icon/heart_empty.png" class="plike_img">
									</button>
								</span>
							</div>   
						 
							<div class="info-box_group info-pprice info-padding">
								<c:set value="${pvo.pprice }" var="price"/>
								<c:if test="${pvo.psale > 0 }">
									
									<c:set value="${pvo.psale }" var="sale"/>
									<div class="info-box_group_box">
										<span class="info-box_group_span pprice_title">정가</span>
										<span class="info-box_group_span pprice_info">
											<fmt:formatNumber value="${price}" pattern="###,###"/>원
										
										</span>
									</div>
									<div class="info-box_group_box">
										<span class="info-box_group_span pprice-psale_title">할인가</span>
										<span class="info-box_group_span pprice-psale_info">
											<c:set var="price" value="${price - (price * sale)}"/>
											<fmt:formatNumber type="number" pattern="###,###,###" value="${price + (10-(price%10))%10}"/>원 
											
										
										</span>
									</div>
								</c:if> 
								<c:if test="${pvo.psale == 0 }">
								
									<div class="info-box_group_box">
										<span class="info-box_group_span">정가</span>
										<span class="info-box_group_span">
											<fmt:formatNumber value="${price}" pattern="###,###"/>원
										</span>
									</div>
								</c:if>
								<input type="hidden" value="${price + (10-(price%10))%10}" id="result-price"/>
								
							</div>  
						
							<div class="info-box_group pcnt info-padding">
								<span class="info-box_group_span pcnt-title">입고 상태</span> 
								<span class="info-box_group_span">
									<c:if test="${pvo.pcnt >=1 }"> 
										<span style="color:green;">재고 있음</span>
									</c:if>
									<c:if test="${pvo.pcnt <1 }">
										<span style="color:red;">재고 없음</span>
									</c:if>
								</span>
							</div>
							<div class="info-box_group info-padding">
								<ul class="info-box_group_ul">
									<li>오늘 출발 마감까지 -12분남음</li>
									<li>저녁 6시 이전 주문하면 오늘 출발! / 영업일 기준</li>
									<li>30,000원 이상 구매 시, 무료배송</li>
								</ul>
							</div>
							<div class="info-box_group user-input-group">
								<div class="user-input-group_tilte">
									<span class="badge user-input-group_tilte_span">
										수량
									</span>
									<span class="badge user-input-group_tilte_span">
										총 상품 금액
									</span>
								</div>
						
								<div class="user-input-group_box user-self">
									<div class="btn-group user-self_btn-group">
										<button type="button" class="user-self_btn" onclick="productCnt('-')">
											<i class="fas fa-minus"></i>
										</button>
										<input type="text" class="user-self_input" id="ps-cnt" value="1" readonly="readonly"/>
										<button type="button" class="user-self_btn" onclick="productCnt('+')">
											<i class="fas fa-plus"></i>
										</button>
									</div>
									<div class="user-self_result-box">
										<span class="sum-price">
											<fmt:formatNumber type="number" pattern="###,###,###" value="${price + (10-(price%10))%10}"/>
										</span>원
									</div>
								</div>
						
							</div>
							<div class="info-box_group  shopping-group">
								<div class="info-box_group_box shopping-btn-group">
									<button type="button" class="btn btn-outline-primary shopping-btn-group_button" onclick="cart()">장바구니 담기</button>
									<button type="button" class="btn btn-primary shopping-btn-group_button" id="now-order-btn"  data-toggle="modal" data-target="#orderModal">바로 주문</button>
								</div>
							</div> 
						</div>
					</div>
				</div>  
			</div>  
		</div>
		<hr>
		<div class="page-content">
			<div class="card page-content_group product-info-card">
				<div class="card-header product-info-card_cardheader">
					<ul class="nav nav-tabs product-info-card_cardheader_tabs card-ul">
						<li class="nav-item card-ul_li col-3">
							<a class="card-ul_li_a active" href="#pexplicate" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="pexplicate" > 제품 정보</a>
						</li> 
						<li class="nav-item card-ul_li col-3">
							<a class="card-ul_li_a QnAMenu" href="#QnA" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="QnA">질문/답변</a>
						</li>
						<li class="nav-item card-ul_li col-3">
							<a class="card-ul_li_a reviewMenu"  href="#review" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="#review">구매후기</a>
						</li>
						<li class="nav-item card-ul_li col-3">
							<a class="card-ul_li_a noticeMenu" href="#notice" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="#notice">취소/교환/반품 안내</a>
						</li>
					</ul>  
				</div>
				<div class="tab-content-all" style="min-height:600px">
					<div class="tab-content collapse show" id="pexplicate">
						<div class="card-body ps-card-body">
							${pvo.pexplicate }
						</div>
					</div>
					<div class="tab-content collapse" id="QnA">
						<div class="card-body ps-card-body">
							
							<div class="QnA-container">
								<div class="QnA-container_group QnA-input-group mb-2 pb-2 border-bottom">
									<div class="QnA-content mb-2">
										<form id="questionForm" name="questionForm" >
											<div class="QnA-content question-box">
											
												<input type="text" id="qnaContent" name="qnaContent" class="question-box_input col-10" placeholder="제품에 대해 질문해주세요!"/>
												<button type="button" id="questionInsert-btn" class="btn question-box_button col-2">질문 하기</button>
											</div>
										</form>
									</div>
								</div>
								<div class="QnA-container_group">
									<div class="QnAListContainer">
									
										
										<c:if test="${fn:length(qList) != 0 }"> 
										
										<c:forEach items="${qList }" var="list"> 
											<c:if test="${empty list.parentid }">
												<div class="qna-one-content border-bottom mb-2">
													<div class="qna-userInfo"> 
														<span class="qna-userInfo_span">${list.username}/${list.qnaDate }</span>					
													</div>
													<div class="qna-content mb-2">
														<span class="qna-content_span">${list.qnaContent }</span>
														
														<button class="qna-content_a"  data-toggle="collapse" data-target="#sub-${list.qnaid }">답변보기 (<span id="cnt-${list.qnaid }">0</span>)</button>
													</div>
													<div class="collapse subQnAList" id="sub-${list.qnaid}">
														
													</div>
												</div>  
											</c:if>
										</c:forEach> 
										</c:if>
										<c:if test="${fn:length(qList) == 0 }">
											<div class="empty-info">작성된 문의가 없습니다.</div>
										</c:if>
									</div> 
								</div>
							</div>
						</div>
					</div>
					<div class="tab-content collapse" id="review"> 
						<div class="card-body ps-card-body">
							<c:if test="${fn:length(rList) == 0}">
								<div class="empty-info">
									구매후기가 없습니다.
								</div>
							</c:if>
							<c:forEach items="${rList }" var="rlist">
								<div class="review-one-content border-bottom">
									<div class="review-userInfo">
										<span class="review-userInfo_span">${rlist.username}</span>
										<span class="review-rating">
											<c:set value ="${rlist.rating * 20 }" var = "rating"/>
								
											<span class="info-rating_span"> 
												<span class="rating" style="width:${rating}%"></span>
											</span>
							
										</span>
									</div>
									<div class="review-one-review-content">
										${rlist.revContent }
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="tab-content  collapse" id="notice">
						<div class="card-body ps-card-body">
							공지
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center" id="orderModallabel">주문 정보 입력</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
			<form id="form-order" name="form-order">
		 		<div class="row">
		 			<input type="hidden" id="cstock" name="cstock" value="1"/>
		 			<input type="hidden" id="pid" name="pid" value="${pvo.pid }"/>
		 			<input type="hidden" id="pprice" name="pprice" value="${pvo.pprice }"/>
		 			<input type="hidden" id="psale" name="psale" value="${pvo.psale }"/>
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0">
						<label for="orderRec">받는 사람</label>
							<input type="text" class="form-control" id="orderRec" name="orderRec" placeholder="제품을 수령 받는 분의 이름을 입력하세요." value="test-orderRec">
						<div class="invalid-feedback">
						
						</div>
					</div>
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0">
						<label for="orderPhon">휴대 전화</label>
							<input type="text" class="form-control " id="orderPhon" name="orderPhon" placeholder="휴대 전화 번호를 입력하세요." value="test-orderPhon">
						<div class="invalid-feedback">
							
						</div> 
					</div>
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0">
						<label for="userAddr1">우편 번호</label>
							<input type="text" class="form-control " id="userAddr1" name="userAddr1" placeholder="우편 번호를 입력하세요" value="test-userAddr1">
						<div class="invalid-feedback">
							
						</div>
					</div>
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0">
						<label for="userAddr2">주소</label>
							<input type="text" class="form-control " id="userAddr2" name="userAddr2" placeholder="주소를 입력하세요." value="test-userAddr2">
						<div class="invalid-feedback">
							
						</div>
					</div>
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0">
						<label for="userAddr3">상세 주소</label>
							<input type="text" class="form-control " id="userAddr3" name="userAddr3" placeholder="상세 주소를 입력하세요." value="test-userAddr3">
						<div class="invalid-feedback">
							
						</div>
					</div>
		 			
		 			<div class="col-lg-12 mb-3 form-ps-group-1 my-0 border-top text-right">
						
							 <span class="span-cart-allPriceSum ">
								결제 금액 : 
								<span class="sum-price">
									<fmt:formatNumber value="${price + (10-(price%10))%10}" pattern="###,###"/> 원
								</span>
								<input type="hidden" class="form-control " id="amount" name="amount" value="<fmt:parseNumber value="${price + (10-(price%10))%10}" integerOnly="true"/>">
							</span>
					
						
					</div>
		 		</div>
		 		
		 		 
		 	</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="order-btn">주문</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<script>

$(document).ready(function(){
	var userInfo = "${userInfo}";
	
	var pid ="${pvo.pid}";
	if(userInfo != ""){
		$.ajax({
			url : "/like/check",
			type: "POST",
			data:{
				
				"pid" :pid
			},
			success:function(data){
				
				console.log(data);
				if(data>=1){
					
					$(".plike_img").attr("src","/resources/icon/heart.png");
					$(".plike_img").addClass("likeChk");
				}
			}
		
		})
	}
	
	
	var JSONQnACnt = JSON.parse('${qCnt}');
	
	
	for(var i = 0 ; i < JSONQnACnt.length;i++){
	
		var parentid = JSONQnACnt[i].parentid;
		
		
		$("#cnt-"+parentid).text(JSONQnACnt[i].eachCnt);
		
	}
})


function like( pid ){
	
	var userInfo = "${userInfo}";
	
	if(userInfo == ""){
		
		location.href="/view/login?go=login";
	}else{
		
		
		if($(".plike_img").hasClass("likeChk")){
			
			$.ajax({
				
				url : "/like/delete",
				type : "post",
				data : {
					
					"pid" : pid
				},success: function(data){
					
					if( data>=1){
						
						location.reload();
					}else{
						
						alert("관심 목록 삭제에 실패하였습니다.");
						location.reload();
					}
				}
				
			}) 
		}else{
			
			
			
			
			
			 $.ajax({
				
				url : "/like/insert",
				type : "post",
				data : {
					
					"pid" : pid
				},success: function(data){
					
					if( data>=1){
						
						location.reload();
					}else{
						
						alert("관심 목록 등록에 실패하였습니다.");
						location.reload();
					}
				}
				
			}) 
			
		}
		
		
	}
}

$(".subQnAList").on("show.bs.collapse",function(){
	
	var qnaid = $(this).attr("id").split("-")[1];
	
	$("#sub-"+qnaid).empty();
	
	$.ajax({
		
		url : "/QnA/AdminReplyList",
		data: {
			
			"qnaid" : qnaid
		},
		type:"POST",
		success:function(data){
			
		var html = "<div class='QnA-replyList mb-3'>";
			
			if(data.length ==0){
				
				html+="<span class='QnA-relpyList-span'>아직 답변이 없습니다.</span>"	
			}else{
			
			
					
				for(var i = 0 ; i<data.length ;i++){
					
					html+="<div class='QnA-relpyList-one'>";
						html+="<span class='reply-icon-span'>";	
							html+="<img src='/resources/icon/reply.png'>"
						html+="</span>";
						html+="<span class='reply-content-span'>";
							html+="<span class='reply-writer-info border-bottom'>"
								html+=data[i].username
							html+="</span>";
							html+="<span class='reply-content'>";
								html+= "<span class='font-weight-bold'>A : </span>"+data[i].qnaContent;
								html+="<span class='font-weight-bold float-right'>"
								html+=data[i].qnaDate;
								html+="</span>";
							html+="</span>";
						html+="</span>";
					html+="</div>";
				}
				
				
			}
			html+="</div>";
			$("#sub-"+qnaid).append(html);
			
		}
		
	})
})


$("#questionInsert-btn").on("click",function(){
	
	var formData = $("#questionForm").serialize(); 
	var pid ="${pvo.pid}";
	formData += "&pid="+pid;
	
	
	var userInfo = "${userInfo}";
	if(userInfo == ""){
		
		var con = confirm("로그인 후 이용 가능합니다. 로그인 하시겠습니까?");
		
		if(con == true){
			
			location.href="/view/login?go="+pid;		
		}
		
	}else{
		$.ajax({
		
			url : "/QnA/QuestionInsert",
			data : formData,
			success:function(data){
			
			
				if(data>=1){
				
					alert("문의가 작성 되었습니다.");
					location.href="/product/"+pid;
				}else{
				
					alert("질문 작성에 실패하였습니다. ");
					
				}
			
			}
		
		})
	
	}
})


function productCnt(sign){
	
	var cnt=$("#ps-cnt").val();
	
	if(sign == "-"){
		if(cnt >1){
		cnt--;
		$("#ps-cnt").val(cnt);
		$("#cstock").val(cnt);
		}
		
	}
	
	if(sign=="+"){
		
		cnt++;
		
		$("#ps-cnt").val(cnt);
		$("#cstock").val(cnt);
	}
	
	var pprice = $("#result-price").val();
	var sumPrice = pprice * cnt;
	var sumPrice_str = String(sumPrice);
	sumPrice_str = sumPrice_str.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$(".sum-price").text(sumPrice_str);
	$("#amount").val(sumPrice);
}

function cart(){
	
	
	if( ${pvo.pcnt} ==0){
		
		alert("선택하신 제품의 재고가 없습니다. ");
		return false;
	}
	
	var userInfo = '${userInfo}';
	
	var cnt=$("#ps-cnt").val();
	
	if(userInfo == ""){
		
		alert("로그인 후 이용 가능 합니다.");
		location.href="/view/login?go=login";
	}else{
		
			
			var con = confirm("장바구니에 담으시겠습니까?");
				if(con == true){
					$.ajax({
			
						url : "/cart/addCart",
						data : {
				
							"pid" :'${pvo.pid }',
							"cstock" : cnt
				
						},success:function(data){
				
						if(data == "cartChkTrue"){
							alert("장바구니에 이미 제품이 있습니다.");
						}
				
						if(data =="cartAddSuccess"){
								
								var con = confirm("장바구니에 담았습니다. 장바구니 목록 페이지로 가시겠습니까?");
								if(con ==true){
									location.href="/view/mypage/myCart";
								}
							}
				
							if(data =="cartAddFail"){
								alert("장바구니에 담기 실패 하였습다.");
							}
				
						}
			
						})
				}
		
		
		
	}
}

$(".card-ul_li_a").on("click",function(e){
	
	e.preventDefault();   
	 
	$(".card-ul_li_a").each(function(){
		
		if($(this).hasClass("active")){
			
			
			$(this).removeClass("active");
			
		}
	})
	$(".tab-content").each(function(){
		
			if($(this).hasClass("show")){
			
			
			$(this).collapse('hide');
			
		}
	})
	
	if(!$(this).hasClass("active")){
		$(this).addClass("active");
	
		
	}
})

$('#now-order-btn').on('click', function (e) {
	if( ${pvo.pcnt} ==0){
		alert("선택하신 제품의 재고가 없습니다. ");
		e.stopPropagation();
	
	}
})

$("#order-btn").on("click",function(){ 

	
var con = confirm("상품을 주문 하시겠습니까?");
	
	if(con ==true){
		 
		var formData = $("#form-order").serialize(); 
		 
		$.ajax({
		 
			url:"/order/orderInsertRight",
			data:formData,
			type :"POST", 
			success:function(data){
			
				if(data == "success"){ 
					alert("주문 완료 되었습니다.");
					location.href="/view/orderOkay";
				} 
			
			}
		}) 
	}
	 
	
	
})

</script> 
