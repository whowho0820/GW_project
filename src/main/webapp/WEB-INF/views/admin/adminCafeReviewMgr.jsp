<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<%@ include file="../adminInclude/header.jsp"%>

<style>
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
					  <input type="text" id="exampleInputAmount" class="form-control" value="${cri.keyword }" placeholder="카페이름 검색" name="keyword" >
					</div> 
					<a href="#" id="searchBtn" class="btn btn-primary pmd-btn-raised add-btn pmd-ripple-effect pull-left">Search</a>
				</div>
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<span>자료실 관리</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">자료실 관리</li>
				</ol><!--breadcrum end-->
			</div>
<!-- Table -->
			<div class="table-responsive pmd-card pmd-z-depth">
				<table class="table table-mc-red pmd-table">
					<thead>
						<tr>
							<th>no</th>
							<th>카페명</th>
							<th>점주명</th>
							<th>사업자등록번호</th>
							<th>카페등록일자</th>
							<th>운영여부</th>
							<th>카페정보상세</th>
							<th>카페관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${list }">
							<tr>
								<td>${item.cafeNo }</td>
								<td>${item.cafeName}</td>
								<td>${item.userNo.name }</td>
								<td>${item.ownerLicenseNo }</td>
								<td><fmt:formatDate value="${item.registrationDate}" pattern="yyyy/MM/dd"/></td>	
								<td>
									<c:if test="${item.cafeCdt == 'OPEN'}">
										<strong style="color:#259b24;">영업중</strong>
									</c:if>
									<c:if test="${item.cafeCdt == 'CLOSING'}">
										<strong style="color:#ff5722;">폐업</strong>
									</c:if>
								</td>
								<td><a class="btn pmd-btn-outline" href="${pageContext.request.contextPath}/user/mukkaCafe/zone/read?cafeNo=${item.cafeNo}" target="_blank">상세보기</a></td>
								<td>
									<c:if test="${item.cafeCdt == 'OPEN'}">
										<button class="btn pmd-btn-outline btn-danger closingBtn" data-cafeName="${item.cafeName }" data-cafeNo="${item.cafeNo}">폐업등록</button>
									</c:if>
									<c:if test="${item.cafeCdt == 'CLOSING'}">
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
				  <!-- 페이징 숫자 버튼 자리 -->
				  <!-- ex1 : cafeReview?page=${pageMaker.startPage-1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword} -->
				  <!-- ex2 : <li class="${pageMaker.cri.page == idx?'active':'' }"><a href="cafeReview?page=${idx }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">${idx }</a></li> -->
				  <!-- ex3 : cafeReview?page=${pageMaker.endPage+1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword} -->
				  	<c:if test="${pageMaker.prev == true }">
						<li><a href="cafeManager?page=${pageMaker.startPage-1}&keyword=${cri.keyword}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
						<li class="${pageMaker.cri.page == idx?'active':'' }"><a href="cafeManager?page=${idx}&keyword=${cri.keyword}">${idx }</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true }">
						<li><a href="cafeManager?page=${pageMaker.endPage+1}&keyword=${cri.keyword}">&raquo;</a></li>
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
			alert("카페이름을 작성해주세요.");
			return false;
		}
		
		location.href = "cafeManager?keyword="+keyword;
		
		return false;
	})
	
	$(".closingBtn").click(function(){
		var cafeName = $(this).attr("data-cafeName");
		var cafeNo = $(this).attr("data-cafeNo");
		var res = confirm("["+cafeName+"]를 폐업등록 하시겠습니까?");
		
		if(res == true) {
			location.href = "${pageContext.request.contextPath}/admin/cafeMgn/cafeManager/modify?cafeNo="+cafeNo+"&cafeCdt=2&page=${cri.page}&keyword=${cri.keyword}";
		} 
		
		return false;
	})
</script>

<%@ include file="../adminInclude/footer.jsp"%>