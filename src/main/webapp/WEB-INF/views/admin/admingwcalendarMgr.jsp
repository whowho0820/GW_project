<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>
<link href="/resources/assets/css/index.css" rel="stylesheet">
<script>
function fn_moveDate(date){
    $.ajax({
        url: "moveDate",
        type:"post", 
        data : {date: date},
        success: function(result){
            $("#calenDiv").html(result);
            calcCalenderHeight();
        }
    })
}
 
// responsive week calendar
function myFunction(x) {
    if (x.matches) { // max-width: 450px
		var columnSelected = $("#weekDiv").children(".columnSelected");
		if (columnSelected.length===0) { // 반응형 시작
			var today = $("#weekDiv .today");
			if (today.length > 0) {  // 오늘이 있으면
				//today = today.parent();
				today.addClass( "columnSelected" );
				if (today.next().hasClass("calendarColumn")) { // 토요일(한주의 마지막)이 아니면
					today.next().addClass( "columnSelected" );
				}else {
					today.prev().addClass( "columnSelected" );
				}
			} else {				// 오늘이 없으면 일/월요일 
				var ch = $("#weekDiv").children(".calendarColumn").first();
				ch.addClass( "columnSelected" );
				ch.next().addClass( "columnSelected" );
			}
		}
	}
}

window.onload = function () {
	var x = window.matchMedia("(max-width: 450px)")
	x.addListener(myFunction) 
	myFunction(x);
	
	calcCalenderHeight();
}

function calcCalenderHeight() {
	var calendars = $(".calendarColumn .panel-body");
	var max = 0;
	calendars.each(function() {
		var h = parseInt($(this).css("height"));
		if (h > max) max = h; 
	});
	if (max<180) max=180; 
	calendars.each(function() { 
		$(this).css("height", max+"px");
	}); 
}

function ev_prevSlide() {
	var columnSelected = $("#weekDiv").children(".columnSelected");
	var node = columnSelected.first().prev();
	if (!node || !node.hasClass("calendarColumn")) return;
	
	node.addClass( "columnSelected" );
	if (node.prev().length===0) {
		$(".calenSlideButton_left").hide();
	}
	$(".calenSlideButton_right").show();

	columnSelected.last().removeClass( "columnSelected" );
}

function ev_nextSlide() {
	var columnSelected = $("#weekDiv").children(".columnSelected");
	var node = columnSelected.last().next();
	if (!node || !node.hasClass("calendarColumn")) return;
	
	node.addClass( "columnSelected" );

	if (!node.next().hasClass("calendarColumn")) {
		$(".calenSlideButton_right").hide();
	}
	$(".calenSlideButton_left").show();

	columnSelected.first().removeClass( "columnSelected" );
}

var oldno = null;
function calendarDayMouseover(event, ssno, cddate){
	if (!ssno) {
		return;
	}
	
	$(".calendarTooltip").css({left: event.x+"px", top: event.y+"px"});
	$(".calendarTooltip").show();
	if (oldno===ssno) return;
	oldno=ssno;
    $.ajax({
    	url: "schRead4Ajax",
    	cache: false,
    	data: { ssno : ssno, cddate:cddate },
	    success: function(result){
	    	$(".calendarTooltip").html(result);
		}    
    });	
}

function calendarDayMouseout(){
	$(".calendarTooltip").hide();
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
					<i class="fa fa-sitemap fa-fw "></i> <span>전체 일정</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">전체 일정</li>
				</ol><!--breadcrum end-->
			</div>
        	
        	<div class="col-lg-2">
	         	<button class="btn btn-outline btn-primary" style="margin-top:20px;" onclick="fn_moveToURL('schForm', '')" >일정추가</button>
		    </div>
		    
            <div id="calenDiv" class="row">
                <jsp:include page="indexCalen.jsp" />
            </div>
          </div>
       </div>            

<%@ include file="../adminInclude/footer.jsp"%>