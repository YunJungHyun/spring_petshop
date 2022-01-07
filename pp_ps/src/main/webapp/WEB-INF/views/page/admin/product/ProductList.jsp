<%@page import="org.spring.ps.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.page-container{
	
}
.page-content.content-nav{
	display: flex;
	justify-content: space-between;
}
.page-content_ul{
	list-style: none;
	margin: 0;
	padding: 0;
}
.page-content_ul_li{
	margin: 0 0 0 0;
	padding: 0 0 0 0;
	border: 0;
	float: left;
}

.page-content_ul_li_a{
	border: 1px solid #7fe7d5;
    font-size: 1.25rem;
    font-weight: bold; 
    padding: .5rem 0.75rem;
    
}
.page-content_group {
    align-self: end;
}
.pcg-1 {
    display: flex;
    align-items: end;
}
.li-remote{
	min-width: 9rem;
    max-width: 9rem;
}
.li-remote_span {
    font-size: 12px;
    font-weight: bold;
    padding-left: 0.25rem;
    display: block
}
.li-remote_select{
	font-size :.75rem;
}
.page-content_ul_li_a.a-refresh {
    display: flex;
    flex-direction: column;
    align-items: center;
    border: 1px solid;
    padding: 0.3rem;
    border-radius: 5px;
}
.a-refresh_span {
    font-size: .75rem;
}

.page-content_group_search {
    width: 330px;
    height:50px;
   	border: 3px solid #70e1ce;
    background-color: #fff;
    border-radius: 8px;
}
.page-content_group_search_input {
    width: 270px;
    height: 100%;
    font-size: 16px;
    padding: 10px;
    border: 0px;
    outline: none;
    float: left;
    border-radius: unset;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
}
.page-content_group_search_button {
    width: 50px;
    height:100%;
   	border: 0px;
    background-color: #70e1ce;
    outline: none;
    float: right;
    color: #fff;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
}
.content-table_tbody_tr_td{
	padding : .25rem!important;
	border-left: 1px solid #dee2e6;
	font-size: .75rem;
	font-weight: bold;
	  text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
    max-width: 10rem;
}

.content-table th{
	border-bottom: 2px solid #dee2e6;
    font-size: .75rem;
    background-color: darkgreen;
    color: #fff;
    font-weight: bold;
    filter: drop-shadow(1px 1px 2px #000);
}


.content-table td:first-child{
	
	border-left: unset;
}
.content-table tr:last-child{
	border-bottom :  1px solid #dee2e6;
}

.pstate-select{
	width: 6rem;
    font-size: .75rem;
}

a.content-table_tbody_tr_td_a {
    width: 100%;
    display: block;
	font-size: 1.5rem;
    line-height: 2;
}
</style>
<div class="page">
	<div class="page-container">
		<div class="page-content content-nav mb-2 mt-3">
			<div class="page-content_group pcg-1">
				<div class="page-content_group_box mr-2 ">
					<a href="/adminView/ProductInsert" class="btn page-content_ul_li_a" >
						제품 등록
					</a>
				</div>
				<ul class="page-content_ul">
					<li class="page-content_ul_li li-remote mr-2">
						<span class="li-remote_span">상위 카테고리</span>
						<select class="custom-select li-remote_select" id="ccoderef">
							
							<option value="">전체</option>
							<c:forEach items="${cList }" var ="clist">
							<c:if test="${clist.level == 1 }">
							<option value="${clist.ccode}" <c:if test="${clist.ccode == pagingMap.ccoderef }">selected</c:if>>
								${clist.cname}
							</option>
							</c:if>
							</c:forEach> 
						</select>
					</li>
					<li class="page-content_ul_li li-remote mr-2 ">
						<span class="li-remote_span">하위 카테고리</span>
						<select class="custom-select li-remote_select" id="ccode">
							<option value="">전체</option>
							<c:forEach items="${cList }" var ="clist">
							<c:if test="${clist.level == 2 }">
							<option value="${clist.ccoderef }-${clist.ccode}" <c:if test="${clist.ccode == pagingMap.ccode }">selected</c:if> style="display:none">
								${clist.cname}
							</option>
							</c:if>
							</c:forEach> 
							
						</select>
					</li>
					<li class="page-content_ul_li li-remote mr-2">
						<span class="li-remote_span">제품 정렬</span>
						<select class="custom-select li-remote_select" id="sortBy">
							<option value="ORDER_BY_REGDATE_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REGDATE_DESC'  }">selected</c:if>>최신순</option>
							<option value="ORDER_BY_REGDATE_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REGDATE_ASC'  }">selected</c:if>>오래된순</option>
							<option value="ORDER_BY_PPRICE_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PPRICE_DESC'  }">selected</c:if>>가격높은순</option>
							<option value="ORDER_BY_PPRICE_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PPRICE_ASC'  }">selected</c:if>>가격낮은순</option>
							<option value="ORDER_BY_PCNT_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PCNT_DESC'  }">selected</c:if>>재고많은순</option>
							<option value="ORDER_BY_PCNT_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PCNT_ASC'  }">selected</c:if>>재고적은순</option>
							<option value="ORDER_BY_PRATING_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PRATING_DESC'  }">selected</c:if>>평점높은순</option>
							<option value="ORDER_BY_PRATING_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_PRATING_ASC'  }">selected</c:if>>평점낮은순</option>
							<option value="ORDER_BY_REVIEW_CNT_DESC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REVIEW_CNT_DESC'  }">selected</c:if>>리뷰많은순</option>
							<option value="ORDER_BY_REVIEW_CNT_ASC" <c:if test="${pagingMap.openSortBy == 'ORDER_BY_REVIEW_CNT_ASC'  }">selected</c:if>>리뷰적은순</option>
						</select> 
					</li>
					<li class="page-content_ul_li li-remote mr-2">
						<span class="li-remote_span">제품 상태</span>
						<select class="custom-select li-remote_select" id="pstate">
							<option value="" >전체</option>
							<option value="NOTPOSTING" <c:if test="${pagingMap.openState == 'NOTPOSTING'  }">selected</c:if> >미 게시</option>
							<option value="POSTING" <c:if test="${pagingMap.openState == 'POSTING'  }">selected</c:if>>게시</option>
							<option value="RESTOCK_REQ" <c:if test="${pagingMap.openState == 'RESTOCK_REQ'  }">selected</c:if>>재입고요청</option>
							<option value="RESTOCK_COM" <c:if test="${pagingMap.openState == 'RESTOCK_COM'  }">selected</c:if>>재입고완료</option>
					 	</select>
					</li>
					<li class="page-content_ul_li">
						<a class="page-content_ul_li_a a-refresh" href="/adminView/Product">
							<i class="fas fa-redo p-1"></i>
							<span class="a-refresh_span">검색초기화</span>
						</a>	
					</li> 
				</ul>
			</div>
			<div class="page-content_group">
				<div class="page-content_group_search">
					<input type="text" class="page-content_group_search_input" placeholder="찾으시는 제품 검색"> 
					<button type="button" class="page-content_group_search_button"><i class="fas fa-search"></i></button>
				</div>
			</div>
		</div>
		   
		<div class="page-content">
			<table class="table text-center table-hover content-table">
				<thead class="content-table_thead">
					<tr>
						<th scope="col">#</th>
						<th scope="col">이미지</th>
						<th scope="col">PID</th>
						<th scope="col">제품이름</th>
						<th scope="col">브랜드</th>
						<th scope="col">카테고리</th>
						<th scope="col">정가/할인율/할인가</th>
						<th scope="col">평점/리뷰수</th>
						<th scope="col">재고량</th>
						<th scope="col">등록날짜</th>						
						<th scope="col">상태</th>
						<th scope="col">제품보기</th>
					</tr>
				</thead> 
			<tbody class="content-table_tbody">
				<c:forEach var="plist" items="${pList }" varStatus="status">
					<tr class="content-table_tbody_tr" id="${plist.pid }">
						<td class="content-table_tbody_tr_td">${status.count }</td>
						<td class="ps-img-box-004 content-table_tbody_tr_td">
							<img id="img-${status.count }">
							<script>
							
							var pimgStr = JSON.stringify(${plist.pimg});
							var pimgJSON = JSON.parse(pimgStr);
							var path =pimgJSON.img.path;
							var fileName = pimgJSON.img.fileName;
							
							$("#img-${status.count }").attr("src" ,"/resources"+path+"/s/s_"+fileName);
							</script>
						</td>
						<td class="content-table_tbody_tr_td">${plist.pid }</td>
						<td class="content-table_tbody_tr_td">${plist.pname }</td>
						<td class="content-table_tbody_tr_td">
							<c:if test="${plist.pbrand == null}">
							X
							</c:if>
							<c:if test="${plist.pbrand != null}">
							${plist.pbrand }
							</c:if>
						</td>
						
						<td class="content-table_tbody_tr_td">
							<c:forEach var="clist" items="${cList}">
								<c:if test="${clist.ccode == plist.pccode  }">
									${clist.cname }
								</c:if>
							</c:forEach>
						</td>
						<td class="content-table_tbody_tr_td">${plist.pprice }/${plist.psale }</td>
						<td class="content-table_tbody_tr_td">${plist.prating }/${plist.reviewCnt }</td>
						
						<td class="content-table_tbody_tr_td">${plist.pcnt }</td>
						<td class="content-table_tbody_tr_td">${plist.pregdate }</td> 
						
						
						<td class="content-table_tbody_tr_td">
							<select class="custom-select pstate-select" id="${plist.pid}-pstate">
								 <option value="NOTPOSTING" <c:if test="${plist.pstate eq'NOTPOSTING' }">selected</c:if>>미 게시</option>
								<option value="POSTING" <c:if test="${plist.pstate eq 'POSTING' }">selected</c:if>>게시</option>
								<option value="RESTOCK_REQ" <c:if test="${plist.pstate eq'RESTOCK_REQ' }">selected</c:if>>재입고요청</option> 
								<option value="RESTOCK_COM" <c:if test="${plist.pstate eq'RESTOCK_COM' }">selected</c:if>>재입고완료</option> 
							</select>
						</td> 
						
						<td class="content-table_tbody_tr_td">
							<a href="/adminView/ProductUpdate?pid=${plist.pid }" class="content-table_tbody_tr_td_a">
								<i class="fas fa-search"></i>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody> 
		</table> 
		</div>
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
	
	var ccoderef = "${pagingMap.ccoderef}";
	
	if(ccoderef !=""){
		
		viewCcode(ccoderef);
		
	}
})

$(document).on("change","#ccoderef,#ccode,#sortBy,#pstate",function(e){
	var ccoderef = $("#ccoderef").val(); 
	var ccode = $("#ccode").val().split("-")[1]; 
	var sortBy = $("#sortBy").val(); 
	var pstate = $("#pstate").val(); 
	
	if(e.currentTarget.id =="ccoderef"){ 
		
		viewCcode(ccoderef);
		var openCcode ="${pagingMap.ccode}";
		if(openCcode != ""){
			
			ccode= "";
		}
	}
	
	pageLocation(ccoderef,ccode,sortBy,pstate);
	
}) 

function viewCcode(ccoderef){
	
	$("#ccode option").each(function(){
		
		
		if($(this).val().split("-")[0] == ccoderef || $(this).val() == ""){
			
			$(this).css("display","block");
		}else{
			
			$(this).css("display","none");
		}
	})
	
	
}

$(document).on("change",".pstate-select",function(){
	
	var pid =  $(this).attr("id").split("-")[0];
	var state = $(this).val();
	
	var userInfo = '${userInfo}';
	
	if(userInfo == null || userInfo== ""){
		
		alert("페이지 접근 권한이없습니다.");
		location.href="/";
	}else{
		
		//console.log(userInfo);
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


 
function pageLocation(ccoderef,ccode,sortBy,pstate){
	
	
	var locationStr = "/adminView/Product?";
	
	var addLocation = "";
	
	if( !(ccoderef == undefined || ccoderef=="") ){
		
		console.log("ccoderef :"+ccoderef);
		addLocation +="ccoderef="+ccoderef+"&";
	}
	
	
	if( !(ccode == undefined || ccode=="") ){
		
		console.log("ccode :"+ccode);
		addLocation +="ccode="+ccode+"&";
	}
	
	
	if( !(sortBy == undefined || sortBy=="") ){
		
		console.log("sortBy :"+sortBy);
		addLocation +="sortBy="+sortBy+"&";
	}
	
	
	if( !(pstate == undefined || pstate=="") ){
		
		console.log("ccoderef :"+ccoderef);
		addLocation +="pstate="+pstate+"&";
	}
	
	locationStr += addLocation;

	
	var go = locationStr.slice(0,-1);
	

	
	location.href=go;
	
	
}

</script>