<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.go-product{
	
	cursor:pointer;
}
span.span-cart-allPriceSum {
    font-size: 2rem;
    line-height: 2;
    vertical-align: middle; 
}
.page-content_title_span {
	padding: 1rem 1rem 0.5rem;
	font-size: 1.5rem;
	font-weight: bold;
	display: block;
}
.cart-tbody_td {
	border-right: 1px solid #dee2e6;
}
.cart-tbody_td_img {
	width: 10rem;
}
.cart-tbody_td_span {
	font-size: 1.25rem;
	font-weight: bold;
}

.user-self_btn-group {
	border: 1px solid #ccc;
	border-radius: 5px;
}
.user-self_btn {
	width: 3rem;
}
.user-self_input {
	width: 3rem;
	border-right: 1px solid #ccc;
	border-left: 1px solid #ccc;
	border-top: unset;
	border-bottom: unset;
	border-radius: unset;
	text-align: center;
	font-size: 1.25rem;
	font-weight: bold;
}

.user-self_result-box {
	font-size: 2rem;
	font-weight: bold;
}

p.cart-tbody_td_p {
    margin-bottom: 0.5rem;
    font-weight: bold;
}
</style>
<div class="page">
	<div class="page-container">
		<div class="page-content">
			<div class="page-content_title">
				<span class="page-content_title_span">장바구니</span>
			</div>
			<div class="page-content_group">
				<table class="table page-content_group_table ">
					<thead>
						<tr>
							<th colspan="5">장바구니 상품 <span class="badge">${fn:length(cartList)}개</span></th>
						</tr>
					</thead> 
					<tbody class="page-content_group_table_tbody cart-tbody">
						<c:set var="allPriceSum" value="0"/> 
						<c:forEach items="${cartList }" var="cart" varStatus="status">
							<tr id="${cart.pid }">
								<td class="col-2 go-product cart-tbody_td" >
									<img class="cart-tbody_td_img" id="img-${status.count}">
									<script>
									var pimgStr = JSON.stringify(${cart.pimg}); 
									var pimgJSON = JSON.parse(pimgStr);
									var path =pimgJSON.img.path;
									var fileName = pimgJSON.img.fileName;
									$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
									</script>
								</td>
								<td style="vertical-align:top" class="border-right col-4 go-product cart-tbody_td">
									<span class="cart-tbody_td_span">
										${cart.pname }
									</span>
								</td>
								<td class="col-2 border-right text-center user-self" >
									<div class="btn-group user-self_btn-group">			
										<div class="btn-group ps-btn-group-001">
											<button type="button" class="user-self_btn" onclick="cartProductCnt('-','${cart.pid}')">
												<i class="fas fa-minus"></i>
											</button>
											<input type="text" class="user-self_input" id="${cart.pid}-cnt" value="${cart.cstock }" readonly="readonly" />
											<button type="button" class="user-self_btn" onclick="cartProductCnt('+','${cart.pid}')">
												<i class="fas fa-plus"></i>
											</button>
										</div>
									</div>
								</td> 
								<td class="col-2 border-right text-center cart-tbody_td cart"> 
									<p class="cart-tbody_td_p">
										<span class="cart-tbody_td_p_span td-title">정가 :</span>
										<span class="cart-tbody_td_p_span td-info">
											 <fmt:formatNumber value="${cart.pprice}" pattern="###,###,###"/>원
										</span>
									</p>
									<c:if test="${cart.psale > 0 }">
										<c:set var="sale_price" value="${cart.pprice - (cart.pprice * cart.psale)}"/>
										<c:set var="sale_price_round" value="${sale_price + (10-(sale_price%10))%10}"/>
										<p class="cart-tbody_td_p">
											<span class="cart-tbody_td_p_span td-title">할인가 : </span>
											<span class="cart-tbody_td_p_span td-info">
												<fmt:formatNumber type="number" pattern="###,###,###" value="${sale_price_round}"/>원 
											</span>
										</p>
										<c:set var="priceSum" value="${sale_price_round * cart.cstock}"/>
									</c:if>
									<c:if test="${cart.psale == 0 }">
										<c:set var="priceSum" value="${cart.pprice * cart.cstock}"/>
									</c:if>
									<p class="cart-tbody_td_p">
										<span class="cart-tbody_td_p_span td-title">합계 : </span>
										<span class="cart-tbody_td_p_span td-info">
											<fmt:formatNumber value="${priceSum }" pattern="###,###,###"/>원
										</span>
									</p>
								</td>
								<td class="col-2 text-center"> 
									<button type="button" class="btn btn-dark w-100" onclick="cartDeleteBtn('${cart.pid }')">
											삭제
									</button>
								</td>
							</tr>
							<c:set var="allPriceSum" value="${allPriceSum+priceSum}"/>
							</c:forEach>
							<tr>
								<th colspan="5" class="text-right">
								<span class="span-cart-allPriceSum">
								결제 예상 금액 : <fmt:formatNumber value="${allPriceSum }" pattern="###,###,###"/> 원
								</span>
					
								<button type="button" class="btn btn-primary ps-btn-005" data-toggle="modal" data-target="#orderModal">주문하기 </button>
							</th>
						</tr>
					</tbody>	
				</table> 
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
								결제 금액 : <fmt:formatNumber value="${allPriceSum }" pattern="###,###,###"/>
								<input type="hidden" class="form-control " id="amount" name="amount" value="<fmt:parseNumber value="${allPriceSum }" integerOnly="true"/>">
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
$(document).on("click",".go-product",function(){
	
	location.href="/product/"+$(this).parent().attr("id");
})


$("#order-btn").on("click",function(){
	
	var con = confirm("상품을 주문 하시겠습니까?");
	if(con ==true){
	var formData = $("#form-order").serialize(); 
	console.log(formData);
	$.ajax({
		
		url:"/order/orderInsert",
		data:formData,
		type:"POST", 
		success:function(data){
			
			if(data == "success"){ 
				alert("주문 완료 되었습니다.");
				location.href="/view/orderOkay";
			}
			
		}
	})
	}
	
})
function cartProductCnt(sign,pid){
var cnt=$("#"+pid+"-cnt").val();
	

	if(sign == "-"){
		if(cnt >1){
		cnt--;
		$("#"+pid+"-cnt").val(cnt);
		}
		
	}
	
	if(sign=="+"){
		
		cnt++;
		
		$("#"+pid+"-cnt").val(cnt);
	}
	
	
	$.ajax({
		
		url : "/cart/cntUpdate",
		data : {
			
			"cstock" :$("#"+pid+"-cnt").val(),
			"pid" : pid
			
		},success:function(data){
			
			if(data >= 1){
				
				location.reload();
			}else{
				
				alert("수량 변경에 실패하였습니다.");
			}
		}
	})
	
}

function cartDeleteBtn(pid){
	
	var con = confirm("선택하신 제품을 장바구니에서 삭제하시겠습니까?");
	if(con == true){
	$.ajax({
		 
		url : "/cart/delete",
		data : {
			
			"pid" : pid
		},success:function(data){
			
			
			if(data >=1){
				
				alert("장바구니에 담긴 제품이 삭제되었습니다.");
				location.reload();
			}else{
				
				alert("장바구니에 담긴 제품을 삭제는데 실패 하였습니다.");
			}
		}
	
	})
	}
	//삭제
	
}
</script>