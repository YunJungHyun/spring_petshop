<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<div class="page">
	<div class="container">
		<div class="page-emptied-admin"></div>
		<div class="page-contents d-flex flex-column justify-content-center ">
		
			<div class="prod-list-header d-flex flex-row justify-content-between">
				<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
					<div class="btn-group mr-2" role="group" aria-label="First group">
						<button type="button" class="btn btn-secondary" data-target="#prod-insert-modal" data-toggle="modal">제품 등록</button>
						
					</div>
					<div class="btn-group mr-2" role="group" aria-label="Second group">
						<button type="button" class="btn btn-secondary" data-target="#category-insert-modal" data-toggle="modal">카테고리 등록</button>
					</div>
				</div>
				<div class="nav-right admin-shop-search-form  d-flex justify-content-end">
					<div class="input-group shop-search-group">
						<input type="text" class="form-control shop-search-form-control" placeholder="상품 검색" aria-label="Input group example" aria-describedby="btnGroupAddon">
						<div class="input-group-prepend shop-search-group-text-box">
							<div class="input-group-text shop-search-group-text" id="btnGroupAddon"><i class="fas fa-search"></i></div>
						</div>
 			 		</div>
 	 			</div>
 	 			
 	 			 
			</div>
			
			<div class="prod-list-body d-flex flex-column my-4">
				
				<div class="prod-list-oneLine">
					<div class="prod-list-content d-flex flex-row">
						<div class="prod-list-img-box col-sm-4">
							
						</div>
						<div class="prod-list-info-box">
					
						</div>
					</div>
				</div>
				
			</div>		
	
		</div>
	</div>
</div>  


<!-- Modal -->
<div class="modal fade " id="prod-insert-modal" tabindex="-1" role="dialog" aria-labelledby="prodInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
	<div class="modal-content">
		<div class="modal-header">
		<h5 class="modal-title" id="prodInsertModalLabel">제품 등록</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		</div>
		<div class="modal-body">
      	<select class="custom-select">
			<option selected>제품 종류</option>
			<option value="1">One</option>
			<option value="2">Two</option>
			<option value="3">Three</option>
		</select>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		</div>
	</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade " id="category-insert-modal" tabindex="-1" role="dialog" aria-labelledby="categoryInsertModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content">
		<div class="modal-header">
		<h5 class="modal-title" id="categoryInsertModalLabel">카테고리 등록</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		</div>
		<div class="modal-body"> 
      	<select class="custom-select">
			<option selected>제품 종류</option>
			<option value="1">One</option>
			<option value="2">Two</option>
			<option value="3">Three</option>
		</select>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		</div>
	</div>
	</div>
</div>