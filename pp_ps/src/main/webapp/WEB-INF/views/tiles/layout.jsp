<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<style>
</style>
<!-- Custom styles for this template -->


<!-- font-awesome  -->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script src="/resources/js/ckeditor/ckeditor.js"></script>

<link href="/resources/css/ps.css" rel="stylesheet" type="text/css">
<link href="/resources/css/dropdown.css" rel="stylesheet" type="text/css">
<link href="/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="/resources/css/button.css" rel="stylesheet" type="text/css">
<link href="/resources/css/page.css" rel="stylesheet" type="text/css">

 
<title>PETSHOP - ${pageTitle}</title>

</head>
<body> 

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
	
	
	<div class="container">
		<header class="ps-header">
			<tiles:insertAttribute name="header" />
		</header>
		<tiles:insertAttribute name="category" />
		<tiles:insertAttribute name="body" />

		<footer>
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>

<script>
 



$(".ps-dropdown").hover(function(){
	 
	$(this).children("ul").stop().slideToggle(100);
	
})
//auth 로그인 및 회원가입
function authLogin(auth_sort){
	$.ajax({
		
		url : "/join/getAuthUrl/"+auth_sort,
		success :function(data){
		
			location.href=data;
		}
	})
	
}

</script>

