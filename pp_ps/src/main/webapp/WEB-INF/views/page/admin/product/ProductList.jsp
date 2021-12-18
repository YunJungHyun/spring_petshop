<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="page">
	<div class="container p-0">

		<div class="d-flex px-1 py-2">
			<div class="mx-2">
				<button class="btn">
					제품 등록
				</button>
			</div>
			<div class="mx-2">
				<select class="custom-select" id="ccoderef">
					<option value="000">상위 카테고리</option>
					<c:forEach items="${cList }" var ="clist">
						<c:if test="${clist.level == 1 }">
							<option  id="${clist.ccode }" value="${clist.ccode}" <c:if test="${clist.ccode == openCcode }">selected</c:if>>
								${clist.cname}
							</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="mx-2">
				<select class="custom-select" id="ccode">
					<option value="000">하위 카테고리</option>
					<c:forEach items="${cList }" var ="clist">
						<c:if test="${clist.level == 2 }">
							<option id="${clist.ccode }" class="${clist.ccoderef }" value="${clist.ccoderef}${clist.ccode}" style="display:none">
								${clist.cname}
							</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="mx-2">
				<select class="custom-select" id="sortBy">
					<option value="">정렬</option>
					<option value="ORDER_BY_REGDATE_DESC" selected="selected">최신순</option>
					<option value="ORDER_BY_REGDATE_ASC">오래된순</option>
					<option value="ORDER_BY_PPRICE_DESC">가격높은순</option>
					<option value="ORDER_BY_PPRICE_ASC">가격낮은순</option>
					<option value="ORDER_BY_PCNT_DESC">재고많은순</option>
					<option value="ORDER_BY_PCNT_ASC">재고적은순</option>
				</select>
			</div>
			<div class="mx-2">
				<select class="custom-select" id="productState">
					<option value="">제품현황</option>
					<option value="0">미등록상품</option>
					<option value="1">등록상품</option>
					<option value="2">재입고</option>
					
				</select>
			</div>
			<div  class="mx-2 float-right">
				
			</div>
		</div>
		  
		
		<table class="table text-center table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">이미지</th>
					<th scope="col">PID</th>
					<th scope="col">브랜드</th>
					<th scope="col">카테고리</th>
					<th scope="col">남은 수량</th>
					<th scope="col">등록 날짜</th>
					<th scope="col">가격</th>
					<th scope="col">상태</th>
				</tr>
			</thead> 
			<tbody>
				<c:forEach var="plist" items="${pList }" varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td class="product-img-box-3">
							<img id="img-${plist.pid }">
							<script>
							
							var pimgStr = JSON.stringify(${plist.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${plist.pid}").attr("src" ,path+"/s/s_"+fileName);
							</script>
						</td>
						<td>${plist.pid }</td>
						<td>
							<c:if test="${plist.pbrand == null}">
							X
							</c:if>
							<c:if test="${plist.pbrand != null}">
							${plist.pbrand }
							</c:if>
						</td>
						
						<td>
							<c:forEach var="clist" items="${cList}">
								<c:if test="${clist.ccode == plist.pccode  }">
									${clist.cname }
								</c:if>
							</c:forEach>
						</td> 
						<td>${plist.pcnt }</td>
						<td>${plist.pregdate }</td> 
						<td>${plist.pprice }</td>
						
						<td>
							<select class="custom-select">
								<option <c:if test="${plist.state ==0 }">selected="selected"</c:if>>미등록</option>
								<option <c:if test="${plist.state ==1 }">selected="selected"</c:if>>등록</option>
								<option <c:if test="${plist.state ==2 }">selected="selected"</c:if>>재입고</option>
							</select>
						</td> 
						
					</tr>
				</c:forEach>
			</tbody> 
		</table> 
		
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>  
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b> 
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/adminView/Product?page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
</div>

<script>

$(document).ready(function(){
	
	var openCcode = '${openCcode}';
	
	//상위카테고리 선택했을때
	if(openCcode.length>=3 && openCcode.length <=4){
		
		 
		$("#ccode").children().each(function(){
			
			if($(this).hasClass(openCcode)){
				$("#ccode").children(":first").css("display","block");
				$(this).css("display","block");
			}else{
				$("#ccode").children(":first").css("display","block");
				$(this).css("display","none");
				
			}
		})
		 
	}else if(openCcode.length > 4){
		
		var ccoderef = openCcode.substring(0,openCcode.length/2);
		var ccode = openCcode.substring(openCcode.length/2,openCcode.length);
		
		$("#ccoderef").children().each(function(){
			
			if($(this).val() == ccoderef){ 
				 
				$(this).attr("selected","selected");
			}
		})
		 
		$("#ccode").children().each(function(){
		
			if($(this).hasClass(ccoderef)){
				$("#ccode").children(":first").css("display","block");
				$(this).css("display","block");
			}else{
				$("#ccode").children(":first").css("display","block");
				$(this).css("display","none");
			
			}
			
			if($(this).attr("id") == ccode){
			
				$(this).attr("selected","selected");
			}
		})
		
		
	}
})

$(document).on("change","#ccoderef",function(){
	
	var ccoderef = $(this).val();
	
	
	$("#ccode").children().each(function(){
		
		if($(this).hasClass(ccoderef)){
			$("#ccode").children(":first").css("display","block");
			$(this).css("display","block");
		}else{
			$("#ccode").children(":first").css("display","block");
			$(this).css("display","none");
			
		}
	})
	
	location.href="/adminView/Product?ccode="+ccoderef;
})
$(document).on("change","#ccode",function(){
	
	var ccode = $(this).val();
	
	
	location.href="/adminView/Product?ccode="+ccode;
})
$(document).on("change","#sortBy",function(){
	
	var sortBy = $(this).val();
	var ccoderef = $("#ccoderef").val();
	var ccode = $("#ccode").val();
	
	console.log(sortBy+"/"+ccoderef+"/"+ccode);
	
	
})

</script>