<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
table{
	text-align: center;
	    font-size: .75rem;
}
.page-content_title {
    padding: 0rem 1rem;
    margin: 0.5rem auto;
    border-bottom : 1px solid #dee2e6;
}
.page-content_title_span {
    font-size: 1.5rem;
    font-weight: bold;
}
.pimg{
	width :3rem;
}
.detail-img-box {
    display: flex;
    align-items: center;
}
.detail-pimg{

	width:7rem;
}

.list-detail_content {
    display: flex;
}
.detail-content-box {
    padding: 0.5rem 1rem;
        width: 80%;
}
.detail-product-info{
	font-size: 1rem;
	font-weight: bold;
	    border-bottom: 1px solid #dee2e6;
    margin-bottom: 0.25rem;
    text-align: left;
        padding: 0rem 0rem 0.5rem;
}
.detail-review-info_ul{
	text-align: left;
}

.title-span{
	font-weight: bold;
}

.revContent-span{
	background-color: #7fe7d552;
	padding : .5rem;
	border-radius: 5px;
	    display: inline-block;
    margin: 0.5rem 0px;
	width: 100%;
}

.detail-active-box {
    align-self: center;
    width: 10%;
}

.star-box{ 
	font-size: .75rem;
}

.star{
  display:inline-block;
  width: 10px; 
  height: 20px;
  
}
.star_left{
  background: url(/resources/icon/star-empty.png) no-repeat 0 0; 
  background-size: 20px; 
  margin-right: -2px; 
}
.star_right{
  background: url(/resources/icon/star-empty.png) no-repeat -10px 0; 
  background-size: 20px; 
  margin-left: -2px;
  margin-right: 0.25rem;
} 
.star.on{
  background-image: url(/resources/icon/star.png);
}


tr.list-detail:hover{
	color :unset!important;
	background-color: unset!important;
}
.product-link ,  .product-link:hover{
	color:#007bff;
	text-decoration: underline;
}
</style>
<div class="page mt-3">
	<div class="page-container">
		<div class="page-content">
			<div class="page-content_title">
				<span class="page-content_title_span">구매 후기 관리</span>
			</div>
		</div>
		<div class="page-content">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>제품이미지</th>
						<th>제품아이디</th>
						<th>회원아이디</th>
						<th>평점</th>
						<th>리뷰</th>
						<th>작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${rList }" var="list" varStatus="status">
						<tr data-toggle="collapse" data-target="#list-detail-${list.revNum }">
							<td> 
								${status.count } 
							</td>
							<td> 
								<img src="" id="pimg-${status.count }" class="pimg">
								<script>
									var pimgStr = JSON.stringify(${list.pimg}); 
									var pimgJSON = JSON.parse(pimgStr);
									var path =pimgJSON.img.path; 
									var fileName = pimgJSON.img.fileName;
									$("#pimg-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
								</script>
							</td>
							<td> 	
								${list.pid }
							</td>
							<td>
								${list.userid }
							</td>
							<td>
								${list.rating }
							</td>
							<td>
								${list.revContent }
							</td>
							<td>
								${list.revDate }  
							</td>
							
						</tr> 
						<tr id="list-detail-${list.revNum}" class="collapse list-detail">
				 			<td colspan="7" id="list-detail-${list.revNum }">
				 				<div class="list-detail_content">
				 					<div class="detail-img-box">
				 						<img src="" id="pimg-detail-${status.count }" class="detail-pimg">
										<script>
											var pimgStr = JSON.stringify(${list.pimg}); 
											var pimgJSON = JSON.parse(pimgStr);
											var path =pimgJSON.img.path; 
											var fileName = pimgJSON.img.fileName;
											$("#pimg-detail-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
										</script>
				 					</div>
				 					<div class="detail-content-box">
				 						<div class="detail-product-info ">
				 							<span>${list.pname }</span>/<span ><a href="/product/${list.pid }" class="product-link">${list.pid }</a></span>
				 						</div>
				 						<div class="detail-review-info">
				 							<ul class="detail-review-info_ul">
				 								<li class="detail-review-info_li">
				 									<span class="title-span">작성 날짜 : &nbsp;</span>
				 									<span class="content-span">${list.revDate }</span>
				 								</li>
				 								<li class="detail-review-info_li">
				 									<span class="title-span">평점 : &nbsp;</span>
				 									<span class="content-span">
				 										<span class="star-box" id="star-box-${list.rating }">
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
				 										${list.rating }
				 									</span>
				 								</li>
				 								<li class="detail-review-info_li">
				 									<span class="title-span">작성자 : &nbsp;</span>
				 									<span class="content-span">${list.username }</span>
				 								</li>
				 								<li class="detail-review-info_li">
				 									<span class="title-span">내용: &nbsp;</span>
				 									<span class="content-span revContent-span">${list.revContent }</span>
				 								</li>
				 							</ul>
				 						</div>
				 						
				 					</div>
				 					<div class="detail-active-box">
				 							<button class="btn btn-outline-danger" onclick="reviewDelete('${list.orderid }','${list.pid }')">삭제</button>
				 					</div>
				 				</div>
				 			</td>
						</tr>  
					</c:forEach>
				</tbody>
			</table> 
		</div>
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


$(".list-detail").on("show.bs.collapse",function(){
	
	
	var revNum = $(this).attr("id").split("-")[2];
	
})

function reviewDelete(orderid,pid){
	
	var con = confirm("해당 리뷰를 삭제 하시겠습니까?");
	if(con==true){
		
		$.ajax({
			
			
			url : "/review/delete",
			type : "POST",
			data : {
				
				"orderid" : orderid,
				"pid" : pid
			},success : function(data){
				
				if(data >=1){
					
					location.reload()
				}else{
					
					alert("리뷰 삭제 실패하였습니다.");
					location.reload();
				}
				
			}
			
		})
		
	}
}
</script>