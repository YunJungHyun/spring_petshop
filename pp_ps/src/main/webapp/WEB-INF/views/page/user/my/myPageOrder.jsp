<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.myPageBody{
	
}
.order-content-ul{
	
	border : 1px solid #cccccc7d;
	padding : 1rem 3rem;
	list-style: none;
}
</style>    
<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10 p-3">
		<c:forEach var="olist" items="${oList }" varStatus="status">
			<div class="col-12 px-0">
				<a data-toggle="collapse" href="#orderCollapse-${status.count }" role="button" aria-expanded="false" aria-controls="collapseExample">
					<ul class="order-content-ul">
						<li>
							주문 날짜 : ${olist.orderDate }
						</li> 
						<li>
							주문 번호 : ${olist.orderid }
						</li>
						<li>
							수령인 : ${olist.orderRec }
						</li>
						<li>
							주소 : ${olist.userAddr1 } ${olist.userAddr2 } ${olist.userAddr3 }
						</li>
						<li>
							가격 : ${olist.amount }
						</li>
				
				
				
					</ul>
				</a>
				
				<div id="orderCollapse-${status.count}" class="collapse orderCollapse">
					<span class="orderid" id="${olist.orderid}"></span>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
$('.orderCollapse').on('show.bs.collapse', function () {
	 
	 var orderid= $(this).children(".orderid").attr("id");
	 
	})
</script>
     