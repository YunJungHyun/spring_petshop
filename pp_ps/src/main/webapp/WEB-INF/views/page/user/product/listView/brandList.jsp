<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.page-content-title {
    padding: .25rem .5rem;
    font-size: 1.75rem;
    font-weight: bold;
}

.page-content-sub-title{
    padding: .25rem .5rem;
	font-weight: bold;
}
.brand-group-sub{
	display: flex;
	justify-content: space-between;
	align-items: end;
}
.search-group_box {
	height: 40px;
	width: 300px;
	border: 3px solid #70e1ce;
	background-color: #fff;
	border-radius: 8px;
}


.search-group_box_input {
	font-size: 14px;
	padding: 10px;
	border: 0px;
	outline: none;
	float: left;
	width: 244px;
	border-radius: unset;
	height: 100%;
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
}

.search-group_box_input:focus-visible+.search-group_box_button
	{
	outline: 0;
}

.search-group_box_button {
	width: 50px;
	height: 100%;
	border: 0px;
	background-color: #70e1ce;
	outline: none;
	float: right;
	color: #fff;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}
.brand-group {
    display: flex;
    flex-wrap: wrap;
}

.brand-group_box {
    border: 1px solid #dee2e6;
    width: 20%;
    height :auto;
    text-align: center;
    overflow: hidden;
}

.brand-img-box {
    margin: 0.5rem;
}
.brand-img-box_img {
    object-fit: cover;
}
.bname-span{
	font-weight: bold;
	padding: 0.5rem;
    border-bottom: 1px solid #dee2e6;
    display: block;
}
</style>

<div class="page">
	<div class="page-container">
		<div class="page-content page-content-title mt-3">
			<span class="page-content-title_span">브랜드</span>
		</div>
		<div class="page-content page-content-sub-title mb-2 border-bottom">
			<div class="page-content_group brand-group-sub">
				<div class="brand-group-sub_box">
					<span class=" sub-title-product-length">${fn:length(bList)} </span>			
					<span class="sub-title-product-text">개의 브랜드</span>
				</div>
				<div class="brand-group-sub_box search-group">
					<div class="search-group">
						<div class="search-group_box search-group_box">
							<input type="text" class="search-group_box_input " placeholder="브랜드 이름을 검색해보세요!"/> 
							<button type="button" class="search-group_box_button "><i class="fas fa-search"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="page-content">
			<div class="page-content_group brand-group">
				<c:forEach items="${bList }" var="list" varStatus="status">
					<div class="brand-group_box ">
						<span class="bname-span">${list.bname }</span>
						<div class="brand-img-box go-page">
							<a href="/brand/${list.bnum }" style="display:none"></a>
							<img class="brand-img-box_img" id="img-${status.count }" src="">
							<script>
							var bimgStr = JSON.stringify(${list.bimg});
							var bimgJSON = JSON.parse(bimgStr);
							var path =bimgJSON.img.path;
							var fileName = bimgJSON.img.fileName;				
							$("#img-${status.count}").attr("src" ,"/resources"+path+"/"+fileName);
							</script>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<script>
$(".go-page").on("click",function(){
	
	location.href=$(this).children("a").attr("href");
	
})
</script>