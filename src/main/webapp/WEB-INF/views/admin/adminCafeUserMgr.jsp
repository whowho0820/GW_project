<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>


<link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet"/>
<link href="/resources/assets/css/metisMenu.min.css" rel="stylesheet"/>
<link href="/resources/assets/css/sb-admin-2.css" rel="stylesheet"/>
<link href="/resources/assets/css/sb-admin/font-awesome.min.css" rel="stylesheet" type="text/css"/>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->


<script src="/resources/assets/js/jquery-2.2.3.min.js"></script>
<script src="/resources/assets/js/jquery-ui.js"></script>
<script src="/resources/assets/js/bootstrap.min.js"></script>
<script src="/resources/assets/js/metisMenu.min.js"></script>
<script src="/resources/assets/js/sb-admin-2.js"></script>

<script src="/resources/assets/js/dynatree/jquery.dynatree.js"></script>
<link href="/resources/assets/js/dynatree/ui.dynatree.css" rel="stylesheet"/>

<script src="/resources/assets/js/project9.js"></script>  

<script>
var selectedNode = null;

$(function(){
	$("#tree").dynatree({
		children: <c:out value="${treeStr}" escapeXml="false"/>,
		onActivate: TreenodeActivate
	});
    $("#tree").dynatree("getRoot").visit(function(node){
        node.expand(true);
    });
	fn_groupNew();
});
function TreenodeActivate(node) {
	selectedNode = node;
	
    if (selectedNode==null || selectedNode.data.key==0) return;
    $.ajax({
    	url: "adDepartmentRead",
    	cache: false,
    	data: { deptno : selectedNode.data.key }    	
    }).done(receiveData);
}

function receiveData(data){
    $("#deptno").val(data.deptno);
    $("#deptnm").val(data.deptnm);
}

function fn_groupNew(){
    $("#deptno").val("");
    $("#deptnm").val("");
}

function fn_groupDelete(value){
    if (selectedNode==null){
    	alert("<s:message code="msg.err.boardDelete"/>");
    	return;
    }
    if (selectedNode.childList){
    	alert("<s:message code="msg.err.boardDelete4Child"/>");
    	return;
    }
    
    if(!confirm("<s:message code="ask.Delete"/>")) return;
    $.ajax({
    	url: "adDepartmentDelete",
    	cache: false,
    	data: { deptno : selectedNode.data.key }    	
    }).done(receiveData4Delete);
}

function receiveData4Delete(data){
	alert("<s:message code="msg.boardDelete"/>");
	selectedNode.remove();		
	selectedNode = null;
	fn_groupNew();
}

function fn_groupSave(){
	if ( ! chkInputValue("#deptnm", "<s:message code="common.deptName"/>")) return;

	var pid=null;
    if (selectedNode!=null) pid=selectedNode.data.key;

    if (!confirm("<s:message code="ask.Save"/>")) return;

    $.ajax({
    	url: "adDepartmentSave",
    	cache: false,
    	type: "POST",
    	data: { deptno:$("#deptno").val(), deptnm:$("#deptnm").val(), parentno: pid}    	
    }).done(receiveData4Save);
}

function receiveData4Save(data){
	if (selectedNode!==null && selectedNode.data.key===data.deptno) {
		selectedNode.data.title=data.deptnm;
		selectedNode.render();
	} else {
		addNode(data.deptno, data.deptnm);
	}
	
	alert("<s:message code="msg.boardSave"/>");
}

function addNode(nodeNo, nodeTitle){
	var node = $("#tree").dynatree("getActiveNode");
	if (!node) node = $("#tree").dynatree("getRoot");
	var childNode = node.addChild({key: nodeNo, title: nodeTitle});
	node.expand() ;
	node.data.isFolder=true;
	node.tree.redraw();
}
</script>    

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
					<i class="fa fa-sitemap fa-fw "></i> <span>부서 관리</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">부서 관리</li>
				</ol><!--breadcrum end-->
			</div>
			
			<!-- /.row -->
            <div class="row">
            	<div class="panel panel-default col-lg-3" >
                    <div style="max-height:400px; overflow:auto;" >
				    	<div id="tree">
						</div>
					</div>
				</div>
                 
            	<div class="panel panel-default col-lg-6" >
                    <div class="panel-body">
			            <div class="row form-group">
			             <%--	<button class="btn btn-outline btn-primary" onclick="fn_groupNew()" ><s:message code="board.append"/></button> --%>
						</div>
					
						<input name="deptno" id="deptno" type="hidden" value=""> 
						
			            <div class="row form-group">		          
			            	<label class="col-lg-3" ><s:message code="common.deptName"/></label>
			            	<div class="col-lg-9" >
				 				<input name="deptnm" id="deptnm" style="width: 300px;" type="text" maxlength="100" value="" class="form-control">
			            	</div>
						</div>

			            <div class="row form-group">			           
			            	<button class="btn pmd-btn-outline pmd-btn-raised add-btn pmd-ripple-effect pull-left" onclick="fn_groupSave()" ><s:message code="common.btnSave"/></button>
			            	<button class="btn pmd-btn-outline pmd-btn-raised add-btn pmd-ripple-effect pull-left" onclick="fn_groupDelete()" ><s:message code="common.btnDelete"/></button>
						</div>
				    </div>    
				</div>	
            </div>
            <!-- /.row -->
			
		</div>
	</div>


<%@ include file="../adminInclude/footer.jsp"%>