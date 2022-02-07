<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
table{
	text-align: center;
	
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


.qnaDetailCollapse:hover {
    background-color: unset!important;
}

.qnaDetailGroup{
	text-align: left;
}
.prod-user-Info-group{

	display: flex;
}
.qnaDetailGroup_img-Box {
    padding: 0.25rem;
    border: 1px solid #dee2e6;
    border-radius: 5px;
	display: flex;
   
}
.qnaDetailGroup_img-Box_img{
    width: 10rem;
    align-self: center;
    border-radius: 5px;

}
.qnaDetailGroup_content-Box {
    border: 1px solid #dee2e6;
    width: 100%;
    margin-left: 0.25rem;
    border-radius: 5px;
}
ul.qnaDetailGroup_content-Box_ul {
    padding: 0.5rem;
    height: 100%;
}
span.productName {
    font-size: 1.25rem;
    font-weight: bold;
}
.table_td_span {
    width: 300px;
    padding: 0 5px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inline-block;
}

.userName {
    font-weight: bold;
    font-size: 1.25rem;
}

.qnaInput-group{
	display: flex;
}

.subQnAInput{

	padding : 1rem;
	border-top-right-radius: unset;
	border-bottom-right-radius: unset;
}
.subQnAInput-btn {
    background-color: #70e1ce;
    border-top-left-radius: unset;
    border-bottom-left-radius: unset;
    font-weight: bold;
}
.QnA-relpyList-one {
    padding: 0.5rem 1rem;
    background-color: #d6f7f2;
        display: flex;
	border-radius: 5px;
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
</style>

<div class="page mt-3">
	<div class="page-container">
	
		<div class="page-content">
			<div class="page-content_title">
				<span class="page-content_title_span">고객 문의</span>
			</div>
		</div>
		<div class="page-content">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						
						<th class="col-1">문의ID</th>
						<th class="col-2">제품ID</th>
						<th class="col-3">회원ID</th>
						<th class="col-4">문의 내용</th>
						<th class="col-2">문의날짜</th>
						
					</tr>
				</thead>
				<tbody>
				
					
					<c:forEach var="list" items ="${qlist }" varStatus="status">
						<c:if test="${empty list.parentid }">
							<tr data-toggle="collapse" data-target="#collapse-${list.qnaid }">
								
								<td class="table_td">${list.qnaid }</td>
								<td class="table_td">${list.pid }</td>
								<td class="table_td">${list.userid }</td>
								<td class="table_td">
									<span class="table_td_span">${list.qnaContent }</span>
								</td>
								<td>${list.qnaDate }</td> 
							</tr>
						
							<tr class="collapse qnaDetailCollapse" id="collapse-${list.qnaid }">
								<td colspan="6">
									<div class="qnaDetailContent">
										<div class="qnaDetailGroup prod-user-Info-group border-bottom pb-3">
											<div class="qnaDetailGroup_img-Box">
												<img class="qnaDetailGroup_img-Box_img" id="img-${status.count }"  src="">
												<script>
													var pimgStr = JSON.stringify(${list.pimg});
													var pimgJSON = JSON.parse(pimgStr);
													var path =pimgJSON.img.path;
													var fileName = pimgJSON.img.fileName; 
													
												$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
												
												</script>
											</div>
											<div class="qnaDetailGroup_content-Box">
												<ul class="qnaDetailGroup_content-Box_ul">
													<li class="qnaDetailGroup_content-Box_li p-2 mb-2 border-bottom"><span class="productName">${list.pname }/<a href="#">${list.pid }</a></span></li>
													<li class="qnaDetailGroup_content-Box_li px-2 mb-2"><span class="userName">${list.username }</span></li>
													<li class="qnaDetailGroup_content-Box_li px-2"><span class="QnAContent">${list.qnaContent }</span></li>
												</ul>
											</div>
										</div>  
										<div class="qnaDetailGroup pt-3">
											<div class="qnaDetailGroup qnaSubList-group" id="qnaSubList-${list.qnaid}">
											</div>
											<div class="qnaDetailGroup ">
												<form name="answerInsertForm" id="answerInsertForm-${list.qnaid }">
													<div class="qnaInput-group">
														<input type="hidden" name="pid" value="${list.pid}">
														<input class="subQnAInput col-10" id="subQnAInput" name="qnaContent" type="text" placeholder="답변을 달아주세요.">
														<button type="button" class="btn subQnAInput-btn col-2" onclick="answerInsert('${list.qnaid}')">답변 달기</button>
													</div>
												</form>
											</div>
										</div>
									</div>  
								</td>
							</tr>
						</c:if> 
					</c:forEach> 
				</tbody>
			</table>
			
		</div>
	</div>
</div>

<script>


function answerInsert(qnaid){
	
	var formData = $("#answerInsertForm-"+qnaid).serialize();
	formData+="&parentid="+qnaid;
	
	$.ajax({
		
		
		url:"/QnA/answerInsert",
		data:formData,
		type: "POST",
		success:function(data){
			
			if(data >=1){
				
				alert("답변이 등록되었습니다.");
				location.reload();
			}else{
				
				alert("답변 등록에 실패하였습니다.");
				location.reload();
			}
			
		}
		
	})
}


$(".qnaDetailCollapse").on("show.bs.collapse",function(e){
	
	
	var qnaid = $(this).attr("id").split("-")[1];
	
	$("#qnaSubList-"+qnaid).empty();
	
	 $.ajax({
		
		url : "/QnA/AdminReplyList",
		data: {
			
			"qnaid" : qnaid
		},
		type:"POST",
		 
		success:function(data){
			
			var html = "<div class='QnA-replyList mb-3'>";
			
			if(data.length ==0){
				
				html+="<span class='QnA-relpyList-span'>작성한 답변이 없습니다.</span>"	
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
			$("#qnaSubList-"+qnaid).append(html);
		}
	})
	
})


</script>