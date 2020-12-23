<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userInclude/header.jsp" %>

<style>
	/* 선택 검색 */
	.cafeReviewSearch {
		padding: 10px 0;
		padding-top: 20px;
	}

	.cafeReviewSearch .selectLeft {
		float: left;
	}
	
	.cafeReviewSearch .selectRight {
		float: right;
	}
	
	/* 탐방기 */
	.cafeReviewArea .cafeRCnt {
		font-weight: 400;
		font-size: 16px;
	}
	
	.cafeReviewArea .cafeR_titleWrap {
		padding: 10px 0;
	}
	
	.cafeReviewArea .cafeR_title {
		float: left;
	}
	
	.cafeReviewArea .cafeR_topBtns {
		float: right;
	}
	
	.cafeReviewArea .cafeR_topBtn {
		float: left;
		font-size: 14px;
	}
	
	.cafeReviewArea .cafeR_totalBtn {
		margin-right: 10px;
		padding: 7px 10px;
	}
	
	.cafeReviewArea .cafeR_add {
		padding: 7px 10px;
		border-radius: 10px;
	}
	
	.cafeReviewArea .cafeR_addBtn {
		color: #fff;
   		font-size: 14px;
	}
	
	.cafeReviewArea .cafeR_totalBtn:hover {
		border-color: #ED7D31;
	}
	
	.cafeReviewArea .cafeR_add:hover {
		background-color: #F46B45;	
	}
	
	.cafeReviewArea .a_cafeReview {
		display: block;
		float: left;
		width: 48.6%;
		border: 1px solid #545454;
		margin-bottom: 20px;
	}
	
	.cafeReviewArea .cafeR_box:hover .cafe_title{
		text-decoration: underline;
	}
	
	.cafeReviewArea .a_cafeReview:nth-of-type(odd) {
		margin-right: 20px;
	}
	
	.cafeReviewArea .cafeR_titleBox {
		height: 200px;
		padding: 15px 10px;
		position: relative;
		color: #fff;
	}
	
	.cafeReviewArea .cafeR_titleBox .cafeR_titleImg {
		position: absolute;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    z-index: -1;
	    overflow: hidden;
	}
	
	.cafeReviewArea .cafeR_titleBox .cafeR_titleImg .bg {
		width: 100%;
	    height: 100%;
	    position: absolute;
	    top: 0;
	    left: 0;
	    background: rgba(0,0,0,0.15);
	}
	
	.cafeReviewArea .cafeR_titleBox .cafeR_titleImg img {
		width: 100%;
    	min-height: 100%;
	}
	
	.cafeReviewArea .cafeR_writer {
		line-height: 50px;
		float: left;
	}
		
	.cafeReviewArea .cafeR_writer img {
		width: 50px;
		display: block;
		float: left;
		margin-right: 10px;
	}
	
	.cafeReviewArea .cafeR_writer span {
		display: block;
		float: left;
		color: #fff;
		font-size: 18px;
	}
	
	.cafeReviewArea .cafeR_recomCnt {
		float: right;
		width: 30px;
		height: 30px;
		border-radius: 40px;
		margin: 10px;
		text-align: center;
		line-height: 30px;
		font-weight: 700;
	}
	
	.cafeReviewArea .cafeR_titleBox h2 {
		position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 85%;
	    text-align: center;
	}
	
	.cafeReviewArea .cafeR_date {
		position: absolute;
	    top: 85%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 85%;
	    text-align: right;
	    font-size: 20px;
	}	
	
	.cafeReviewArea .cafeR_infoBox {
		padding: 10px;
		padding-bottom: 0;
	}
	
	.cafeReviewArea .cafeR_infoTop {
		padding-bottom: 10px;
	}
	
	.cafeReviewArea .cafeR_infoTop h2{
		text-align: right;
		padding: 10px 0;
	}
	
	.cafeReviewArea .cafeR_text {
		overflow: hidden; 
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 4; /* 라인수 */
		-webkit-box-orient: vertical;
		word-wrap: break-word;
	}
	
	.cafeReviewArea .cafeR_replyCdtWrap {
		float: right;
		padding: 10px;
		padding-right: 0;
	}
	
	.cafeReviewArea .cafeR_replyCdt .cafeR_btns {
		border: 1px solid #545454;
		padding: 5px 10px;
		border-radius: 10px;
		float: left;
		margin-right: 10px;
		line-height: 28px;
	}
	
	.cafeReviewArea .cafeR_replyCdt .cafeR_btns img {
		float: left;
		margin-right: 10px;
	}
	
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
	
	/* 테마 아이콘 */
	.cafeR_box .themeKeySmall {
		margin-right:0;
	}
	.btn {
	    width: auto;
	    min-width: 125px;
	    height: 2.667em;
	    padding: 0 1em;
	    font-size: 1em;
	    line-height: 2.5em;
	    text-align: center;
	    box-sizing: border-box;
	    white-space: nowrap;
	    outline: none;
	    border: 1px solid #555;
	    color: #555;
	    background-color: transparent;
	    overflow: hidden;
	    -webkit-transition: background-color .2s ease-in-out, -webkit-transform .3s ease-out;
	    -moz-transition: background .2s ease-in-out, -moz-transform .3s ease-out;
	    -ms-transition: background .2s ease-in-out, -ms-transform .3s ease-out;
	    -o-transition: background .2s ease-in-out, -o-transform .3s ease-out;
	    transition: background .2s ease-in-out, transform .3s ease-out;
	}
	a.btn {
	    display: inline-block;
	}
	.btn.radius20 {
	    border-radius: 1.333em;
	}
	.btn.shadow {
	    -webkit-box-shadow: 2px 2px 5px 0px rgba(0,0,0,0.14);
	    -moz-box-shadow: 2px 2px 5px 0px rgba(0,0,0,0.14);
	    box-shadow: 2px 2px 5px 0px rgba(0,0,0,0.14);
	}
	.btn.green {
	    border: 1px solid #00bf6f;
	    color: #fff;
	    background-color: #00bf6f;
	}
	
	.btn_group.margin > .btn {
	    margin: 0.2em;
	}
	.btn_group.margin >.btn:first-child {
	    margin-left: 0;
	}
	.btn_group.margin >.btn:last-child {
	    margin-right: 0;
	}	
</style>

	<!--content area start-->
	<div id="content" class="pmd-content inner-page">
	<!--tab start-->
	    <div class="container-fluid full-width-container value-added-detail-page">
			<div>				
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<span>자료실</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">자료실</li>
				</ol><!--breadcrum end-->
			</div>	
			
		 <div class="content subPageContent">
			<!-- 서브페이지 콘텐츠 -->
			<div class="contentArea">										
				
				
				<!-- 탐방기 -->
				<div class="cafeReviewArea">
					<div class="cafeR_titleWrap clearfix">				
						<h3 class="cafeR_title">오늘의 자료 | <span class="red cafeRCnt">${todayCnt}개</span></h3>
						<div class="cafeR_topBtns">
							<div class="cafeR_topBtn cafeR_totalBtn grayLineBtn">
								<a href="${pageContext.request.contextPath }/user/community/cafeReview?type=best" class="red bold btn radius20 shadow green">베스트 자료</a>
							</div>
							<div class="cafeR_topBtn cafeR_add navyBtn">
								<a href="#" class="cafeR_addBtn btn radius20 shadow green">자료 올리기</a>
							</div>						
						</div>
					</div>
					<!-- 선택 검색 -->
				<div class="cafeReviewSearch bottomLine2 clearfix">								
					<div class="selectRight">
						<select name="searchType" id="searchType">
							<option value="n" ${cri.searchType == null ? 'selected' : '' }>----</option>
							<option value="t" ${cri.searchType == 't' ? 'selected' : '' }>제목</option>
							<option value="c" ${cri.searchType == 'c' ? 'selected' : '' }>내용</option>
							<option value="tc" ${cri.searchType == 'tc' ? 'selected' : '' }>제목+내용</option>
							<option value="uId" ${cri.searchType == 'uId' ? 'selected' : '' }>회원아이디</option>
							<option value="uName" ${cri.searchType == 'uName' ? 'selected' : '' }>글쓴이</option>
						</select>
						<input type="hidden" name="boardType" value="1"/>
						<input type="text" name="keyword" id="keyword" value="${cri.keyword }" placeholder="검색어를 입력하세요." />
						<button type="button" class="navyBtn" id="btnSearch">검색</button>
					</div>
				</div>
					<div class="cafeR_list clearfix mb30">
						<!-- 탐방기 글 박스 -->
						<c:forEach var="item" items="${list }">
							<c:if test="${item.boardDelCdt == 'NO'}">
								<a href="${pageContext.request.contextPath }/user/community/cafeReview/read?boardNo=${item.boardNo}&page=${cri.page}&flag=true&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}" class="a_cafeReview">
									<div class="cafeR_box">
										<div class="cafeR_titleBox">
											<div class="cafeR_titleImg">	
												<div class="bg"></div>			
												<img class="titleImg" src="${pageContext.request.contextPath }/user/displayFile?filename=${item.files[0].imageName}" alt="카페대표이미지" onerror="this.src='${pageContext.request.contextPath}/resources/images/mm.jpg'"/>
											</div>
											<div class="cafeR_titleTop clearfix" >
												<div class="cafeR_writer clearfix">
													<img src="${pageContext.request.contextPath }/resources/images/${item.userNo.userGrade.userGradeImage }" alt="등급아이콘" />
													<span class="cafeR_name bold">${item.userNo.nick }</span>
													<span class="cafeR_id bold">(${item.userNo.userId })</span>
												</div>
												<div class="cafeR_recomCnt bgRed">${item.voteNumber }</div>						
											</div>
											<h2 class="classSec cafe_title">${item.writingTitle }</h2>
											<div class="cafeR_date bold"><fmt:formatDate value="${item.registrationDate }" pattern="yyyy/MM/dd"/></div>
										</div>
										<div class="cafeR_infoBox">
											<div class="cafeR_infoTop clearfix">
												<div class="zoneBtn zoneOrangeIconSmall">${item.cafeNo.zoneNo.zoneName }</div>
												<div class="themeKeySmall themeName">#${item.cafeNo.themeNo.themeName }</div>
												<!-- 테마 순위 리스트(순위테마 전체를 검색할 수 있을때 풀기) -->
												<c:forEach var="theme" items="${themeMap}" varStatus="status">
													<c:if test="${item.cafeNo.cafeNo == theme.key }">
														<c:forEach var="themeItem" items="${theme.value }">
															<div class="themeKeySmall themeName">#${themeItem.themeName }</div>
														</c:forEach>
													</c:if>
												</c:forEach>
												<h2>${item.cafeNo.cafeName }</h2>
											</div>
											<p class="cafeR_text">
												${item.writingContent }
											</p>
										</div>
										<div class="cafeR_replyCdt clearfix">
											<div class="cafeR_replyCdtWrap">
												<div class="cafeR_btns">
													<img src="${pageContext.request.contextPath }/resources/images/icon_reply.png" alt="icon" />
													<span class="cafeR_replyCnt">${item.replyCnt }</span>
												</div>
												<div class="cafeR_btns">
													<img src="${pageContext.request.contextPath }/resources/images/icon_view.png" alt="icon" />
													<span class="cafeR_viewCnt">${item.viewNumber }</span>
												</div>
											</div>
										</div>
									</div>
								</a>
							</c:if>
						</c:forEach>
						<!-- 탐방기 글 end -->
					</div>
				</div>
				<!-- 페이징 -->
				<div style="text-align: center;">
					<ul class="pagination">
						<c:if test="${pageMaker.prev == true }">
							<li><a href="cafeReview?page=${pageMaker.startPage-1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<li class="${pageMaker.cri.page == idx?'active':'' }"><a href="cafeReview?page=${idx }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">${idx }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next == true }">
							<li><a href="cafeReview?page=${pageMaker.endPage+1 }&searchZone=${cri.searchZone }&searchTheme=${cri.searchTheme }&searchType=${cri.searchType }&keyword=${cri.keyword}">&raquo;</a></li>
						</c:if>
					</ul>
				</div>	
				
			</div>
		</div>

		<!-- container end -->
		<script>
			// 타이틀 이미지 원본 넣기
			$(".titleImg").each(function(i, obj) {
				var file = $(this).attr("src");
				var s = file.indexOf("s_");
				var dir = file.substring(0, s);
				var fileName = file.substring(s+2, file.length);
				$(this).attr("src", dir+fileName);
				console.log(fileName);
			})
			
			// 테마분류 색상 설정
			$(".themeName").each(function(i, obj){
				var name = $(this).text();
				var keywordK = ["#데이트", "#뷰", "#착한아메", "#디저트", "#댕댕이", "#작업"];
				var keyword = ["date", "view", "ame", "dessert", "dog", "work"];
				
				for(var i=0; i<keyword.length; i++){
					if(name.indexOf(keywordK[i]) > -1) {
						$(this).addClass(keyword[i]);
					}
				}
				
			})
			
			// 검색
			$("#btnSearch").click(function () {
				var bestType = location.href;
			
				var searchZone = $("#searchZone").val();
				var searchTheme = $("#searchTheme").val();
				var searchType = $("#searchType").val();
				var keyword = $("#keyword").val();
				if(bestType.indexOf("best") == -1){
					location.href = "cafeReview?boardType=1&searchZone="+searchZone+"&searchTheme="+searchTheme+"&searchType="+searchType+"&keyword="+keyword;
				} else {
					location.href = "cafeReview?type=best&boardType=1&searchZone="+searchZone+"&searchTheme="+searchTheme+"&searchType="+searchType+"&keyword="+keyword;			
				}
			})
			
			// 베스트 월 표시
			var nowMonth = new Date().getMonth() + 1;
			var preMonth = nowMonth - 1;
			
			$(".preMonth").text(preMonth);
			
			// 탐방기 등록 시 로그인 여부 확인
			$(".cafeR_addBtn").click(function() {		
				var auth = "${Auth}";
				if(auth == "") {
					loginShow();
					return false;
				}
				
				location.href = "${pageContext.request.contextPath }/user/community/cafeReview/register";
			})
		</script> 
		</div>
	</div>
<%@ include file="../userInclude/footer.jsp" %>