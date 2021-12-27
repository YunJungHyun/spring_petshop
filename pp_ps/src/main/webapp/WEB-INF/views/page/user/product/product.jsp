<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="page">
	
	<div class="ps-container">
		
		<div class="row m-0">
			<div class="col-lg-6 product-img-box-4 px-0" id="product-img-box">
				<img id="img-${pvo.pid }" src="/resources/icon/no-pictures.png" />
				
				<script>
							
				var pimgStr = JSON.stringify(${pvo.pimg});
				var pimgJSON = JSON.parse(pimgStr);
				var path =pimgJSON.img.path;
				var fileName = pimgJSON.img.fileName;
							
				$("#img-${pvo.pid}").attr("src" ,"/resources"+path+"/"+fileName);
				</script>
			</div>

			<div class="col-lg-6 px-0 p-3">
				<div class="d-flex flex-column product-info">
					<div class="p-2 product-info-title mb-3">
						<span class="badge text-left mb-0 p-0">
							<a href="#" class="brand-badge">${pvo.pbrand }</a>
						</span>
						<h4 class="col-12 p-0">${pvo.pname }</h4>
					</div>
					
					<div class="d-flex justify-content-between p-2 product-info-content">
						<label class="mb-0">가격</label>
						<span class="px-3">
							<fmt:formatNumber value="${pvo.pprice}" pattern="###,###"/>원
						</span>
					</div> 
					
					<div class="d-flex justify-content-between p-2 product-info-content">
						<label class="mb-0">입고 상태</label>
						<span class="px-3">
							<c:if test="${pvo.pcnt >=1 }">
								재고 있음
							</c:if>
							<c:if test="${pvo.pcnt <1 }">
								재고 없음
							</c:if>
						</span>
					</div>
					
					<ul class="product-info-ul mt-3">
						<li>오늘 출발 마감까지 -12분남음</li>
						<li>저녁 6시 이전 주문하면 오늘 출발! / 영업일 기준</li>
						<li>30,000원 이상 구매 시, 무료배송</li>
					</ul>
					
					<div class="user-input-content d-flex flex-column">
						<div class="d-flex justify-content-between  mt-3 mb-1" >
							<span class="badge text-left mb-0 p-0">
								수량
							</span>
							<span class="badge text-left mb-0 p-0">
								총 상품 금액
							</span>
						</div>
						
						<div class="d-flex justify-content-between my-2">
							<div class="btn-group ps-cnt-group">
								<button type="button" class="ps-cnt-btn d-flex" onclick="productCnt('-')">
									<i class="fas fa-minus"></i>
								</button>
								<input type="text" class="ps-cnt" id="ps-cnt" value="1"/>
								<button type="button" class="ps-cnt-btn d-flex" onclick="productCnt('+')">
									<i class="fas fa-plus"></i>
								</button>
							</div>
							<div class="ps-price-group">
								<span class="sum-price"><fmt:formatNumber value="${pvo.pprice}" pattern="###,###"/></span>원
							</div>
						</div>
						
					</div>
					<div class="d-flex p-3 justify-content-around">
						<button type="button" class="ps-btn-2 col-5" onclick="bring('addCart')">장바구니 담기</button>
						<button type="button" class="ps-btn-1 col-5" onclick="bring('addBuy')">바로 구매</button>
					</div> 
				</div>
			</div>
		</div>  
	</div>
	
	<div class="ps-container my-2">
		<div class="card text-center">
			<div class="card-header pt-0 px-0">
				<ul class="nav nav-tabs card-header-tabs">
					<li class="nav-item col-3">
						<a class="ps-tab ps-tab-1 active" href="#pexplicate" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="pexplicate" > 제품 정보</a>
					</li> 
					<li class="nav-item col-3">
						<a class="ps-tab ps-tab-2" href="#QnA" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="QnA">질문/답변</a>
					</li>
					<li class="nav-item col-3">
						<a class="ps-tab ps-tab-3" href="#review" data-toggle="collapse"  role="button" aria-expanded="true" aria-controls="#review">구매후기</a>
					</li>
					<li class="nav-item col-3">
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
						구매후기
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
<script>
function productCnt(sign){
	
	var cnt=$("#ps-cnt").val();
	
	if(sign == "-"){
		if(cnt >1){
		cnt--;
		$("#ps-cnt").val(cnt);
		}
		
	}
	
	if(sign=="+"){
		
		cnt++;
		
		$("#ps-cnt").val(cnt);
	}
	
	var pprice = ${pvo.pprice};
	var sumPrice = pprice * cnt;
	var sumPrice_str = String(sumPrice);
	sumPrice_str = sumPrice_str.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$(".sum-price").text(sumPrice_str);
}

function bring(sort){
	
	
	
	var userInfo = '${userInfo}';
	
	var cnt=$("#ps-cnt").val();
	
	if(userInfo == ""){
		
		alert("로그인 후 이용 가능 합니다.");
		location.href="/view/login?go=login";
	}else{
		
		
		$.ajax({
			
			url : "/cart/"+sort,
			data : {
				
				"pid" :'${pvo.pid }',
				"cstock" : cnt,
				"pprice" : '${pvo.pprice}'
				
			},success:function(data){
				
				if(data >=1){
					
					alert("장바구니에 담았습니다.");
					
				}else{
					
					
					alert("장바구니에 담기 실패하였습니다.");
				}
			}
			
		})
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

</script> 
