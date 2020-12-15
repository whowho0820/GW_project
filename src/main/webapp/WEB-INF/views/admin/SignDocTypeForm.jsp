<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>

<script src="/resources/assets/js/ckeditor/ckeditor.js"></script>

<script>
window.onload =function() {
	  CKEDITOR.replace( 'dtcontents', { 'filebrowserUploadUrl': 'upload4ckeditor'});
}	  

function fn_formSubmit(){
	CKEDITOR.instances["dtcontents"].updateElement();
	
	if ( ! chkInputValue("#dttitle", "문서양식명")) return false;
	
	$("#form1").submit();
} 
</script>

	<!--content area start-->
	<div id="content" class="pmd-content inner-page">
	<!--tab start-->
	    <div class="container-fluid full-width-container value-added-detail-page">
			<div>
				<div class="pull-right table-title-top-action">
					<%-- <div class="pmd-textfield pull-left">
					  <input type="text" id="exampleInputAmount" class="form-control" value="${cri.keyword }" placeholder="카페이름 검색" name="keyword" >
					</div>
					<a href="#" id="searchBtn" class="btn btn-primary pmd-btn-raised add-btn pmd-ripple-effect pull-left">Search</a> --%>
				</div>
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<i class="fa fa-edit fa-fw"></i><span>결재문서양식</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">결재문서양식</li>
				</ol><!--breadcrum end-->
			</div>
            
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="adSignDocTypeSave" method="post">
            		<input type="hidden" name="dtno" value="<c:out value="${signInfo.dtno}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-2">문서양식명</label>
	                            <div class="col-lg-8">
	                            	<input type="text" class="form-control" id="dttitle" name="dttitle" maxlength="255" 
	                            	value="<c:out value="${signInfo.dttitle}"/>">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-2">문서양식내용</label>
	                            <div class="col-lg-8">
	                            	<textarea class="form-control" id="dtcontents" name="dtcontents"><c:out value="${signInfo.dtcontents}"/></textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
				</form>	
			        <button class="btn btn-outline btn-primary" onclick="fn_formSubmit();"><s:message code="common.btnSave"/></button>
			        <c:if test="${signInfo.dtno!=null}">
			        	<button class="btn btn-outline btn-primary" onclick="fn_moveToURL('adSignDocTypeDelete?dtno=<c:out value="${signInfo.dtno}"/>', '<s:message code="common.btnDelete"/>')" ><s:message code="common.btnDelete"/></button>
			        </c:if>
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<%@ include file="../adminInclude/footer.jsp"%>