<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>
<link href="/resources/assets/js/datepicker/datepicker.css" rel="stylesheet">
<link href="/resources/assets/js/datepicker/bootstrap-datepicker.js" rel="stylesheet">

	<!--content area start-->
	<div id="content" class="pmd-content inner-page">
	<!--tab start-->
	    <div class="container-fluid full-width-container value-added-detail-page">
			<div>
				<%-- <div class="pull-right table-title-top-action">
					<div class="pmd-textfield pull-left">
					  <input type="text" id="exampleInputAmount" class="form-control" value="${cri.keyword }" placeholder="카페 점주 ID 검색" name="keyword" >
					</div>
					<a href="#" id="searchBtn" class="btn btn-primary pmd-btn-raised add-btn pmd-ripple-effect pull-left">Search</a>
				</div> --%>
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<i class="fa fa-sitemap fa-fw "></i> <span>일정추가</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">일정추가</li>
				</ol><!--breadcrum end-->
			</div> 
            
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="schSave" method="post" onsubmit="return fn_formSubmit();" >
            		<input type="hidden" name="ssno" value="<c:out value="${schInfo.ssno}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-1">일정명</label>
	                            <div class="col-lg-8"><c:out value="${schInfo.sstitle}"/></div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">구분</label>
	                            <div class="col-lg-8"><c:out value="${schInfo.sstype}"/></div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">일시</label>
	                            <div class="col-lg-8"> 
	                            	<c:out value="${schInfo.ssstartdate}"/> <c:out value="${schInfo.ssstarthour}"/>:<c:out value="${schInfo.ssstartminute}"/>
	                             ~
	                             	<c:out value="${schInfo.ssenddate}"/> <c:out value="${schInfo.ssendhour}"/>:<c:out value="${schInfo.ssendminute}"/>
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">반복</label>
	                            <div class="col-lg-8"><c:out value="${schInfo.ssrepeattype}"/></div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">공개</label>
	                            <div class="col-lg-8"><c:out value="${schInfo.ssisopen}"/></div>
	                        </div> 
	                    	<div class="row form-group">
	                            <label class="col-lg-1">내용</label>
	                            <div class="col-lg-8"><c:out value="${schInfo.sscontents}"/></div>
	                        </div>
	                    </div> 
	                </div>
			        <button class="btn btn-outline btn-primary"><s:message code="common.btnSave"/></button>
				</form>	
                
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

<%@ include file="../adminInclude/footer.jsp"%>
