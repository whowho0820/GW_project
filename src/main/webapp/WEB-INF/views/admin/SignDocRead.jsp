<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>

<script src="/resources/assets/js/ckeditor/ckeditor.js"></script>
<link href="/resources/assets/css/sign.css" rel="stylesheet"/>
<script src="/resources/assets/css/sb-admin/bootstrap.min.js"></script>
<script src="/resources/assets/css/sb-admin/metisMenu.min.js"></script>
<script src="/resources/assets/css/sb-admin/sb-admin-2.js"></script>

<script>
function fn_sign(){
    $("#popupUser").modal("show");
    
}

function fn_signSave(){
	if (confirm("결재 하시겠습니까?")) {
		$("#dialogForm").submit();
	}	
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

    <div id="wrapper">			
<%--         <div id="page-wrapper">            
            <c:set value="0" var="cnt"/>   --%>          
            <div class="row" style="margin-bottom: 10px">
				<div id="signPath" class="signPath">
					<c:forEach var="signlist" items="${signlist}" varStatus="status">
					    <c:if test="${signlist.sstype ne '1'}">					
							<div class="signArea">
								<div class="signAreaTop"><c:out value="${signlist.userpos}"/></div>
									<div class="signAreaCenter">
										<c:choose>
								        	<c:when test='${signlist.ssresult == "1"}'>승인</c:when>
								        	<c:when test='${signlist.ssresult == "2"}'>반려</c:when>
								         	<c:otherwise></c:otherwise>
								      	</c:choose>								
									</div>
								<div class="signAreaBottom"><c:out value="${signlist.usernm}"/> </div>
							</div>
						</c:if>
					    <c:if test="${signlist.sstype eq '1'}">
							<c:set var="cnt" value="${cnt + 1}" />		
						</c:if>
					</c:forEach>				
				</div>
				<div class="signTitle"><br>결<br><br>재</div>
			</div>			            
		    <c:if test="${cnt>0}"> 
	            <div class="row" style="margin-bottom: 10px">
					<div id="signPath4Agree" class="signPath">
						<c:forEach var="signlist" items="${signlist}" varStatus="status">
						    <c:if test="${signlist.sstype eq '1'}">					
								<div class="signArea">
									<div class="signAreaTop"><c:out value="${signlist.userpos}"/></div>
										<div class="signAreaCenter">
											<c:choose>
									        	<c:when test='${signlist.ssresult == "1"}'>승인</c:when>
									        	<c:when test='${signlist.ssresult == "2"}'>반려</c:when>
									         	<c:otherwise></c:otherwise>
									      	</c:choose>								
										</div>
									<div class="signAreaBottom"><c:out value="${signlist.usernm}"/> </div>
								</div>
							</c:if>
						</c:forEach>				
					</div>
					<div class="signTitle"><br>합<br><br>의</div>
				</div>
			</c:if>     
			       
            <!-- /.row -->
            <div class="row">
				<div class="panel panel-default">
					<div class="panel-heading">
                        <c:out value="${signDocInfo.doctitle}"/>
					</div>
	                <div class="panel-body">
	                	<c:out value="${signDocInfo.doccontents}" escapeXml="false"/>
	                </div>
                </div>
                <button class="btn btn-outline btn-primary" onclick="history.back(-1)" ><s:message code="common.btnList"/></button>
                <c:if test='${signDocInfo.userno==sessionScope.userno and signDocInfo.docstatus<=1}' >		
                	<button class="btn btn-outline btn-primary" onclick="fn_moveToURL('signDocDelete?docno=<c:out value="${signDocInfo.docno}"/>', '<s:message code="common.btnDelete"/>')" ><s:message code="common.btnDelete"/></button>
                	<button class="btn btn-outline btn-primary" onclick="fn_moveToURL('signDocCancel?docno=<c:out value="${signDocInfo.docno}"/>', '회수')" >회수</button>
                	<button class="btn btn-outline btn-primary" onclick="fn_moveToURL('signDocForm?docno=<c:out value="${signDocInfo.docno}"/>')" ><s:message code="common.btnUpdate"/></button>
                </c:if>
                <c:if test='${signer==sessionScope.userno}' >		
                	<button class="btn btn-outline btn-primary" onclick="fn_sign()" >결재승인</button>
                </c:if>
            </div>
            <!-- /.row -->
            
            <!-- /.row -->
            <div class="row guStyle2"> 
					<div class="listHead">
						<div class="listHiddenField pull-left field60"><s:message code="board.no"/></div>
						<div class="listHiddenField pull-left field100">결재자</div>
						<div class="listHiddenField pull-left field100">결재일자</div>
						<div class="listTitle">의견</div>
					</div>
					
					<c:forEach var="signlist" items="${signlist}" varStatus="status">
					    <c:if test="${signlist.sstype ne '0'}">					
							<div class="listBody">
								<div class="listHiddenField pull-left field60 textCenter"><c:out value="${status.index}"/></div>
								<div class="listHiddenField pull-left field100 textCenter"><c:out value="${signlist.usernm}"/></div>
								<div class="listHiddenField pull-left field100 textCenter"><c:out value="${signlist.signdate}"/></div>
								<div class="listTitle" title="<c:out value="${listview.sscomment}"/>">
									<c:out value="${signlist.sscomment}"/>
								</div>
							</div> 
						</c:if>
					</c:forEach>	
            	</div>    
        </div>
        <!-- /#page-wrapper --> 

    </div>
    <!-- /#wrapper -->
    
	<div id="popupUser" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">결재</h4>
                </div>
                <div class="modal-body" id="myModalBody">
                	<form id="dialogForm" name="dialogForm" role="form" action="signSave" method="post" >
	            		<input type="hidden" name="docno" value="<c:out value="${signDocInfo.docno}"/>">
			            <!-- /.row -->
			            <div class="row">
			            	<div class="col-lg-2" ></div> 
			            	<div class="col-lg-10" >
							 	<label><input name="ssresult" id="ssresult" type="radio" checked="checked" value="1">승인</label>
							 	<label><input name="ssresult" id="ssresult" type="radio" value="2">반려</label>
			                </div> 
			            </div> 
			            <div class="row">  
			            	<label class="col-lg-2">의견</label>
			            	<div class="col-lg-10" >
			            		<textarea class="form-control" id="sscomment" name="sscomment" rows="4"></textarea>
			                </div> 
			            </div> 
	            		<!-- /.row -->
            		</form>
				</div>
                <div class="modal-footer">
                	<button class="btn btn-outline btn-primary" onclick="fn_signSave()" >등록</button>
                </div>
            </div>
            <!-- /.modal-content --> 
        </div>
        <!-- /.modal-dialog -->		

	

<%@ include file="../adminInclude/footer.jsp"%>
