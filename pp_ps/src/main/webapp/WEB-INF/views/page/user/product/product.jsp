<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
span.span-cart-allPriceSum {
    font-size: 2rem;
    line-height: 2;
    vertical-align: middle;
}
</style>
<div class="pt-2"></div> 
<div class="page">		
		<div class="row">
			<div class="col-6 ps-img-box-001">
				<img id="this-img" src="/resources/icon/no-pictures.png" />
				<script>
							
				var pimgStr = JSON.stringify(${pvo.pimg});
				var pimgJSON = JSON.parse(pimgStr);
				var path =pimgJSON.img.path;
				var fileName = pimgJSON.img.fileName;
							
				$("#this-img").attr("src" ,"/resources"+path+"/"+fileName);
				</script>
			</div>

			<div class="col-lg-6">
				<div class="ps-info-box-002">
					<div class="ps-group-004">
						<span class="badge">
							<a href="#" class="ps-a-003">${pvo.pbrand }</a>
						</span>
						<span class="ps-title-004">${pvo.pname }</span>
					</div>
					
					<div class="ps-group-005">
						<span class="ps-span-008">가격</span>
						<span class="ps-span-008">
							<fmt:formatNumber value="${pvo.pprice}" pattern="###,###"/>원
						</span>
					</div> 
					
					<div class="ps-group-005">
						<span class="ps-span-008">입고 상태</span>
						<span class="ps-span-008">
							<c:if test="${pvo.pcnt >=1 }">
								<span style="color:green;">재고 있음</span>
							</c:if>
							<c:if test="${pvo.pcnt <1 }">
								<span style="color:red;">재고 없음</span>
							</c:if>
						</span>
					</div>
					
					<ul class="ps-ul-006">
						<li>오늘 출발 마감까지 -12분남음</li>
						<li>저녁 6시 이전 주문하면 오늘 출발! / 영업일 기준</li>
						<li>30,000원 이상 구매 시, 무료배송</li>
					</ul>
					
					<div class="ps-input-group-001">
						<div class="ps-group-006">
							<span class="badge ps-span-009">
								수량
							</span>
							<span class="badge ps-span-009">
								총 상품 금액
							</span>
						</div>
						
						<div class="ps-group-007">
							<div class="btn-group ps-btn-group-001">
								<button type="button" class="ps-btn-003" onclick="productCnt('-')">
									<i class="fas fa-minus"></i>
								</button>
								<input type="text" class="ps-input-002" id="ps-cnt" value="1" readonly="readonly"/>
								<button type="button" class="ps-btn-003" onclick="productCnt('+')">
									<i class="fas fa-plus"></i>
								</button>
							</div>
							<div class="ps-group-008">
								<span class="sum-price">
									<fmt:formatNumber value="${pvo.pprice}" pattern="###,###"/>
								</span>원
							</div>
						</div>
						
					</div>
					<div class="ps-btn-group-002">
						<button type="button" class="btn btn-outline-primary ps-btn-004" onclick="cart()">장바구니 담기</button>
						<button type="button" class="btn btn-primary ps-btn-004" id="now-order-btn"  data-toggle="modal" data-target="#orderModal">바로 주문</button>
					</div> 
				</div>
			</div>
		</div>  
	</div>
	
	<div class="ps-division-002"></div>
	<div class="card ps-card-001">
		<div class="card-header ps-cardheader-001">
			<ul class="nav nav-tabs card-header-tabs ps-ul-007">
				<li class="nav-item ps-li-005 col-3">
					<a class="ps-tab ps-tab-1 active" href="#pexplicate" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="pexplicate" > 제품 정보</a>
				</li> 
				<li class="nav-item ps-li-005 col-3">
					<a class="ps-tab ps-tab-2" href="#QnA" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="QnA">질문/답변</a>
				</li>
				<li class="nav-item ps-li-005 col-3">
					<a class="ps-tab ps-tab-3" href="#review" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="#review">구매후기</a>
				</li>
				<li class="nav-item ps-li-005 col-3">
					<a class="ps-tab ps-tab-4" href="#notice" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="#notice">취소/교환/반품 안내</a>
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
					질문
				</div>
			</div>
			<div class=" tab-content collapse" id="review">
				<div class="card-body ps-card-body">
					<c:forEach items="${rList }" var="list">
							
							${list.rating }
							
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
									<fmt:formatNumber value="${pvo.pprice}" pattern="###,###"/> 원
								</span>
								<input type="hidden" class="form-control " id="amount" name="amount" value="${pvo.pprice}">
							</span>
					
						<div class="invalid-feedback">
							
						</div>
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
	
	var pprice = ${pvo.pprice};
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
							"cstock" : cnt,
							"pprice" : '${pvo.pprice}'
				
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

$(".ps-tab").on("click",function(e){
	
	e.preventDefault();   
	 
	$(".ps-tab").each(function(){
		
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
		console.log(formData);
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
