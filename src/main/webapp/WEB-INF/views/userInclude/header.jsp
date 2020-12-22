<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마음:TACT - user</title>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>

<!-- Google icon -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- Bootstrap css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Propeller css -->
<!-- build:[href] assets/css/ -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/assets/css/propeller.min.css">
<!-- /build -->

<!-- Propeller date time picker css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/components/datetimepicker/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/components/datetimepicker/css/pmd-datetimepicker.css" />

<!-- Propeller theme css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/themes/css/propeller-theme.css" />

<!-- Propeller admin theme css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/themes/css/propeller-admin.css">

<!-- adminCommon css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/adminCommon.css" />
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

<!-- 구글 차트 api -->
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<!-- 메뉴 포커스 -->
<script>
	$(function(){
		var url = location.href.split("/");
		$(".menu").removeClass("active");
		
		var menu = url[5];
		var subMenu = url[6];
		
		// 서브메뉴 url 판단
		//console.log("url[5]"+menu);
		//console.log("url[6]"+subMenu);
		
		// 메뉴 포커스 
		if(menu == "") {
			$("#Dashboard").addClass("active");
		}
		
		if(menu == "cafeMgn"){
			$("#cafeMgr").addClass("active");
			$("#cafeMgr").parent().addClass("open");
		}
		
		if(menu == "userMgr") {
			$("#userMgr").addClass("active");
			$("#userMgr").parent().addClass("open");
		}
		
		if(menu == "boardMgr") {
			$("#boardMgr").addClass("active");
			$("#boardMgr").parent().addClass("open");
		}
		
		if(menu == "noticeMgr") {
			$("#noticeMgr").addClass("active");
			$("#noticeMgr").parent().addClass("open");
		}
				
		// 서브메뉴 포커스
		if(subMenu != null) {
			if(subMenu.indexOf("newCafeManager") != -1){				
				$(".cafeMgrSub").eq(0).addClass("active");
			} 
			if(subMenu.indexOf("cafeManager") != -1) {
				$(".cafeMgrSub").eq(1).addClass("active");
			} 
			if(subMenu.indexOf("monthCafeManager") != -1) {
				$(".cafeMgrSub").eq(2).addClass("active");
			} 
			if(subMenu.indexOf("monthCafeManager2") != -1) {
				$(".cafeMgrSub").eq(3).addClass("active");
			} 
			if(subMenu.indexOf("cafeUserManager") != -1) {
				$(".userMgrSub").eq(0).addClass("active");
			} 
			if(subMenu.indexOf("userManager") != -1) {
				$(".userMgrSub").eq(1).addClass("active");
			}
			if(subMenu.indexOf("adminManager") != -1) {
				$(".userMgrSub").eq(2).addClass("active");
			}
			if(subMenu.indexOf("cafeReviewMgr") != -1) {
				$(".boardMgrSub").eq(0).addClass("active");
			}
			if(subMenu.indexOf("cafeRecomMgr") != -1) {
				$(".boardMgrSub").eq(1).addClass("active");
			}
			if(subMenu.indexOf("noticeMgr") != -1) {
				$(".boardMgrSub").eq(2).addClass("active");
			}
			if(subMenu.indexOf("gwcalendarMgr") != -1) {
				$(".calendarMgrSub").eq(0).addClass("active");
			}
			if(subMenu.indexOf("gwcalendarMgr2") != -1) {
				$(".calendarMgrSub").eq(0).addClass("active");
			}		
		}
	})
</script>

<style>
	.inputRegi{
		width: 325px;
	    height: 30px;
	    margin-bottom: 15px;
	    padding: 5px;
	    border: 1px solid #949494;
	}
	.inputRegi1{
		width: 240px;
	    height: 30px;
	    margin-bottom: 15px;
	    padding: 5px;
	    border: 1px solid #949494;
	}
	input::-webkit-input-placeholder {
		color:#949494;
	}
	.chgColorSpan{
		color:#949494;
	}
	.btnCheck{
		height: 42px;
	    width: 80px;
	    border: 1px;
	    background: #303A50;
	    color: white;
	}
	span.hotPlace{
		color: white;
		background: #FF007F;
		border-radius: 5px;
		padding: 0 8px;
		letter-spacing: 2px;
		font-size: 12px;
		margin-left: 8px;	
	}
	.checkbox, .radio {
	    position: relative;
	    display: block;
	    margin-top: 10px;
	    margin-bottom: 10px;
        margin-right: 250px;
	}
</style>
</head>
<body>
	<!-- Header Starts -->
	<!--Start Nav bar -->
	<nav class="navbar navbar-inverse navbar-fixed-top pmd-navbar pmd-z-depth">
	
		<div class="container-fluid">
			<div class="pmd-navbar-right-icon pull-right navigation">
				<!-- Notifications -->
	            <div class="dropdown notification icons pmd-dropdown">
				
					<a id="user" href="javascript:void(0)" title="Notification" class="dropdown-toggle pmd-ripple-effect"  data-toggle="dropdown" role="button" aria-expanded="true">
						<div class="material-icons md-light pmd-sm pmd-badge pmd-badge-overlap">
							<img src="${pageContext.request.contextPath }/resources/themes/images/user-icon.png" alt="New User" />
							<span id="userName" href="${pageContext.request.contextPath }/user/mypage?userId=${userId}">${Auth}</span>
						</div>
					</a>
									
					<div class="dropdown-menu dropdown-menu-right pmd-card pmd-card-default pmd-z-depth" role="menu">
						
						<!-- Notifications list -->
						<ul class="list-group pmd-list-avatar pmd-card-list">
							<li class="list-group-item unread">
								<a href="#">내정보 수정</a>
							</li>
							<li class="list-group-item unread">
								<a href="${pageContext.request.contextPath }/user/">나가기</a>
							</li>
							<li class="list-group-item unread">
								<a href="${pageContext.request.contextPath }/user/logout">로그아웃</a>
							</li>
						</ul><!-- End notifications list -->	
					</div>
					
					
	            </div> <!-- End notifications -->
			</div>
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<a href="javascript:void(0);" id="navIcon" data-target="basicSidebar" data-placement="left" data-position="slidepush" is-open="true" is-open-width="1200" class="btn btn-sm pmd-btn-fab pmd-btn-flat pmd-ripple-effect pull-left margin-r8 pmd-sidebar-toggle"><i class="fas fa-bars fs25"></i></a>	
				<a href="${pageContext.request.contextPath }/admin/" class="navbar-brand">마음:TACT</a>
			</div>
		</div>
	
	</nav><!--End Nav bar -->
	<!-- Header Ends -->

	<!-- Sidebar Starts -->
	<div class="pmd-sidebar-overlay"></div>
	
	<!-- Left sidebar -->
	<aside id="basicSidebar" class="pmd-sidebar  sidebar-default pmd-sidebar-slide-push pmd-sidebar-left pmd-sidebar-open bg-fill-darkblue sidebar-with-icons" role="navigation">
		<ul class="nav pmd-sidebar-nav">
			
			<!-- User info -->
			<li class="dropdown pmd-dropdown pmd-user-info visible-xs visible-md visible-sm visible-lg">
				<a aria-expanded="false" data-toggle="dropdown" class="btn-user dropdown-toggle media" data-sidebar="true" aria-expandedhref="javascript:void(0);">
					<div class="media-left">
						<img src="${pageContext.request.contextPath }/resources/themes/images/user-icon.png" alt="New User">
					</div>
					<div class="media-body media-middle" href="${pageContext.request.contextPath }/user/mypage?userId=${userId}">${Auth}</div>					
					<div class="media-right media-middle"><i class="dic-more-vert dic"></i></div>
				</a>
				<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath }/user/logout">Logout</a></li>
				</ul>
			</li><!-- End user info -->
			
			<li> 
				<a id="Dashboard" class="pmd-ripple-effect menu" href="${pageContext.request.contextPath }/user/userpg">	
				<i class="fas fa-tachometer-alt fs18 media-left media-middle" ></i>
				<span class="media-body">프로그램 개요</span>
				</a> 
			</li>
			
			<li class="dropdown pmd-dropdown"> 
				<a id="cafeMgr" aria-expanded="false" data-toggle="dropdown" class="btn-user dropdown-toggle media menu" data-sidebar="true" href="javascript:void(0);">	
					<i class="fas fa-store fs18 media-left media-middle"></i>
					<span class="media-body">점검하기</span>
					<div class="media-right media-bottom"><i class="dic-more-vert dic"></i></div>
				</a> 
				<ul class="dropdown-menu">
					<li><a class="cafeMgrSub menu" href="${pageContext.request.contextPath}/user/mukkaCafe">자가검진</a></li>
					<li><a class="cafeMgrSub menu" href="${pageContext.request.contextPath}/user/mukkaCafe/zone">생애주기별</a></li>
					<li><a class="cafeMgrSub menu" href="${pageContext.request.contextPath}/user/mukkaCafe/theme">증상별</a></li>
					<%-- <li><a class="cafeMgrSub menu" href="${pageContext.request.contextPath}/user/community">베스트</a></li> --%>
				</ul>
			</li>
			<li class="dropdown pmd-dropdown"> 
				<a id="userMgr" aria-expanded="false" data-toggle="dropdown" class="btn-user dropdown-toggle media menu" data-sidebar="true" href="javascript:void(0);">	
					<i class="fas fa-users fs18 media-left media-middle"></i>
					<span class="media-body">커뮤니티</span>
					<div class="media-right media-bottom"><i class="dic-more-vert dic"></i></div>
				</a> 
				<ul class="dropdown-menu">
					<li><a class="userMgrSub menu" href="${pageContext.request.contextPath}/user/community">공지사항</a></li>
					<li><a class="userMgrSub menu" href="${pageContext.request.contextPath}/user/community/cafeRecommend">자유게시판</a></li>
					<li><a class="userMgrSub menu" href="${pageContext.request.contextPath}/user/community/cafeReview">자료실</a></li>
				</ul>
			</li>
<%-- 			<li class="dropdown pmd-dropdown"> 
				<a id="boardMgr" aria-expanded="false" data-toggle="dropdown" class="btn-user dropdown-toggle media menu" data-sidebar="true" href="javascript:void(0);">	
					<i class="fas fa-chalkboard fs18 media-left media-middle"></i>
					<span class="media-body">게시글</span>
					<div class="media-right media-bottom"><i class="dic-more-vert dic"></i></div>
				</a> 
				<ul class="dropdown-menu">
					<li><a class="boardMgrSub menu" href="${pageContext.request.contextPath}/user/community/cafeReview">자료실</a></li>
					<li><a class="boardMgrSub menu" href="${pageContext.request.contextPath}/admin/boardMgr/cafeRecomMgr">자유게시판</a></li>
					<li><a class="boardMgrSub menu" href="${pageContext.request.contextPath}/admin/boardMgr/noticeMgr">공지사항</a></li>					
				</ul>
			</li> --%>
						
			<li class="dropdown pmd-dropdown"> 
				<a id="noticeMgr" aria-expanded="false" data-toggle="dropdown" class="btn-user dropdown-toggle media menu" data-sidebar="true" href="javascript:void(0);">	
					<i class="fas fa-bullhorn fs18 media-left media-middle"></i>
					<span class="media-body">일정</span>
					<div class="media-right media-bottom"><i class="dic-more-vert dic"></i></div>
				</a> 
				<ul class="dropdown-menu">
					<li><a class="calendarMgrSub menu" href="${pageContext.request.contextPath}/admin/noticeMgr/gwcalendarMgr">전체 일정</a></li>
					<li><a class="calendarMgrSub menu" href="${pageContext.request.contextPath}/admin/noticeMgr/gwcalendarMgr2">일정 리스트</a></li>
				</ul>
			</li>
			<li> 
				<a class="pmd-ripple-effect" href="${pageContext.request.contextPath }/user/">	
					<i class="fas fa-door-open fs18 media-left media-middle"></i>
					<span class="media-body">나가기</span>
				</a> 
			</li>
			<li> 
				<a class="pmd-ripple-effect" href="${pageContext.request.contextPath }/user/logout">	
					<i class="fas fa-sign-out-alt fs18 media-left media-middle"></i>
					<span class="media-body">Login</span>
				</a> 
			</li>
	
		</ul>
	</aside><!-- End Left sidebar -->
	<!-- Sidebar Ends -->	
