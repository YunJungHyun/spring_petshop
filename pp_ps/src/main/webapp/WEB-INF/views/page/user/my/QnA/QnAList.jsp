<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.myPageBody-list-oneLine{
	border-bottom : 1px solid #dee2e6;
	padding : 1rem;
	display: flex;
}

.product-img{
	width : 7rem;
}

.list-content-box{
	padding : .5rem 1rem ;
	display: flex;
    justify-content: space-between;
    width: 100%;
}

.list-content-box_ul{
	     font-size: .75rem;
}
.list-content-box_li{
	margin-bottom: .25rem;
}
.list-content-box_li.pname{
	font-weight: bold;
}
.qnaContent-li{
	display: flex;
	align-items:  baseline;
}
.qnaContent-text{

	font-size: 1rem;
	font-weight: bold;
}
.qnaContent{
	    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    word-wrap: break-word;
    line-height: 1rem;
    height: 3.5rem;
    max-width: 35rem;
    padding: 0.5rem;
}
.helper{
	    display: inline-block;
    height: 100%;
    vertical-align: middle;
}

	.QnA-relpyList-one {
    padding: 0.5rem 1rem;
    background-color: #d6f7f2;
        display: flex;
	
	    border-radius: 5px;
    margin: 0.5rem 0rem;
}
.reply-content-span {
    display: inline-flex;
    flex-direction: column;
    margin: 0px 1rem;
    width: 100%;
}

.reply-writer-info{
    font-size: .75rem;
    font-weight: bold;
    margin-bottom: 0.25rem;
    padding: 0.25rem;

}
.reply-icon-span {
 
    align-self: center;
}

.reply-content { 
    padding: 0.75rem 0.5rem;
}
span.QnA-relpyList-span {
    padding: 1rem;
    background-color: #d6f7f2; 
    width: 100%;
    display: block;
    border-radius: 5px;
    font-weight: bold;
    font-size: 1.25rem;
}
.QnA-replyList {
    width: 100%;
}
</style>

<%@ include file="/WEB-INF/views/page/user/my/myPageHeader.jsp"%>
<div class="d-flex">
	<%@ include file="/WEB-INF/views/page/user/my/myPageLeftMenu.jsp"%>
	<div class="myPageBody col-10">
		<div class="myPageBody_title-group">
			<span class="myPageBody_title-group_span">나의 Q&A </span>
		</div>
		
		<div class="myPageBody">
		
			<c:if test="${fn:length(qnaList) == 0}">
				<div class="empty-info">작성하신 Q&A가 없습니다.</div>
			</c:if>
			<c:forEach items="${qnaList}" var="list" varStatus="status">
				<div class="myPageBody-list-oneLine">
					<div class="list-img-box">
						<img src="" id="img-${status.count }" class="product-img">
						<script>
							var pimgStr = JSON.stringify(${list.pimg}); 
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
						</script>
					</div>
					<div class="list-content-box">
						<ul class="list-content-box_ul">
							<li class="list-content-box_li pname">
								<a href="/product/${list.pid }">${list.pname }</a>
							</li>
							<li class="list-content-box_li qnaContent-li ">
								<span class="list-content-box_li_span qnaContent-text">Q :</span>
								<span class="list-content-box_li_span qnaContent">${list.qnaContent }</span>
							</li>
						</ul>
						 
						<div class="list-active-box">
								<div class="helper"></div>
								<button class="btn  btn-outline-primary list-active-box_btn" data-toggle="collapse"  data-target="#sub-${list.qnaid}">답변보기(<span id="cnt-${list.qnaid }"></span>)</button>
								<button class="btn btn-outline-danger list-active-box_btn" onclick="QnADelete('${list.qnaid}')">삭제</button>
						</div>
					</div>
					
				</div>
				 <div class="collapse list-oneLine-collapse" id="sub-${list.qnaid}"></div>
			</c:forEach>
		</div>
	</div>
</div>

<script>

function QnADelete(qnaid){
	
	var con = confirm("해당 문의를 삭제 하시겠습니까?");
	if(con == true){
		$.ajax({
		
			url : "/QnA/delete",
			type: "POST",
			data:{
				"qnaid" :qnaid
			},success:function(data){
				if(data>=1){
					location.reload();
				}else{
					
					alert("문의 삭제 실패하였습니다.");
					location.reload();
				}
			}
		})
	}
}
$(document).ready(function(){
	
 var JSONQnACnt = JSON.parse('${qCnt}');
	
	
	for(var i = 0 ; i < JSONQnACnt.length;i++){
	
		var parentid = JSONQnACnt[i].parentid;
		
		
		$("#cnt-"+parentid).text(JSONQnACnt[i].eachCnt);
		
	} 
	
})

$(".list-oneLine-collapse").on("show.bs.collapse",function(){
	
var qnaid = $(this).attr("id").split("-")[1];
	
	$("#sub-"+qnaid).empty();
	
	$.ajax({
		
		url : "/QnA/AdminReplyList",
		data: {
			
			"qnaid" : qnaid
		},
		type:"POST",
		success:function(data){
			
		var html = "<div class='QnA-replyList mb-3'>";
			
			if(data.length ==0){
				
				html+="<span class='QnA-relpyList-span'>아직 답변이 없습니다.</span>"	
			}else{
			
			
					
				for(var i = 0 ; i<data.length ;i++){
					
					html+="<div class='QnA-relpyList-one'>";
						html+="<span class='reply-icon-span'>";	
							html+="<img src='/resources/icon/reply.png'>"
						html+="</span>";
						html+="<span class='reply-content-span'>";
							html+="<span class='reply-writer-info border-bottom'>"
								html+=data[i].username
							html+="</span>";
							html+="<span class='reply-content'>";
								html+= "<span class='font-weight-bold'>A : </span>"+data[i].qnaContent;
								html+="<span class='font-weight-bold float-right'>"
								html+=data[i].qnaDate;
								html+="</span>";
							html+="</span>";
						html+="</span>";
					html+="</div>";
				}
				
				
			}
			html+="</div>";
			$("#sub-"+qnaid).append(html);
			
		}
		
	})
})

</script>