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
</style>
<div class="page">
	<span class="ps-title-005">장바구니</span>
	
		<table class="table">
			<thead>
				<tr>
					<th colspan="5">주문 상품</th>
				</tr>
			</thead>
			<tbody class="ps-product-list-002">
			<c:set var="allPriceSum" value="0"/>
			<c:forEach items="${cartList }" var="cart">
			<tr id="${cart.pid }">
				<td class="ps-img-box-002 col-2 go-product" >
					<img id="img-${cart.pid }">
					<script>
							
							var pimgStr = JSON.stringify(${cart.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${cart.pid}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
					</script>
					
				</td>
				<td style="vertical-align:top" class="border-right col-4 go-product">
					<span class="ps-title-006">
						${cart.pname }
					</span>
				</td>
				<td class="col-2 border-right text-center" >
					<div class="btn-group ps-cnt-group">
						
								
							
							<div class="btn-group ps-btn-group-001">
								<button type="button" class="ps-btn-003" onclick="cartProductCnt('-','${cart.pid}')">
									<i class="fas fa-minus"></i>
								</button>
								<input type="text" class="ps-input-002" id="${cart.pid}-cnt" value="${cart.cstock }" readonly="readonly" />
								<button type="button" class="ps-btn-003" onclick="cartProductCnt('+','${cart.pid}')">
									<i class="fas fa-plus"></i>
								</button>
							</div>
					</div>
				</td> 
				<td class="col-2 border-right text-center"  > 
					정가 : <fmt:formatNumber value="${cart.pprice}" pattern="###,###,###"/>
					<br>
					<c:set var="priceSum" value="${cart.pprice * cart.cstock}"/>
					합계 : <fmt:formatNumber value="${priceSum }" pattern="###,###,###"/>
				</td>
				<td class="col-2 text-center"> 
					<button type="button" class="btn btn-dark w-100" onclick="cartDeleteBtn('${cart.pid }')">
							삭제
					</button>
				</td>
			</tr>
			<c:set var="allPriceSum" value="${allPriceSum+(cart.pprice * cart.cstock)}"/>
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
								<input type="hidden" class="form-control " id="amount" name="amount" value="${allPriceSum }">
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