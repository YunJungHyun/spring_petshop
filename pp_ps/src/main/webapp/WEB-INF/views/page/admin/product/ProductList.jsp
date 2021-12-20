<%@page import="org.spring.ps.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="page">
	<div class="ps-container p-0">

		<div class="d-flex px-1 py-2">
			<div class="mx-2">
				<a href="/adminView/ProductInsert" class="btn product-insert-btn" id="product-insert-btn">
					제품 등록
				</a>
			</div>
			<div class="mx-2">
				<select class="custom-select" id="ccoderef">
					<option value="000">상위 카테고리</option>
					<c:forEach items="${cList }" var ="clist">
						<c:if test="${clist.level == 1 }">
							<option  id="${clist.ccode }" value="${clist.ccode}" <c:if test="${clist.ccode == pagingMap.openCcode }">selected</c:if>>
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
					<option value="ORDER_BY_REGDATE_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REGDATE_DESC'  }">selected</c:if>>최신순</option>
					<option value="ORDER_BY_REGDATE_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REGDATE_ASC'  }">selected</c:if>>오래된순</option>
					<option value="ORDER_BY_PPRICE_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PPRICE_DESC'  }">selected</c:if>>가격높은순</option>
					<option value="ORDER_BY_PPRICE_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PPRICE_ASC'  }">selected</c:if>>가격낮은순</option>
					<option value="ORDER_BY_PCNT_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PCNT_DESC'  }">selected</c:if>>재고많은순</option>
					<option value="ORDER_BY_PCNT_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PCNT_ASC'  }">selected</c:if>>재고적은순</option>
				</select>
			</div>
			
			<div class="mx-2"> 
				<select class="custom-select" id="productState">
					<option value="allState" <c:if test="${pagingMap.openState == 'allState'  }">selected</c:if>>모든 상태</option>
					<option value="0" <c:if test="${pagingMap.openState == '0'  }">selected</c:if>>미등록상품</option>
					<option value="1" <c:if test="${pagingMap.openState == '1'  }">selected</c:if>>등록상품</option>
					<option value="2" <c:if test="${pagingMap.openState == '2'  }">selected</c:if>>재입고</option>
					 
				</select>
			</div>
			<div class="mx-2 d-flex flex-column page-reload-btn">
				<a href="/adminView/Product">
					<i class="fas fa-redo"></i>
				</a>
				<span>검색초기화</span>
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
							<select class="custom-select state-select" id="${plist.pid}-state">
								<option value="0" <c:if test="${plist.state ==0 }">selected="selected"</c:if>>미등록</option>
								<option value="1" <c:if test="${plist.state ==1 }">selected="selected"</c:if>>등록</option>
								<option value="2" <c:if test="${plist.state ==2 }">selected="selected"</c:if>>재입고</option>
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

$(document).on("change","#ccoderef,#ccode,#sortBy,#productState",function(e){
	
	var ccode="";

	var sortBy = $("#sortBy").val();
	var productState = $("#productState").val();
	
	
	
	if(e.currentTarget.id =="ccoderef"){
		
		ccode = $("#ccoderef").val();
	}else{
		ccode = $("#ccode").val();
	}
	
	pageLocation(ccode,sortBy,productState);
	
}) 

$(document).on("change",".state-select",function(){
	
	var stateSelectId =  $(this).attr("id");
	var stateSelectIdArr =stateSelectId.split("-");
	var pid = stateSelectIdArr[0];
	var state = $(this).val();
	
	var userInfo = '<%=(UserVO)session.getAttribute("userInfo")%>';
	if(userInfo == null ){
		
		alert("페이지 접근 권한이없습니다.");
		location.href="/";
	}else{
		
		console.log(userInfo);
		$.ajax({
		
			url : "/product/admin/stateChange",
			data : {
			
				"pid" : pid,
				"state" : state
			},success: function(data){
			
				if(data >=1){
					
					alert("제품 상태가 변경되었습니다.");
				}else{
					
					
					alert("제품 상태가 변경 실패하였습니다.");
				}
			}
		})
	}
})


function pageLocation(ccode,sortBy,productState){
	
	location.href= "/adminView/Product?ccode="+ccode+"&sortBy="+sortBy+"&state="+productState;
}

</script>