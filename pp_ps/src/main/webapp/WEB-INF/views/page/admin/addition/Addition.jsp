<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.page-content_group_title{
	padding-bottom: .5rem;
	border-bottom : 1px solid #dee2e6;
}
.page-content_group_title-span {
    font-size: 1.5rem;
    font-weight: bold;
    display: inline;
    vertical-align: middle;
}
.page-content_group.category-group {
    display: flex;
    flex-wrap: wrap;
        margin-top: 1rem;
}
.category-box {
    margin: 0.5rem;
    padding: 1rem;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    min-height: 10rem;
}
.category-group_span {
  position: absolute;
    top: -5px;
      min-width: fit-content;
    left: 50%;
    text-align: center;
    transform: translate(-50%, 0);
    z-index: 2;
    background-color: #fff;
    font-weight: bold;
    padding-left: 0.5rem;
    padding-right: 0.5rem;
    font-size: 1.25rem; 
}
</style>
<div class="page mt-5">
	<div class="page-container">
		
		<div class="page-content mb-5">
			<div class="page-content_group ">
				<div class="page-content_group_title">
					<span class="page-content_group_title-span">카테고리 목록</span>
					<button type="button" class="btn btn-outline-primary page-content_group_title_button float-right">상위 카테고리 추가</button>		
				</div> 
			</div>
			<div class="page-content_group category-group">
				<c:forEach items="${cList }" var="list">
					<c:if test="${list.level == 1 }"> 
						<div class="page-content_group_box col-3">
							<div class="category-box" id="parent-${list.ccode}">
								<span class="category-group_span">${list.cname }</span>
								
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="page-content">
			<div class="page-content_group ">
				<div class="page-content_group_title">
					<span class="page-content_group_title-span">브랜드 목록</span>
					<button type="button" class="btn btn-outline-primary page-content_group_title_button float-right">브랜드 추가</button>
				</div> 
			</div>
		</div>
	</div> 
</div>

<script>
	$(document).ready(function() {

	})
</script>