<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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


.th_span-box{

	display: flex;
	justify-content: center;
}
.sort-icon{
	display:none;
	border-radius: 20px; 
    background-color: #dee2e6
}
.sort-icon.active{ 
	display:block;
}

span.list-td_span{
	display:block;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    margin: 0px auto;
}
.sortBy:hover{
	
	background-color: #d6f7f2;
    cursor: pointer;
}

.userActivityInfo-btn{
	color : #bbb;
}
</style>
<div class="page mt-3">
	<div class="page-container">
		<div class="page-content">
			<div class="page-content_title">
				<span class="page-content_title_span">회원 관리</span>
			</div>
		</div>
		<div class="page-content">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>#</th> 
						<th>
							<span class="th_span-box">
								<span class="th_span-group">
									아이디
								</span>
							</span>
						</th>
						
						<th>
							<span class="th_span-box">
								<span class="th_span-group">
									이름
								</span>
								
							</span>						
						</th>
						<th >
							<span class="th_span-box">
								<span class="th_span-group">
									이메일
								</span>
								
							</span>						
						</th>
						
						<th >
							<span class="th_span-box">
								<span class="th_span-group">
									가입 날짜
								</span>
								
							</span>
						</th>
						<th>
							<span class="th_span-box">
								<span class="th_span-group">
									가입 유형
								</span>
								
							</span>
						</th>
						<th>
							<span class="th_span-box">
								<span class="th_span-group">
									권한
								</span>
								
							</span>
						</th>
						<th>주문 </th>
						<th>리뷰 </th>
						<th>문의 </th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${uList }" var ="list" varStatus="state">
					<tr class="userDetail" id="${list.unum }">
						<td class="list-td">
							${state.count }
						</td>
						<td class="list-td">
							<span class="list-td_span" style="width:200px" >
								${ list.userid }
							</span>
						</td>
						<td class="list-td">
							<span class="list-td_span">
							${ list.username }
							</span>
						</td>
						<td class="list-td">
							<span class="list-td_span" style="width:200px"  >
							${ list.uemail }
							</span>
						</td>
						
						<td class="list-td">
							<span class="list-td_span" >
							${ list.user_regdate }
							</span>
						</td>
						<td class="list-td">
							<span class="list-td_span"  >
							${ list.utype }
							</span>
						</td>
						<td class="list-td">
							<span class="list-td_span" >
								<c:if test="${ list.ulevel == 1 }">일반</c:if>
								<c:if test="${ list.ulevel == 2 }">관리자</c:if>
							</span>
						</td>
						<td class="p-0">
							${ list.orderCnt }
						</td>
						<td class="p-0">
							${ list.reviewCnt }
						</td>
						<td class="p-0">
							${ list.qnaCnt }
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>


<script>
	
	$(".userDetail").on("click",function(){
		var unum = $(this).attr("id");
		location.href="/adminView/member/"+unum;
	})
	
	
</script>