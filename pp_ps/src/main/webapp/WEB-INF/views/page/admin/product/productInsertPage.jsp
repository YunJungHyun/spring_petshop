<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="page">
	<div class="container">
		<div class="page-emptied-admin"></div>
		<div class="page-contents d-flex flex-column justify-content-center ">

			<form>
				<div class="form-group">
					<label for="exampleInputEmail1">제품 이름</label> 
					<input type="text"
						class="form-control">
			

				</div>
				<div class="form-group">
					 <label for="exampleInputEmail1">제품 카테고리</label> 
					<div class="form-row">
				
							<div class="col">
								<select class="custom-select">


								</select>
							</div>
							<div class="col">
								 <select class="custom-select">


								</select>
							</div>
					</div>
				</div>
				
				<div class="form-group">
					<label for="exampleInputEmail1">제품 대표 이미지</label> 
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04">
						<label class="custom-file-label" for="inputGroupFile04">Choose file</label>
					</div>
 					
				</div>

				<button type="submit" class="btn btn-primary">Submit</button>
			</form>

		</div>
	</div>
</div>