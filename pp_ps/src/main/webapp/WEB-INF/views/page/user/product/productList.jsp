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
		<c:forEach  var="plist" items="${pList }">
			${plist.pname }
		</c:forEach>
	</div>
</div>

<script>
$(document).ready(function(){
	var openCccode = "${openCcode}";
	
	if(openCccode != 000){
		if(openCccode.length >=3 && openCccode.length <= 4){
			$("#parent-"+openCccode).parent().addClass("show");
			$("#parent-"+openCccode).next("ul").slideToggle(100);
			$("#"+openCccode).addClass("prodChg"); 
		}else{
		
			var ccoderef= openCccode.substr(0,openCccode.length/2);
			var ccode= openCccode.substr(openCccode.length/2,openCccode.length);
		
	
			$("#parent-"+ccoderef).parent().addClass("show");
		
			$("#parent-"+ccoderef).next("ul").slideToggle(100);
			$("#"+openCccode).addClass("prodChg");
		
		}
	}else{
		
		$("#"+openCccode).parent().addClass("show");
	}
	
})
$(".category-menu-li > span").on("click",function(e){
	
	
	if($(this).hasClass("all-category")){ 
		location.href="/category/000?page=0&sortBy=0";
		
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
	

	location.href="/category/"+ccode+"?page=0&sortBy=0";
})


</script>