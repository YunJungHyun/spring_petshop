<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.ps-container >table{
	font-size: 12px;
}
.order-img-box > img{
	width: 7rem;
}
.order-detail-content-ul{
	padding: unset;
    list-style: none;
    margin: unset;
    text-align: left;
}
.order-detail-content-ul >li {
    line-height: 2;
}
.order-detail-content{
	background-color: #e9ecef8f;
    padding: 0.5rem;
    font-weight: bold;
}
.orderListCollapse:hover {
    background-color: unset!important;
}
.orderStateSelect{
	font-size: 12px;
}
</style>

<div class="page">
	<div class="ps-container">
		<table class="table text-center table-hover">
			<thead>
				<tr>
					<th>
						#
					</th>
					<th>
						주문 번호
					</th>
					<th>
						구매 ID
					</th>
					<th>
						수령인
					</th>
					<th>
						결제 금액
					</th>
					<th>
						연락처
					</th>
					<th>
						도착 주소
					</th>
					<th>
						주문 날짜
					</th>
					<th>
						배송 상태						
					</th>
				</tr>
			</thead>
			<tbody class="orderList-body">
				<c:forEach items="${oList}" var="olist" varStatus="status">
					<tr class="order-list-tr" data-toggle="collapse" data-target="#collapse-${status.count }" aria-expanded="false" aria-controls="collapse-${olist.orderid }">
						<td>${status.count }</td>
						<td >${olist.orderid }</td>
						<td >${olist.userid }</td>
						
						<td>${olist.orderRec }</td>
						<td>${olist.amount }</td>
						<td>${olist.orderPhon }</td>
						<td>(${olist.userAddr1 })${olist.userAddr2 }${olist.userAddr3 }</td> 
						<td>${olist.orderDate }</td>
						<td>
							<select class="custom-select orderStateSelect" id="${olist.orderid}-orderState">
								
								<option value="deliveryReady" <c:if test="${olist.delivery == 'deliveryReady'  }">selected</c:if>>배송준비</option>
								<option value="deliveryIn" <c:if test="${olist.delivery == 'deliveryIn'  }">selected</c:if>>배송중</option>
								<option value="deliveryComplete" <c:if test="${olist.delivery == 'deliveryComplete'  }">selected</c:if>>배송완료</option>
								<option value="orderCancle" <c:if test="${olist.delivery == 'orderCancle'  }">selected</c:if>>주문취소</option>
					 		</select>
						</td>
					</tr>
					<tr class="collapse orderListCollapse" id="collapse-${status.count }">
					</tr>
					
						
					
					
					<input type="hidden" class="hiddenInfo" value="${olist.orderid }-${olist.userid}-${olist.amount}"/>
				</c:forEach>
			</tbody>
		</table>
	
	</div>
</div>

<script>
$(".order-list-tr").on("click",function(e){
	
	if(e.target.nodeName == "SELECT"){
		e.stopPropagation();
		
	}
	
	
})
$('.orderListCollapse').on('show.bs.collapse', function (e) {

	var hiddenInfo = $(this).next(".hiddenInfo").val();
	var hiddenInfo_arr = hiddenInfo.split("-");
	var orderid = hiddenInfo_arr[0];
	var userid= hiddenInfo_arr[1];
	var amount= hiddenInfo_arr[2];
	var status_arr =$(this).attr("id").split("-");
	var status = status_arr[1];

	
 $.ajax({
		 
		 url:"/order/orderDetailList",
		 data :{ 
			 "userid" :userid,
			 "orderid" : orderid
		 },success: function(data){
		
			 var html ="<td colspan='9' class='px-0'>"
				 html +="<div class='row m-0'>";
			for(var i = 0 ; i <data.length ;i++){

				var pimg = data[i].pimg; 
				
				var pimgJSON = JSON.parse(pimg);
				var path =pimgJSON.img.path; 
				var fileName = pimgJSON.img.fileName;
				var rowspan = i+1;
				
						html+="<div class='col-6 px-2'>";
						html+="<div class='order-detail-content  d-flex '>"
							html+="<div class='col-3 px-0'>";
								html+="<div class='order-img-box m-auto w-auto border-right'>";
									html+="<img src='/resources"+path+"/s/s_"+fileName+"'>";
								html+="</div>";
							html+="</div>";
							html+="<div class='col-9 p-2'>";
								html+="<ul class='order-detail-content-ul'>";
									html+="<li class='font-weight-bold'>";
										html+="<span class='od-data-text-pname'>";
										html +=data[i].pname;
										html+="</span>";
									html+="</li>";
									html+="<li>";
										html+="<span class='od-title-span-2'>";
											html+="제품 가격 : "
										html+="</span>";
										html+="<span class='od-data-text-2'>";
										html+= data[i].pprice ;
										html+="</span>";
										html +="<span class='od-unit-span-2'>";
											html+=" (원)";
										html +="</span>";
									html+="</li>";
									html+="<li>";
										html+="<span class='od-title-span-2'>";
											html+="주문 갯수 : "
										html+="</span>";
										html+="<span class='od-data-text-2'>";
										html +=data[i].cstock;
										html+="</span>";
										html +="<span class='od-unit-span-2'>";
											html+=" (개)";
									html +="</span>";
									html+="</li>";
									html+="<li class='border-top text-right'>";
										html+="<span class='od-title-span'>";
											html+="합계 : "
										html+="</span>";
										html+="<span class='od-data-text-2'>";
										html +=data[i].cstock*data[i].pprice;
											html +="</span>";
										html +="<span class='od-unit-span'>";
										html+=" (원)";
										html +="</span>";
									html+="</li>";
								html+="</ul>";
							html+="</div>";
						html+="</div>";
					html+="</div>";
					
				
				
				
			}
			html+="</div>";
			html+="<div class='border-top mt-2 text-right px-3 pt-3 pb-2'>";
					
				html+="총 결제 금액 : " +amount +" (원)";
			html+="</div>";
			html+="</td>";
			 $("#collapse-"+status).append(html); 	
		 }
	 })
}) 


$('.orderListCollapse').on('hide.bs.collapse', function () {
	
 	$(this).children().remove();
	
})

$(".orderStateSelect").on("change",function(){
	
	console.log($(this).attr("id"));
	console.log($(this).val());
})


</script>