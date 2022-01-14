<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.banner-content{

	padding : 1rem 0rem .5rem 0rem;
}
.banner-box {
    text-align: center;
    height: 10rem;
    width: 100%;
}
.banner-img {
    object-fit: cover;
    height: 100%;
}
.brandName-box {
	padding: 2rem;
    margin-top: 1rem;
    border: 1px solid #dee2e6;
    border-radius: 10px;
}
.brandName-span{
	font-weight: bold;
	font-size: 1.5rem;
}
.brand-content{
	display: flex;
	min-height : 40rem;
}
.category-group {
    padding-top: 1rem;
    padding-bottom: 1rem;
}
.category_ul_li {
  /*  padding: 0.5rem 0rem; */
}

.category-name-p,.badge-cnt-p{ 
	font-size: 1.25rem;
}
.category-name-p,.category-name-s{
	border-bottom:1px solid #dee2e6;
	display: block;
	
}
.category_sub_ul{
	display: none;
}
.category_sub_ul_li {
   
}

.category-name-p { 
   padding: 0.5rem;
}
.category-name-s { 
        padding: 0.75rem;
    padding-left: 1.5rem;
}
.badge-cnt{
	font-weight: unset;
	font-size: 1rem;
}

.category-name-p.show{

	color: red;
		
}

.category-name-s.show{

	background-color: #dee2e6;
	color: red;
		
}
.sub-title-box {
    padding: 0.5rem 1rem;
    font-size: 1.25rem;
    font-weight: bold;
}
.page-info-box {
    display: flex;
    justify-content: space-between;
    padding: 1rem 0rem 0.5rem 1rem;
    align-items: flex-end;
}
.product-list{
	display: flex;
	padding-left: 0.5rem;
    padding-right: 0.5rem;
}
.produc-cnt-info_span {
    font-weight: bold;
    font-size: .75rem;
}
.p-list-box {
	display: flex;
	flex-direction: column;

	height: inherit;
    overflow: hidden;
       margin-top: 0.5rem;
    margin-bottom: 0.5rem;
    width: 25%;
}
.p-list-box-group {
    margin:.25rem;
}
.img-box>img {
    width: -webkit-fill-available;
    border-top-right-radius: 10px;
    border-top-left-radius:10px;
}
.info-box {
    background-color: #7fe7d52e;
	border-bottom-right-radius: 10px;
    border-bottom-left-radius:10px;
	padding: 0.5rem;
	min-height: 10rem;
}
.info-box_p{

	margin: unset;
}
.info-pname{
	overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-weight: bold;
}
.info-psale-before-pprice{
	font-size : .75rem;
	color : #ccc; 
	text-decoration: line-through;
}
.info-psale_span-psale{

	color : red;
	font-size : 1.25rem;
	
}
.info-psale_span-pprice , .info-price{

	color : #000;
	font-weight: bold;
	font-size : 1.25rem;
	
}
.info-rating_span{

	width:122px;
}
.info-rating_span, .info-rating_span >.rating{
	display: inline-block;
	height:26px;
	overflow: hidden;
	background: url(/resources/icon/rating.png)no-repeat;
}
.info-rating_span >.rating{
	background-position: left bottom;
	line-height: 0; 
	vertical-align: top;
	
}
span.info-reviewCnt-span {
    display: inline;
    vertical-align: top;
}

.go-page:hover{
	cursor: pointer;
	filter: contrast(0.8);
    box-shadow: 1px 1px 12px 1px #dee2e6;
    border-radius: 10px;
}
.info-pprice{
	
	font-size: 1.25rem;
	font-weight: bold;
}
</style> 
<div class="page">
	<div class="page-container">
		<div class="page-content banner-content border-bottom">
			<div class="banner-box">
				<img class="banner-img" src="">
			</div>
		</div>
		<div class="page-content brandName-content"> 
			<div class="brandName-box">
				<span class="brandName-span">${bvo.bname }</span>
			</div>
		</div>
		<div class="page-content brand-content">
			<div class="category-group col-2 border-right">
				<ul class="category_ul">
					<li class="category_ul_li ">
						<a href="/brand/${bvo.bnum }">
							<span class="category-name-p li_span" >
								전체
								<span class="badge badge-cnt badge-cnt-all ">
								
								</span>
							</span>
							
						</a>
					</li>
					<c:forEach items="${cList }" var="list">
						<c:if test="${list.level == 1 }">
							<li class="category_ul_li" >
								<span class="category-name-p li_span${list.ccode }"  >
									${list.cname }
									<span class="badge badge-cnt-p badge-cnt" id="pcnt-p-${list.ccode}"></span>								
								</span>
								<ul class="category_sub_ul" id="${list.ccode}-sub-ul">
									<li class="category_sub_ul_li">
										<a href="/brand/${bvo.bnum}?sort=all&categoryCode=${list.ccode}">
											<span class="category-name-s sub-li_span${list.ccode}">
												전체
												<span class="badge badge-cnt-p badge-cnt" id="pcnt-p-all-${list.ccode}"></span>
											</span>
										</a>
									</li>
									<c:forEach items="${cList }" var="sublist">
										<c:if test="${sublist.level == 2 && list.ccode == sublist.ccoderef }">
										<li class="category_sub_ul_li">	
											<a href="/brand/${bvo.bnum}?sort=sub&parent=${list.ccode}&categoryCode=${sublist.ccode}">
												<span class="category-name-s sub-li_span${sublist.ccode}">
												${sublist.cname } 
													<span class="badge-cnt-s badge-cnt" id="pcnt-s-${sublist.ccode }"></span>
												</span>
											</a>
										</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div class="product-group col-10">
				<div class="product-group_box border-bottom">
					<div class="sub-title-box">
						
						<c:if test="${cname == undefined }"> 
							<span class="sub-titl-box_span">전체</span>
						</c:if> 
						<c:if test="${cname != undefined }"> 
							<span class="sub-titl-box_span">${cname }</span>
						</c:if> 
						
					</div>
					
				</div>
				<div class="product-group_box border-bottom">
					
					<div class="page-info-box">
						<div class="product-cnt-info">
							<span class="produc-cnt-info_span">
								${pTotal}개의 제품
							</span>
						</div>
						<div class="sort-select-box">
							<select class="custom-select" id="productSortBy">
								<option value="ORDER_BY_REGDATE_DESC" <c:if test="${selectOrderBy == 'ORDER_BY_REGDATE_DESC' ||  selectOrderBy == ''}">selected</c:if>>최신순</option>
								<option value="ORDER_BY_PPRICE_DESC"  <c:if test="${selectOrderBy == 'ORDER_BY_PPRICE_DESC' }">selected</c:if>>가격높은순</option>
								<option value="ORDER_BY_PPRICE_ASC"  <c:if test="${selectOrderBy == 'ORDER_BY_PPRICE_ASC'}">selected</c:if>>가격낮은순</option>
								<option value="ORDER_BY_PRATING_DESC"  <c:if test="${selectOrderBy == 'ORDER_BY_PRATING_DESC' }">selected</c:if>>평점높은순</option>
								<option value="ORDER_BY_REVIEW_CNT_DESC"  <c:if test="${selectOrderBy == 'ORDER_BY_REVIEW_CNT_DESC' }">selected</c:if>>후기많은순</option>
							</select>
						</div>
					</div>
				</div>
				<div class="product-group_box">
					<div class="product-list">
						<c:forEach items="${pList}" var="list" varStatus="status">
				<div class="p-list-box ">
					<div class="p-list-box-group go-page">
					<a href="/product/${list.pid }" style="display:none"></a>
					
						<div class="p-list-box_content img-box">
							<img id="img-${status.count }" src="">
							<script>
								var pimgStr = JSON.stringify(${list.pimg});
								var pimgJSON = JSON.parse(pimgStr);
								var path =pimgJSON.img.path;
								var fileName = pimgJSON.img.fileName;				
								$("#img-${status.count}").attr("src" ,"/resources"+path+"/s/s_"+fileName);
							</script>
						</div>
						<div class="p-list-box_cotent info-box">
							<p class="info-box_p info-pname">${list.pname}</p>	
							<c:if test="${list.psale == 0 }">
											<p class="info-box_p info-pprice">
												<fmt:formatNumber pattern="###,###,###" value="${list.pprice}"/>원
										</p>
										</c:if>
										<c:if test="${list.psale !=0 }">
										<p class="info-box_p info-psale-before-pprice">
												<fmt:formatNumber pattern="###,###,###" value="${list.pprice}"/>원
										</p>	
										<p class="info-box_p info-psale-after-pprice">
											<span class="info-psale_span info-psale_span-psale">
												<fmt:formatNumber type="percent" value="${list.psale}"/>
											</span>
											<span class="info-psale_span info-psale_span-pprice">
												<c:set var="sale_price" value="${list.pprice - (list.pprice * list.psale)}"/>
												<fmt:formatNumber type="number" pattern="###,###,###" value="${sale_price + (10-(sale_price%10))%10}"/>원 
											</span>	
										</p>	
										</c:if>
							<p class="info-box_p info-rating">
								<c:set value ="${list.prating * 20 }" var = "rating"/>
								<span class="info-rating_span"> 
									<span class="rating" style="width:${rating}%"></span>
								</span>
								<span class="info-reviewCnt-span">
								(${list.reviewCnt })
								</span> 
							</p>	
						</div>
					</div> 
				</div>
			</c:forEach>
					</div>
				</div>
			</div>
		</div> 
	</div>
</div>

<script>
	$("#productSortBy").on("change",function(){
		
		
		var orderBy= $(this).val();
		var sort = "${selectSort}";
		var parent = "${selectParent}";
		var categoryCode = "${selectCategory}";
		var bnum = "${bvo.bnum}";
		
		var hrefStr = "/brand/"+bnum+"?page=1&";
		
		console.log(sort);
		console.log(parent);
		console.log(categoryCode);
		console.log(orderBy);
		if(sort != ""){
			
			hrefStr+="sort="+sort+"&";
		}
		if(parent != "" && parent != categoryCode){
			
			hrefStr+="parent="+parent+"&";
		}
		if(categoryCode != ""){
			
			hrefStr+="categoryCode="+categoryCode+"&";
		}
		
		hrefStr += "orderBy="+orderBy;
		
		//console.log(hrefStr);
		location.href="/brand/"+bnum+"?page=1&orderBy="+orderBy;
	})

	$(document).ready(function(){
		
	
		console.log("selectParent :'${selectParent}'");
		console.log("selectCategory :'${selectCategory}'");
		/*------------------img-------------------  */
		 var imgStr = JSON.stringify(${bvo.bimg});
		 var imgJSON = JSON.parse(imgStr);
		 var path = imgJSON.img.path;
		 var fileName = imgJSON.img.fileName;
		 $(".banner-img").attr("src","/resources"+path+"/"+fileName);
		/*------------------img-------------------  */
		 
		/*------------------pcnt-------------------  */
		 var obj_sub = JSON.parse('${psubCntJSON}');
		 $(".badge-cnt-s").each(function(){
			 
			var subCcode =  $(this).attr("id").split("-")[2];
		 
			for(var i = 0 ; i <obj_sub.length ; i++){
				 if(subCcode == obj_sub[i].ccode){
					
					 $("#pcnt-s-"+subCcode).text("("+obj_sub[i].productCnt+")");
					 
				 }
				 
			 } 
		 })
		 var obj_parent = JSON.parse('${pparentCntJSON}');
		 var parent_cnt = 0;
		 $(".badge-cnt-p").each(function(){
			var parentCcode =  $(this).attr("id").split("-")[2];
		 
			for(var i = 0 ; i <obj_parent.length ; i++){
				
				
				 if(parentCcode == obj_parent[i].ccoderef){
					
					 $("#pcnt-p-"+parentCcode).text("("+obj_parent[i].productCnt+")");
					 $("#pcnt-p-all-"+parentCcode).text("("+obj_parent[i].productCnt+")");
					 parent_cnt+= obj_parent[i].productCnt;
				 }
				
			 } 
		 }) 
		/*------------------pcnt-------------------  */
		$(".badge-cnt-all").text("("+parent_cnt+")");
		$("#${selectParent}-sub-ul").slideToggle(100);
		
		$(".li_span${selectParent}").addClass("show");
		$(".sub-li_span${selectCategory}").addClass("show");
		
	})
	
	$(".category-name-p").on("click",function(){
		
		$(this).next("ul").slideToggle();
	})
	$(".go-page").on("click",function(){
	
	location.href=$(this).children("a").attr("href");
	
})
</script>