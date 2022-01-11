<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>

<style>

.myPageBody *{
	
	font-weight: bold;
}
.list-ul{
	
	list-style: none;
	padding : 0px;
	
}

.star{
  display:inline-block;
  width: 15px; 
  height: 30px;
  cursor: pointer; 
}
.star_left{
  background: url(/resources/icon/star-empty.png) no-repeat 0 0; 
  background-size: 30px; 
  margin-right: -3px; 
}
.star_right{
  background: url(/resources/icon/star-empty.png) no-repeat -15px 0; 
  background-size: 30px; 
  margin-left: -3px;
} 
.star.on{
  background-image: url(/resources/icon/star.png);
}
</style>
<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10 p-3">
	<c:forEach items="${rList }" var="list" varStatus="status">
			<div class="col-12 px-0 border mb-3 d-flex">
				<div class="col-4 p-3 text-center border-right">
					<img id="img-${status.count}"src="">
					<script>
							
							var pimgStr = JSON.stringify(${list.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
					</script>
				</div>
				<div class="col-8 p-3">
					<ul class="list-ul"> 
						
						<li>${list.pname }</li>
						<li> 
							<span>작성 날짜 :</span>
							<span>${list.revDate}</span>
						</li>
						<li>
						<div class="review-writer-oneline">
							<span>평점 :</span>
							<span class="star-box" id="star-box-${list.rating}" >
								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>

								<span class="star star_left"></span>
								<span class="star star_right"></span>
							</span>
							<span> ${list.rating}</span>
						</div>
							
						</li>
						<li>
							${list.revContent }
						</li>
						<li class="float-right">
							<button type="button" class="btn btn-primary" >주문정보</button>
							<button type="button" class="btn btn-primary" >수정</button>
							<button type="button" class="btn btn-primary" >삭제</button>
						</li>
					</ul>
				</div>
				
			</div>
				
	</c:forEach>
	</div>
</div>

<script>
$(document).ready(function(){
	
	$(".star-box").each(function(){
		
		var rating = $(this).attr("id").split("-")[2];
		var ratingEx = rating * 2;
		
		for(var i = 0 ; i < ratingEx ; i++ ){
			
			$(this).children().eq(i).addClass("on");
		}
	})
})

</script>