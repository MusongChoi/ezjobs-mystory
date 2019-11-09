<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ include file="/WEB-INF/jspf/head.jspf"%>
<style>
[data-toggle="collapse"]:after {
	display: inline-block;
	font: normal normal normal 14px/1 FontAwesome;
	font-size: inherit;
	text-rendering: auto;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	content: "\f054";
	transform: rotate(90deg);
	transition: all linear 0.25s;
	float: right;
}

[data-toggle="collapse"].collapsed:after {
	transform: rotate(0deg);
}
</style>
<nav aria-label="breadcrumb">
	<div class="nav nav-tabs breadcrumb pb-0" id="nav-tab" role="tablist">
		<a class="nav-item nav-link breadcrumb-item active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab"
			aria-controls="nav-home" aria-selected="true">자소서관리</a>
		<a class="nav-item nav-link breadcrumb-item" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" 
			aria-controls="nav-profile" aria-selected="false">자소서작성</a> 
		<a class="nav-item nav-link breadcrumb-item" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab"
			aria-controls="nav-contact" aria-selected="false">자소서검토</a>
		<a class="nav-item nav-link breadcrumb-item" id="resume-create" href="#">
			새 자기소개서
		</a>
	</div>
</nav>
<div class="tab-content" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		<div class="container-fluid row">
			<div class="col-3 pl-2 pr-0">
				<input type="text" class="form-control" id="exampleInput" placeholder="Enter text">
			</div>
			<div class="col-6 px-3">
				<div id="accordion1" role="tablist">
					<%@ include file="/WEB-INF/jsp/resume/list.jsp"%>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		<div class="container-fluid row">
			<div class="col-3 pl-2 pr-0">
				<input type="text" class="form-control" id="exampleInput" placeholder="Enter text">
			</div>
			<div class="col-6 px-3">
				<div id="accordion2" role="tablist">
				</div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
	<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
		<div class="container-fluid row">
			<div class="col-3 pl-2 pr-0">
				<input type="text" class="form-control" id="exampleInput" placeholder="Enter text">
			</div>
			<div id=resume-content class="col-6 px-3">
				<div id="accordion3" role="tablist">
				새 자기소개서
				</div>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
</div>
<script>
	/*
	$("#resume-group").delegate(".collapse", "show.bs.collapse", function() {
		$(this).load("/resume/list");
	})*/
	var resume_idx=1;
	var resume_new=1;
	$("#nav-tab").delegate("#resume-create", "click", function() {
		$frag = $(document.createDocumentFragment()).load("/resume/write",function(response){
			var $result=$(response);
			$result.find(".card-header")
		           .attr("id","heading-write"+resume_idx)
		           .find("a")
				   .attr("href","#collapse-write"+resume_idx)
				   .attr("aria-controls","collapse-write"+resume_idx)
				   .html("새 자기소개서 "+resume_new);
			$result.find(".collapse")
				   .attr("id","collapse-write"+resume_idx)
				   .attr("aria-labelledby","heading-write"+resume_idx)
				   .find(".write-question")
				   .attr("id","write-question"+resume_idx)
				   .val("새 자기소개서 "+resume_new);
			$result.appendTo("#accordion2");
			resume_idx+=1;
			resume_new+=1;
		});
		return false;
	})
	$("#accordion2").delegate(".write-question","propertychange change keyup paste input", function(e) {
		var currentVal = $(e.target).val();
		var id=$(e.target).attr("id").replace("write-question","");
		$("#heading-write"+id+" a").html(currentVal);
	});
	$("#accordion2").delegate("form","submit",function(e){
		var form=$(e.target).serializeJSON();
		//console.log(form);
		$.post("/resume/content",form,function(data){
			//console.log(data);
			$(e.target).find(".resume-id").val(data.id);
			$.get("/resume/content",function(data){
				console.log(data);
				$("#accordion1").html(data);
			});
		});
		return false;
		//$.post
	});
</script>
<%@ include file="/WEB-INF/jspf/footer.jspf"%>
