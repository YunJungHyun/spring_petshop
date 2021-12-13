<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="category-list p-2">
	<div class="row flex-nowrap justify-content-between align-items-center">
		<div class="col-4 d-flex justify-content-start align-items-center">
			<div class="ps-dropdown">
				<a href="#" class="category-menu-btn">카테고리</a>
				
				<ul class="ps-dropdown-content category-menu-content list-group">
				
				</ul>
				
			</div>
		</div>
	</div>
</div>


<script>
$(document).ready(function(){
	getCategoryList();
	
})

function getCategoryList(){
	$.ajax({
		
		url : "/category/getCategoryList",
		type:"POST",
		dataType : "json",
		success : function(data){
			var cateArr = new Array();
			var cateObj = new Object();
			
			var cateSubArr = new Array();
			var cateSubObj = new Object();
			
			for(var i = 0 ; i < data.length ; i++){
				
				if(data[i].level == 1){
					
					cateObj = new Object();
					cateObj.ccode = data[i].ccode;
					cateObj.cname = data[i].cname;
					cateArr.push(cateObj);
				}else if(data[i].level == 2){
					
					//console.log(data[i].cname);
					cateSubObj = new Object();
					cateSubObj.ccode = data[i].ccode;
					cateSubObj.cname = data[i].cname;
					cateSubObj.ccoderef = data[i].ccoderef;
					//console.log(data[i].ccoderef);
					cateSubArr.push(cateSubObj);
					
				}
			}
			
			var parentCategory = $(".category-menu-content");
			
			for(var i = 0 ; i < cateArr.length; i++){
				var html = "<li class='dropdown-li ps-sub-dropdown'>"
					html += "<a href='/category/"+cateArr[i].ccode+"'>"+cateArr[i].cname+"</a>"
					html += "<ul class='ps-sub-dropdown-content list-group' >"
					
					for(var j = 0 ; j <cateSubArr.length; j++){
				
						if(cateSubArr[j].ccoderef == cateArr[i].ccode ){ 
							html += "<li class='dropdown-li'>"
							html += "<a href='/category/"+cateSubArr[j].ccoderef+cateSubArr[j].ccode+"'>"+cateSubArr[j].cname+"</a>"
							html += "</li>";
						}
					}
					
					html += "</ul>";
					html += "</li>";
				parentCategory.append(html);
			}
		}
		 
	})  
} 

$(document).on("mouseenter",".ps-sub-dropdown",function(){
	
	$(this).children("ul").stop().slideToggle(100);
	$(this).children("ul").addClass("show");
})
$(document).on("mouseleave",".ps-sub-dropdown",function(){
	
	if($(this).children("ul").hasClass("show")){
		
		$(this).children("ul").stop().slideToggle(50);
	}

})

</script>