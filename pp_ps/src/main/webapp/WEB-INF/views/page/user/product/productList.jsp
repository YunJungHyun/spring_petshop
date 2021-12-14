<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="page d-flex px-0">
	<div class="category-menu col-2 px-0 border-right ">
		<ul class="category-menu-ul list-group">
			<li class="category-menu-li " >
				<span class="category-li-span all-category" id="000">전체</span>
			</li>
			<c:forEach var="clist" items="${cList}">
				
				<c:if test="${clist.level == 1 }">
				<li class="category-menu-li">
					<span id="parent-${clist.ccode}" class="category-li-span">
						${clist.cname}
						<i class="fas fa-arrow-circle-down float-right" style="color :#ccc"></i>
					</span>
					 
					<ul class="category-sub-menu-ul">
						<li class="category-sub-menu-li" >
							<span id="${clist.ccode}" class="category-sub-li-span">전체</span>
						</li>
						<c:forEach var="clist_sub" items="${cList }">
							<c:if test="${clist_sub.level == 2 && clist.ccode == clist_sub.ccoderef}">
								<li class="category-sub-menu-li" >
									<span  id="${clist.ccode}${clist_sub.ccode}" class="category-sub-li-span">
									${clist_sub.cname}
									</span>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<div class="product-list col-10">
		<div class="category-page-name">
		</div>
		<div class="category-page-cnt mb-2 pt-2 pb-1 px-2">
			${pTotal}개의 상품 
			<select class="float-right custom-select sort-select">
				<option>최근 등록순</option>
				<option>가격 낮은순</option>
				<option>가격 높은순</option> 
				<option>별점 높은순</option>
				<option>후기 많은순</option>
			</select>
		</div>
		
		<div class="category-page-plist row">
			<c:forEach  var="plist" items="${pList }">
				<div class="col-3 d-flex flex-column px-3 pb-4 product-one" id="${plist.pid }" > 
					<div class="product-img-box-1" >
						<img id="img-${plist.pid }"/>
						<script>
							
							var pimgStr = JSON.stringify(${plist.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${plist.pid}").attr("src" ,path+"/"+fileName);
						</script>
					</div> 
					<div class="product-content-box">
						<p>${plist.pname }</p>	
						<p>${plist.pprice}</p>	
					</div>
				</div>
			</c:forEach>
		</div>
	
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>  
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b> 
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/category/${openCcode}?page=${p }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		
	</div>
</div>

<script>
$(document).ready(function(){
	var openCccode = "${openCcode}";
	
	if(openCccode != 000){
		if(openCccode.length >=3 && openCccode.length <= 4){ // 상위카테고리를 선택했을경우
			$("#parent-"+openCccode).parent().addClass("show");
			$("#parent-"+openCccode).next("ul").slideToggle(100);
			$("#"+openCccode).addClass("prodChg"); 
			
			var categoryName = $("#parent-"+openCccode).text();
			$(".category-page-name").append(categoryName.trim());
		}else{
		
			var ccoderef= openCccode.substr(0,openCccode.length/2);
			var ccode= openCccode.substr(openCccode.length/2,openCccode.length);
		
	
			$("#parent-"+ccoderef).parent().addClass("show");
		
			$("#parent-"+ccoderef).next("ul").slideToggle(100);
			$("#"+openCccode).addClass("prodChg");
			
			var categoryName = $("#"+openCccode).text();
			$(".category-page-name").append(categoryName.trim());
		}
	}else{
		
		$("#"+openCccode).parent().addClass("show");
		$(".category-page-name").append("전체");
	}
	
})
$(".category-menu-li > span").on("click",function(e){
	
	
	if($(this).hasClass("all-category")){ 
		location.href="/category/000?page=1&sortBy=0";
		
	}
	$(this).next("ul").stop().slideToggle(100);
	
	if(!$(this).parent("li").hasClass("show")){
		
		$(this).parent("li").addClass("show");
		$(this).find("svg").replaceWith("<i class='fas fa-arrow-circle-up float-right' style='color :#000'></i>");
		
	}else{
		

		$(this).parent("li").removeClass("show");
		$(this).find("svg").replaceWith("<i class='fas fa-arrow-circle-down float-right' style='color :#ccc'></i>");
	}

})

$(document).on("click",".category-sub-li-span", function(e){
	
	$(".category-sub-menu-li").each(function(){
		
		if($(this).children("span").hasClass("prodChg")){
			
			$(this).children("span").removeClass("prodChg");
		}
	})
	
	if(!$(this).hasClass("show")){
		
		$(this).addClass("prodChg");
	}
	 
	var ccode = $(this).attr("id");
	

	location.href="/category/"+ccode+"?page=1&sortBy=0";
})

$(document).on("click",".product-one",function(){
	
	location.href="/product/"+$(this).attr("id");
})
</script>