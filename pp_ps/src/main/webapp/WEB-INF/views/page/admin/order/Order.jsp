<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.ps-container >table{
	font-size: 12px;
}
.delivery-select{
	font-size : 12px;
}

.orderListCollapse >td {
	
	padding-left : 0px;
	padding-right : 0px;
}
.orderListCollapse >td >div{
	
	margin: 0px;
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
    padding-left: 0.5rem
}
.order-detail-content{
	background-color: #e9ecef8f;
    font-weight: bold;
}
.orderListCollapse:hover {
    background-color: unset!important;
}
.btn-group.delivery-btn-group >.btn {
    font-size: 12px;
    padding: 0.25rem;
}

.order-img-box{
    height: 100%;
  
    align-items: center;
}
.order-img-box > img {
    width: -webkit-fill-available;
    padding-right: 0.25rem;
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
							
							<select class="custom-select delivery-select" id="delivery-${olist.orderid}">
								<option value="deliveryReady" style="color:gray;" <c:if test="${olist.delivery == 'deliveryReady'}">selected</c:if>>배송준비</option>
								<option value="deliveryIn" style="color:blue;" <c:if test="${olist.delivery == 'deliveryIn' }">selected</c:if>>배송중</option>
								<option value="deliveryComplete" style="color:green;" <c:if test="${olist.delivery == 'deliveryComplete' }">selected</c:if>>배송완료</option>
								<option value="orderCancle" style="color:red;" <c:if test="${olist.delivery== 'orderCancle' }">selected</c:if>>주문취소</option>
							</select>
							
						</td>
					</tr>
					<tr class="collapse orderListCollapse" id="collapse-${status.count }">
						
					</tr>
					<input type="hidden" class="hiddenInfo" value="${olist.orderid }-${olist.userid}"/>
				</c:forEach>
			</tbody>
		</table>
	
	</div>
</div>

<script>
$(document).ready(function(){
	
	selectColor();
	
})

function selectColor(){
	
	 $(".delivery-select").each(function(){
		var delivery = $(this).val();
		 
		 switch(delivery){
			
			case "deliveryReady" :
					$(this).css("color" ,"gray");
				break;
			case "deliveryIn":
					$(this).css("color" ,"blue");
				break;
			case "deliveryComplete":
					$(this).css("color" ,"green");
				break;
			case "orderCancle":
					$(this).css("color" ,"red");
				break;
		}
		 
	 })
	
}


$(".order-list-tr").on("click",function(e){
	
	if(e.target.nodeName =="SELECT"){
		
		e.stopPropagation();
	}
})
var prevSelectVal = "";

$(".delivery-select").on("focus",function(){
	
	prevSelectVal = $(this).val();
	
	
})

$(".delivery-select").on("change",function(){
	
	var orderid = $(this).attr("id").split("-")[1];
	var delivery = $(this).val();
	
	if(delivery =="deliveryReady" && (prevSelectVal =="deliveryComplete" || prevSelectVal =="deliveryIn") ){
		alert("이미 배송중 이거나 배송완료 된 제품 입니다.");
		$(this).val(prevSelectVal);
		return false;
	}
	if(delivery =="deliveryIn" && prevSelectVal =="deliveryComplete" ){
		alert("배송 완료 된 제품 입니다.");
		$(this).val(prevSelectVal);
		return false;
	}
	
	
	
	if(prevSelectVal =="orderCancle"){
		alert("이미 주문취소 된 제품입니다.");
		$(this).val(prevSelectVal);
		return false;
	}else if(delivery == "orderCancle"){
		
		alert("임의로 주문취소 상태로 변경 할 수 없습니다.");
		$(this).val(prevSelectVal);
		return false;
	}else{
		
		
		 $.ajax({
			
			url : "/order/orderStateChange",
			data :{
				
				"orderid" :orderid,
				"delivery" : delivery
			},success:function(data){
				
				if(data>=1){
					
					location.reload();
				}else{
					
					alert("배송 상태 변경에 실패하였습니다.");
					location.reload();
				}
				
			}
			
		})
		
	}
	
	
	
})

$('.orderListCollapse').on('show.bs.collapse', function (){

	var orderid = $(this).next(".hiddenInfo").val().split("-")[0];
	var userid = $(this).next(".hiddenInfo").val().split("-")[1];
	var status =$(this).attr("id").split("-")[1];


	
	$.ajax({
		
		url : "/order/orderDetailList",
		data :{
			
			"orderid" :orderid,
			"userid":userid
		},success:function(data){
			
			
			var td = $("<td>",{"colspan":"9"})
			var div_1 = $("<div>",{"class":"row"})
			
			for(var i = 0 ; i <data.length ;i++){
				
				var pimg = data[i].pimg; 
				var pimgJSON = JSON.parse(pimg);
				var path =pimgJSON.img.path; 
				var fileName = pimgJSON.img.fileName;
				var rowspan = i+1;
				var delivery = data[i].eachDelivery;
				var deAmount =data[i].pprice * data[i].cstock;
				
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
				case "orderCancle":
					delivery = "<span style='color:red'>주문취소</span>";
					break;
			
				}
				
				var div_2 = $("<div>",{"class":"col-6 px-2"})
				var div_3 =$("<div>",{"class":"order-detail-content d-flex"})
				
					var html_1 ="<div class='col-3 px-0 border-right'>";
							html_1+="<div class='order-img-box m-auto w-auto  d-flex'>";
								html_1+="<img src='/resources"+path+"/s/s_"+fileName+"'>";
							html_1+="</div>";
						html_1+="</div>";
					div_3.append(html_1);
				var div_4 =	$("<div>",{"class":"col-9 p-0"});
				var ul =$("<ul>",{"class":"order-detail-content-ul"})
					var html_2 = "<li class='font-weight-bold'>";
							html_2+="<span class='od-data-text-pname'>";
								html_2 +=data[i].pname;
							html_2+="</span>";
							html_2+="</li>";
						html_2+="<li>";
							html_2+="<span class='od-title-span-2'>";
								html_2+="제품 가격 : "
							html_2+="</span>";
							html_2+="<span class='od-data-text-2'>";
								html_2+= data[i].pprice ;
							html_2+="</span>";
							html_2 +="<span class='od-unit-span-2'>";
								html_2+=" (원)";
							html_2 +="</span>";
						html_2+="</li>";
						html_2+="<li>";
							html_2+="<span class='od-title-span-2'>";
								html_2+="주문 갯수 : "
							html_2+="</span>";
							html_2+="<span class='od-data-text-2'>";
								html_2 +=data[i].cstock;
							html_2+="</span>";
							html_2 +="<span class='od-unit-span-2'>";
								html_2+=" (개)";
							html_2 +="</span>";
						html_2+="</li>";
						
						ul.append(html_2);
					var li =$("<li>");		
					var div_5=$("<div>",{"class":"d-flex justify-content-between"});
								
					var html_3 ="<div>"
							html_3+="<span class='od-title-span-2'>";
								html_3+="배송 상태: "
							html_3+="</span>";
							html_3+="<span class='od-data-text-2' id='state-"+data[i].pid+"-"+data[i].orderid+"'>";
								html_3 +=delivery;
							html_3+="</span>";
						html_3+="</div>";
						div_5.append(html_3);
					
					var	div_6 =$("<div>",{"class" :"btn-group delivery-btn-group mx-2"});
					var button =$("<button>",{"class":"btn btn-outline-danger orderCancle","text":"주문 취소" ,"onclick":"orderCancle('"+data[i].orderid+"','"+data[i].pid+"','"+data[i].eachDelivery+"','"+deAmount+"')"});
					
						div_6.append(button);
						div_5.append(div_6);
						li.append(div_5);
						ul.append(li);
					var html_4 ="<li class='border-top text-right mt-2 pr-2'>";
							html_4+="<span class='od-title-span'>";
								html_4+="합계 : "
							html_4+="</span>";
							html_4+="<span class='od-data-text-2'>";
								html_4 +=data[i].cstock*data[i].pprice;
							html_4 +="</span>";
							html_4 +="<span class='od-unit-span'>";
								html_4+=" (원)";
							html_4 +="</span>";
						html_4+="</li>";
						
						ul.append(html_4);
						div_4.append(ul);
						div_3.append(div_4);
						div_2.append(div_3);
				div_1.append(div_2);
			}
			
			td.append(div_1);
			$("#collapse-"+status).append(td); 
		}
		
	})
	
}) 

function orderCancle(orderid ,pid,delivery,deAmount){
	
	console.log(orderid+","+pid+","+delivery);
	
	switch(delivery){
	
		case "deliveryIn" :
				alert("이미 배송중인 제품입니다.");
			break;
		case "deliveryComplete" :
				alert("이미 배송완료된 제품입니다.");
			break;
		case "orderCancle" :
				alert("이미 주문 취소된 제품입니다.");
			break;
		case "deliveryReady" :
				var con = confirm("해당 제품을 주문취소 하시겠습니까?");
				if(con == true){
					$.ajax({
					
						url :"/order/orderDetailStateChange",
						data :{
						
							"orderid" : orderid,
							"pid" :pid,
							"deAmount" :deAmount
						},success :function(data){
							
							if(data >= 1){
								
								alert("주문 취소 되었습니다.");
								location.reload();
							}else{
								
								alert("주문 취소 실패하였습니다.");
								location.reload();
							}
							
						}
						
					})
				}
			break;
	}
	
}

$('.orderListCollapse').on('hide.bs.collapse', function () {
	
 	$(this).children().remove();
	
})



</script>