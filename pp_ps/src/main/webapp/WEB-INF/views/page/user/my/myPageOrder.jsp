<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.myPageBody *{
	
	font-weight: bold;
}

.order-img-box{
	width :12rem;
}
.order-img-box >img {
    width: -webkit-fill-available;
}
.order-content-ul{
	
	border : 1px solid #cccccc7d;
	padding : 1rem 3rem;
	list-style: none;
}

.order-content-ul:hover {
    background-color: #cccccc9c;
}
.od-data-text-orderid{
	color: #0b8dff;
}
.od-data-text-pname{

    font-size: 20px;
}
.od-data-text-delivery{

	color : blue;
}
.od-data-text-1 {
    font-style: italic;
}
ul.order-content-ul >li {
    line-height: 1.7;
}

.order-detail-content-ul{
	list-style: none;
    padding: 0px;
    margin: 0px;
} 

.order-detail-content-ul li{
	line-height: 2;
}
.od-title-span-1 {
    color: #60676d;
    
    font-size: 18px;
}

.od-title-span-2 {
   
    color: #60676d;
}

.orderDetailList-table tr {
 background-color: #e9ecef9e;
	 
}
.orderDetailList-table tr:hover{

	cursor : pointer;
	filter: drop-shadow(0px 0px 0px #ccc);
}
.sum-price{
	background-color: #e9ecef9e;
	font-size: 1.5rem;
    font-weight: bold;
}
.orderCancle-btn-group>button{
	font-size: 12px;
}

.orderCancleForm_input-radio{

	    width: 20px;
    height: 20px;
}
.orderCancleForm_li{

	padding : .5rem 1rem;
}

.orderCancleForm_span{
	font-size: 1.25rem;
	font-weight: bold;
	    display: inline;
    vertical-align: text-bottom;
        padding: 0rem 0.5rem;
}
</style>    
<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10">
		<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">나의 쇼핑 - 주문 내역</span>
		</div>
		<c:forEach var="olist" items="${oList }" varStatus="status">
			<div class="col-12 px-0">
				<a data-toggle="collapse" href="#orderCollapse-${status.count }" role="button" aria-expanded="false" aria-controls="collapseExample">
					<ul class="order-content-ul">
						<li>
							<span class="od-data-text-orderid">${olist.orderid }</span>
						</li>
						<li>
							<span class="od-title-span-1">
							주문 날짜 :
							</span> 
							<span class="od-data-text-1">
								${olist.orderDate }
							</span>
						</li> 
						<li>
							<span class="od-title-span-1">
							수령인 :
							</span>
							<span class="od-data-text-1">
							 ${olist.orderRec }
							 </span>
							 
							<span class="od-unit-span">
								님
							</span>
						</li>
						<li>
							<span class="od-title-span-1">
							주소 : 
							</span>
							<span class="od-data-text-1">
							( ${olist.userAddr1 } ) ${olist.userAddr2 } ${olist.userAddr3 }
							</span>
						</li>
						<li>
							<span class="od-title-span-1">
							주문 가격 : 
							</span>
							<span class="od-data-text-1">
							<fmt:formatNumber value="${olist.amount }" pattern="###,###,###"/>
							</span>
							
							<span class="od-unit-span">
								(원)
							</span>
						</li>				
						<li>
							<span class="od-title-span-1">
							배송 상태 : 
							</span>
							<span class="od-data-text-delivery">
							  
								<c:if test="${olist.delivery eq 'deliveryReady'}"><span style="color:gray">배송준비</span></c:if>
								<c:if test="${olist.delivery eq 'deliveryIn'}"><span style="color:blue">배송중</span></c:if>
								<c:if test="${olist.delivery eq 'deliveryComplete'}"><span style="color:green">배송완료</span></c:if>
								<c:if test="${olist.delivery eq 'orderCancle'}"><span style="color:red">주문취소</span></c:if>
							</span>
							
							
						</li>				
					</ul> 
				</a>
				
				<div id="orderCollapse-${status.count}" class="collapse orderCollapse">
					<span class="orderid" id="${olist.orderid}"></span>
					
					<table class="table border-bottom mb-1 orderDetailList-table" id="orderDetailList-${status.count}">
					
					</table>
					<div class="border-top border-bottom text-right py-3 px-2 sum-price mb-3">
						<span class="od-title-span-1">총 주문 가격 :</span>
						<span class="od-data-text-3">
							<fmt:formatNumber value="${olist.amount }" pattern="###,###,###"/>
						</span>
						<span class="od-unit-span">(원)</span>
					</div>
				</div>
			</div> 
		</c:forEach>
	</div>
</div>



<script>


$('.orderCollapse').on('show.bs.collapse', function () {
	 
		
	 var orderid= $(this).children(".orderid").attr("id");
	 var thisId = $(this).attr("id");
	 
	 var thisId_arr = thisId.split("-");
	 var status =thisId_arr[1];
	 
	 $.ajax({
		 
		 url:"/order/orderDetailList",
		 data :{ 
			 
			 "orderid" : orderid
		 },success: function(data){
		
			 
			for(var i = 0 ; i <data.length ;i++){

				var pimg = data[i].pimg; 
				
				var pimgJSON = JSON.parse(pimg);
				var path =pimgJSON.img.path;
				var fileName = pimgJSON.img.fileName;
				var delivery = data[i].eachDelivery;
				
				
				switch(delivery){
				case "deliveryReady":
					delivery = "<span style='color:gray'>배송준비</span>";
					break;
				case "deliveryIn":
					delivery = "<span style='color:blue'>배송중</span>";
					break;
				case "deliveryComplete":
					delivery = "<span style='color:green'>배송완료</span>";
					break;
				case "orderCancleReg":
					delivery = "<span style='color:red'>주문취소 신청 중</span>";
					break;
				case "orderCancle":
					delivery = "<span style='color:red'>주문취소</span>";
					break;
			 
				}

				var html = "<tr id='od-"+data[i].pid+"'>";
						html +="<td class='col-3 px-0 py-3'>";
							html+="<div class='order-img-box m-auto'>";
							html+="<img src='/resources"+path+"/s/s_"+fileName+"'>";
							html+="</div>";
						html +="</td>";
						html +="<td class='col-9'>";			
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
									html+= addComma(data[i].pprice) ;
									html+="</span>";
									html +="<span class='od-unit-span-2'>";
										html+=" (원)";
									html +="</span>";
								html+="</li>";
								var salePrice = data[i].pprice -(data[i].psale * data[i].pprice);
								if(data[i].psale > 0){
									
									html+="<li>";
									html+= " <span class='od-title-span-2'>";
										html+="할인 :";
									html+="</span>";
									html+= " <span class='od-title-text-2'>";
										html+=data[i].psale*100+"%";
									html+="</span>";
									html+="</li>";
									html+="<li>";
									html+= " <span class='od-title-span-2'>";
										html+="할인가:";
									html+="</span>"; 
									html+= " <span class='od-title-text-2'>";
										html+=addComma(Math.ceil(salePrice/10)*10)+"원";
									html+="</span>";
									html+="</li>";
								}
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
								html+="<li>";
									html+="<span class='od-title-span-2'>";
										html+="주문 상태 : "
									html+="</span>";
									html+="<span class='od-data-text-2'>";
										html+="<span>";
										html +=delivery; 
										html+="</span>";
										
									html+="</span>";
									 
								html+="</li>";
								html+="<li class='border-top text-right mt-3'>";
									html+="<span class='od-title-span'>";
										html+="합계 : "
									html+="</span>";
									html+="<span class='od-data-text-2'>";
									if( data[i].eachDelivery =='orderCancle'){
										html+= "0";
									}else{
										html +=addComma(data[i].cstock*salePrice);
									}
									html +="</span>";
									html +="<span class='od-unit-span'>";
									html+=" (원)";
									html +="</span>";
								html+="</li>";
							html+="</ul>";
						html +="</td>";
					html+="</tr>";
				$("#orderDetailList-"+status).append(html); 	
			}
		 }
	 })
	 
})

$("#orderCancleModal").on('show.bs.modal', function (e) {
	
	var orderid= $(e.relatedTarget).data('orderid');
	var pid= $(e.relatedTarget).data('pid');
	
	$("#orderid").val(orderid);
	$("#pid").val(pid);
	
})

$(document).on("click" ,".orderDetailList-table > tr",function(e){
	
	if(e.target.nodeName !="BUTTON"){
		
		var od_pid = $(this).attr("id");
		var od_pid_arr =od_pid.split("-");
	
		location.href="/product/"+od_pid_arr[1];
		
	}
})	

$('.orderCollapse').on('hide.bs.collapse', function () {
	
 	var thisId = $(this).attr("id");
	 
	 var thisId_arr = thisId.split("-");
	 var status =thisId_arr[1];
	 $("#orderDetailList-"+status).children().remove();
	
})


//천단위 콤마 펑션
   function addComma(value){ 
		var valueStr = String(value);
		var addCommaValue = valueStr.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return addCommaValue; 
    }
    
</script>
     