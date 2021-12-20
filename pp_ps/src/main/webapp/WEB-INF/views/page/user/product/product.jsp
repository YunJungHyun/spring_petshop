<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page">
	<div class="row">
		<div class="col-6 product-img-box-2">
			<img id="img-${pvo.pid }" />
			<script>
							
			var pimgStr = JSON.stringify(${pvo.pimg});
			var pimgJSON = JSON.parse(pimgStr);
			var path =pimgJSON.img.path;
			var fileName = pimgJSON.img.fileName;
							
			$("#img-${pvo.pid}").attr("src" ,path+"/"+fileName);
			</script>
		</div>

		<div class="col-6 px-4 py-4">
			<p>${pvo.pname }</p>
		</div>
	</div>
	<div>
	
	</div>
</div>
