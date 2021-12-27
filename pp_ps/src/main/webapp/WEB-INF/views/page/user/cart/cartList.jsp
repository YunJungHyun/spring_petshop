<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.product-one:hover{
	
	cursor:pointer;

}
</style>
<div class="page px-0 py-3">
	<div class="row cart-list col-12 m-auto px-0">
		<c:set var="sum" value="0"/>
		<c:forEach var="cart" items="${cartList }"  varStatus="status">
			<div class="col-3 product-one">
				
				<div class="product-img-box-1 " >
						<img id="img-${status.count}"/>
						<script>
							
							var pimgStr = JSON.stringify(${cart.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/"+fileName);
						</script>
				</div>
				<div class="product-content-box">
						<p>${cart.pname }</p>	
						<p>
							<span>
								<fmt:formatNumber value="${cart.pprice}" pattern="###,###"/>
								
							</span >
							<span class="product-content-unit">
								원
							</span>
							</p>  
						<p class="stock">
							<span class="stock">${cart.cstock}</span>
							
							<span class="product-content-unit">
								개
							</span>
						</p>
				</div>
			</div>
			
			<c:set var="sum" value="${sum+(cart.pprice * cart.cstock)}"/>
		</c:forEach>
	</div> 
	<div class="buy-content d-flex flex-column">
		<div class="text-right">
			총 합계 : <span class="sum-price">
				<fmt:formatNumber value="${sum}" pattern="###,###,###"/>
			</span>
		</div>
		<div class="text-right">
			<button type="button">구매하기 </button>
			<button type="button">취소 </button>
		</div>
	</div> 
</div>

<script>
$(document).ready(function(){
	

	

	
})
</script>