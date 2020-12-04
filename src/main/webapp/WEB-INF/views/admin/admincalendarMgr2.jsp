<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../adminInclude/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일정관리</title>
<script src="/resources/assets/js/jquery-3.1.1.min.js"></script>
<script src="/resources/assets/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/assets/css/bootstrap-theme.min.css">
<script type="text/javascript" src='/resources/assets/js/sweetalert.min.js?ver=1'></script>
<link rel="stylesheet" type="text/css" href='/resources/assets/css/sweetalert.css?ver=1.2'>

<script type="text/javascript" src="/resources/js/stringBuffer.js"></script>
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript" src="/resources/js/calendarSchdule.js"></script>
<style type="text/css">
thead {
    text-align: center;
}
thead td {
    width: 100px;
}
#tbody td {
    height: 150px;
}
#yearMonth {
    font: bold;
    font-size: 18px;
}
</style>
</head>
<body>
    <input type="hidden" id="chk" value="0" />
    <input type="hidden" id="calendarId" value="${calendarId}" />
    <table class="table table-bordered">
        <thead id='thead'>
            <tr>
                <td colspan="7">
                    <button type='button' class='btn btn-sm btn-warning' id='moveFastPre' onclick="moveFastMonthPre()">«</button>
					<button type='button' class='btn btn-sm btn-warning' id='movePre' onclick="moveMonthPre()">‹</button>   
                    <span id='yearMonth'></span>   
                    <button type='button' class='btn btn-sm btn-warning' id='moveNext' onclick="moveMonthNext()">›</button>  
                    <button type='button' class='btn btn-sm btn-warning' id='moveFastNext' onclick="moveFastMonthNext()">»</button>
                    <div style="text-align: right;">
                        <span>${title}</span> <input class='btn btn-sm btn-info' type="button" value="주" onclick='tabWeek()' /> 
                            <input class='btn btn-sm btn-info' type="button" value="월" onclick='tabMonth()' /> 
                            <input class='btn btn-sm btn-info' type="button" value="목록" onclick='location.href="./coding.do"' />
                    </div>
                </td>
            </tr>
            <tr>
                <td>일<span class='week'></span></td>
                <td>월<span class='week'></span></td>
                <td>화<span class='week'></span></td>
                <td>수<span class='week'></span></td>
                <td>목<span class='week'></span></td>
                <td>금<span class='week'></span></td>
                <td>토<span class='week'></span></td>
            </tr>
        </thead>
        <tbody id='tbody'></tbody>
    </table>
    <!-- 일정 생성 modal -->
    <div class="modal fade" id="schduleForm" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">일정등록</h4>
                </div>
                <div class="modal-body">
                    <form class='form-margin40' role='form' action="#" method='post' id='frmSchdule'>
                        <div class='form-group'>
                            <label>제목</label> 
                            <input type='text' class='form-control' id='summary' name='summary' placeholder="예: 오후 7시에 멕시코 음식점에서 저녁식사">
                        </div>
                        <div class='form-group'>
                            <label>시작시간</label> 
                            <input class='form-control' type="time" id='startTime' name='startTime'>
                        </div>
                        <div class='form-group'>
                            <label>시작날짜</label> 
                            <input class='form-control startDate' type="date" id='startDate' name='startDate' readonly="readonly">
                        </div>
                        <div class='form-group'>
                            <label>종료시간</label> 
                            <input class='form-control' type="time" id='endTime' name='endTime'>
                        </div>
                        <div class='form-group'>
                            <label>종료날짜</label> 
                            <input class='form-control startDate' type="date" id='endDate' name='endDate'>
                        </div>
                        <div class='form-group'>
                            <label>내용</label>
                            <textarea rows="7" class='form-control' id="description" name='description'></textarea>
                        </div>
                        <div class='modal-footer'>
                            <input type="button" class='btn btn-sm btn-warning' value="확인" onclick="calendarSchduleAdd()" /> 
                            <input type="reset"  class='btn btn-sm btn-warning' value="초기화" /> 
                            <input type='button' class='btn btn-sm btn-warning' data-dismiss='modal' value="취소" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 일정 수정 modal -->
    <div class="modal fade" id="schduleFormModify" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">일정수정</h4>
                </div>
                <div class="modal-body">
                    <form class='form-margin40' role='form' action="#" method='post' id='frmSchduleModify'>
                        <div class='form-group'>
                            <label>제목</label> <input type='text' class='form-control' id='modifySummary' name='summary'>
                        </div>
                        <div class='form-group'>
                            <label>내용</label>
                            <textarea rows="7" class='form-control' id="modifyDescription" name='description'></textarea>
                        </div>
                        <input type="hidden" id="modifyEventId" name="eventId" /> 
                        <input type="hidden" name="calendarId" value="${calendarId}" />
                        <div class='modal-footer'>
                            <input type="button" class='btn btn-sm btn-warning' value="확인" onclick="modifyEvent()" /> 
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
					<span>일정관리2</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">일정관리2</li>
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
			alert("공지사항 번호를 작성해주세요.");
			return false;
		}
		
		location.href = "calendarMgr2?keyword="+keyword;
		
		return false;
	})
</script> --%>
<%@ include file="../adminInclude/footer.jsp"%>