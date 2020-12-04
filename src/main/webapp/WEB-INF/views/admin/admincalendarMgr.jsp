<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../adminInclude/header.jsp"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캘린더 관리</title>
<script src="/resources/assets/js/jquery-3.1.1.min.js"></script>
<script src="/resources/assets/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/assets/css/bootstrap-theme.min.css">
<script type="text/javascript" src='/resources/assets/js/sweetalert.min.js?ver=1'></script>
<link rel="stylesheet" type="text/css" href='/resources/assets/css/sweetalert.css?ver=1.2'>

<script type="text/javascript" src="/resources/js/calendarList.js"></script>
</head>
<body>
    <form action="./calendarRemove.do" method="post" id="frmCalendarRemove">
        <table class="table table-bordered">
            <tr>
                <th><input type='checkbox' onclick='checkAllDel(this.checked)' />전체</th>
                <th>캘린더이름</th>
                <th>캘린더코드</th>
            </tr>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td><input type='checkbox' name='chkVal' value="${item.id}" /></td>
                    <td><input type="hidden" name='summarys' value="${item.summary}" />
                        <a href="./schdule.do?calendarId=${item.id}&title=${item.summary}">${item.summary}</a>
                    </td>
                    <td>${item.id}</td>
                </tr>
            </c:forEach>
        </table>
    </form>
    <input type="button" class='btn btn-sm btn-warning' value="캘린더 생성" onclick="calendarAddForm()" />
    <input type="button" class='btn btn-sm btn-warning' value="캘린더 수정" onclick="calendarModifyForm()" />
    <input type="button" class='btn btn-sm btn-warning' value="캘린더 삭제" onclick="calendarRemove()" />
    <!-- 캘린더 생성 modal -->
    <div class="modal fade" id="calendarAddForm" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">캘린더 생성</h4>
                </div>
                <div class="modal-body">
                    <!-- 캘린더 생성처리 form -->
                    <form action="./calendarAdd.do" method='post' id='frmCalendarAdd'>
                        <div class='form-group'>
                            <label>캘린더이름</label><input class='form-control' type="text" name='summary' id='summary' />
                        </div>
                        <div class='modal-footer'>
                            <input type="button" class='btn btn-sm btn-warning' value="확인" onclick="calendarAdd()" />
                            <input type="reset"  class='btn btn-sm btn-warning' value="초기화" /> 
                            <input type='button' class='btn btn-sm btn-warning' data-dismiss='modal' value="취소" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 캘린더 수정 modal -->
    <div class="modal fade" id="calendarModifyForm" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">캘린더 수정</h4>
                </div>
                <div class="modal-body">
                    <!-- 캘린더 생성처리 form -->
                    <form action="./calendarModify.do" method='post' id='frmCalendarModify'>
                        <div class='form-group'>
                            <label>캘린더이름</label><input class='form-control' type="text" name='summary' id='summaryModify' />
                        </div>
                        <input type="hidden" name="calendarId" id='calendarIdModify' />
                        <div class='modal-footer'>
                            <input type="button" class='btn btn-sm btn-warning' value="확인" onclick="calendarModify()" /> 
                                <input type="reset" class='btn btn-sm btn-warning' value="초기화" /> 
                                <input type='button' class='btn btn-sm btn-warning' data-dismiss='modal' value="취소" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%-- <style>
	/* 페이징 */
	.pagination {
		display: inline-block;
	  	padding-left: 0;
	  	margin: 20px 0;
	  	border-radius: 4px;
	}
	.pagination > li {
  		display: inline;
	}
	.pagination > li > a,
	.pagination > li > span {
		position: relative;
		float: left;
		padding: 6px 12px;
		margin-left: -1px;
		line-height: 1.42857143;
		color: #303A50;
		text-decoration: none;
		background-color: #fff;
		border: 1px solid #ddd;
	}
	.pagination > li:first-child > a,
	.pagination > li:first-child > span {
		margin-left: 0;
		border-top-left-radius: 4px;
		border-bottom-left-radius: 4px;
	}
	.pagination > li:last-child > a,
	.pagination > li:last-child > span {
		border-top-right-radius: 4px;
		border-bottom-right-radius: 4px;
	}
	.pagination > li > a:hover,
	.pagination > li > span:hover,
	.pagination > li > a:focus,
	.pagination > li > span:focus {
		color: #23527c;
		background-color: #eee;
		border-color: #ddd;
	}
	.pagination > .active > a,
	.pagination > .active > span,
	.pagination > .active > a:hover,
	.pagination > .active > span:hover,
	.pagination > .active > a:focus,
	.pagination > .active > span:focus {
		z-index: 2;
		color: #fff;
		cursor: default;
		background-color: #303A50;
		border-color: #303A50;
	}
	.pagination > .disabled > span,
	.pagination > .disabled > span:hover,
	.pagination > .disabled > span:focus,
	.pagination > .disabled > a,
	.pagination > .disabled > a:hover,
	.pagination > .disabled > a:focus {
		color: #777;
		cursor: not-allowed;
		background-color: #fff;
		border-color: #ddd;
	}
	.pagination-lg > li > a,
	.pagination-lg > li > span {
		padding: 10px 16px;
		font-size: 18px;
	}
	.pagination-lg > li:first-child > a,
	.pagination-lg > li:first-child > span {
		border-top-left-radius: 6px;
		border-bottom-left-radius: 6px;
	}
	.pagination-lg > li:last-child > a,
	.pagination-lg > li:last-child > span {
		border-top-right-radius: 6px;
		border-bottom-right-radius: 6px;
	}
	.pagination-sm > li > a,
	.pagination-sm > li > span {
		padding: 5px 10px;
		font-size: 12px;
	}
	.pagination-sm > li:first-child > a,
	.pagination-sm > li:first-child > span {
       border-top-left-radius: 3px;
	   border-bottom-left-radius: 3px;
	}
	.pagination-sm > li:last-child > a,
	.pagination-sm > li:last-child > span {
		border-top-right-radius: 3px;
		border-bottom-right-radius: 3px;
	}
	
	/* best list */
	.bestBoardBox table td,
	.bestBoardBox table th {
		border: none;
	}
</style>
	<!--content area start-->
	<div id="content" class="pmd-content inner-page">
	<!--tab start-->
	    <div class="container-fluid full-width-container value-added-detail-page">
			<div>
				<div class="pull-right table-title-top-action">
					<div class="pmd-textfield pull-left">
					  <input type="text" id="exampleInputAmount" class="form-control" value="${cri.keyword }" placeholder="공지사항 검색" name="keyword" >
					</div>
					<a href="#" id="searchBtn" class="btn pmd-btn-outline pmd-btn-raised add-btn pmd-ripple-effect pull-left">Search</a>
				</div>
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<span>일정 관리</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">일정 관리</li>
				</ol><!--breadcrum end-->
			</div>
			<!-- Table -->
			<div class="table-responsive pmd-card pmd-z-depth">
				<table class="table table-mc-red pmd-table">
					<thead>
						<tr>
							<th>no</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
							<th>비공개(삭제)여부</th>
							<th>상세보기</th>
							<th>게시관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list }">
							<tr>
								<td>${item.boardNo }</td>
								<td>${item.writingTitle }</td>
								<td>${item.userNo.nick }[${item.userNo.userId}]</td>
								<td><fmt:formatDate value="${item.registrationDate }" pattern="yyyy/MM/dd"/></td>
								<td><fmt:formatDate value="${item.updateDate }" pattern="yyyy/MM/dd"/></td>
								<td>${item.boardDelCdt}</td>
								<td>
									<a class="btn pmd-btn-outline" href="${pageContext.request.contextPath}/user/community/cafeRecommend/read?boardNo=${item.boardNo }" target="_blank">상세보기</a>
								</td>
								<td>
									<c:if test="${item.boardDelCdt == 'NO'}">
										<button class="btn pmd-btn-outline btn-danger closingBtn">비공개(삭제) 전환</button>
									</c:if>
									<c:if test="${item.boardDelCdt == 'YES'}">
										<button class="btn pmd-btn-outline btn-warning closingBtn">공개 전환</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
				</tbody>
			</table>
			</div>
			<!-- 페이징 -->
			<div style="text-align: center;">
			  	<ul class="pagination list-inline taCenter">
				  <c:if test="${pageMaker.prev == true }">
						<li><a href="cafeRecomMgr?page=${pageMaker.startPage-1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li class="${pageMaker.cri.page == idx?'active':'' }"><a href="cafeRecomMgr?page=${idx }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">${idx }</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true }">
						<li><a href="cafeRecomMgr?page=${pageMaker.endPage+1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">&raquo;</a></li>
					</c:if>
			  	</ul>
			</div>
			<!-- 페이징 end -->
		</div>
	</div>
	<!--tab start-->
	
	<!--content area end-->

<script>
	$("#searchBtn").click(function(){
		var keyword = $("input[name='keyword']").val();
		
		if(keyword == '') {
			alert("일정사항 번호를 작성해주세요.");
			return false;
		}
		
		location.href = "calendarMgr?keyword="+keyword;
		
		return false;
	})
</script> --%>
<%@ include file="../adminInclude/footer.jsp"%>