<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../userInclude/header.jsp" %>

<!-- 별점 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/w3.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/fontawesome-stars.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.barrating.min.js"></script>

<!-- user css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/userCommon.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/userHeaderFooterMenu.css" />

<script>
	$(function(){
		/* main 페이지 searchBox 오픈 */
		var url = location.href.split("/");
		
		//영업중으로 등록된 카페 총 개수
		var cafeAllInfo = "${cafeAllInfo}";
		//등록된 탐방기 총 개수
		var cafeReviewAllCnt = "${cafeReviewAllCnt}";				
		
		if(url[4] == "") {
			$(".mainSearchBox").addClass("close");
			$(".mainSearchBtn a").html('<span class="cafeSearchBtn">검색 닫기</span> <i class="fas fa-angle-up"></i>');
			$(".activeTotalCnt").html('현재 <span class="actTotal">'+cafeAllInfo+'</span>개의 <b class="blue">정보</b>와 <span class="actTotal">'+cafeReviewAllCnt+'</span>개의 <b class="blue">탐방기</b>가 있습니다.');
		} else {
			$(".mainSearchBox").addClass("open");
			$(".mainSearchBtn a").html('<span class="cafeSearchBtn">검색 열기</span> <i class="fas fa-angle-down"></i>');
			$(".activeTotalCnt").empty();
		}
		
		/* searchBox 슬라이드 */
		$(".mainSearchBtn a").click(function(e){
			e.preventDefault();
			
			if($(".mainSearchBox").hasClass("open")) {
				$(".mainSearchBox").slideUp();
				$(".mainSearchBox").removeClass("open");
				$(this).html('<span class="cafeSearchBtn">검색 열기</span> <i class="fas fa-angle-down"></i>');
			} else {
				$(".mainSearchBox").slideDown();
				$(".mainSearchBox").addClass("open");
				$(this).html('<span class="cafeSearchBtn">검색 닫기</span> <i class="fas fa-angle-up"></i>');
			}
		})
		/* 지역 리스트 */
		$(".zoneBarBox").click(function() {
			$(".zoneList").slideToggle();
		})
		
		$(".zoneList li").click(function(){
			var zone = $(this).attr("data-zone");
			var zoneNo = $(this).attr("data-zoneNo");
			
			$(".zoneTitle").text(zone).css("color", "black");
			$(".zoneBar input[name='zoneName']").val(zoneNo);
			$(".zoneList").slideUp(300);
		})
		/* 테마 */
		var keywords = "";
		
		$(".keys li").click(function(){
			var keyword = $(this).attr("data-keyword");
			var themeNo = $(this).attr("data-themeNo");
			var key = $(this).attr("data-key");
			var $spanThemeKey = $("<span>").addClass("themeKey").addClass(key).text("#" + keyword);
			
			var onImg = $(this).attr("data-onImg");
			var img = $(this).attr("data-img")
			var imgPath = "${pageContext.request.contextPath }/resources/images/";
			
			if($(this).hasClass("on")){
				$(this).removeClass("on");
				$(this).find(".keyIcon img").attr("src", imgPath+img);
				
				keywords = keywords.replace(themeNo+",", "");
				$("."+key).remove();
			} else {				
				$(this).addClass("on");
				$(this).find(".keyIcon img").attr("src", imgPath+onImg);
				keywords += themeNo + ",";
				$(".themeBarBox").append($spanThemeKey);
			}
			
			if($(".themeBarBox").find(".themeKey").length == 0) {
				$(".themeSapn").show();
			} else {
				$(".themeSapn").hide();
			}
			$(".themeBar input[name='themeName']").val(keywords);
			
		})
		
		$("#mainMenuUl > li").hover(function(){
			$(this).find(".subMenuUl").stop().slideDown();
		}, function(){
			$(this).find(".subMenuUl").stop().slideUp();
		})
		
		/* 메인 카페 검색 */
		$("#sendBtn").click(function(){
			var zoneNo = $("#zone").val() == "" ? 0 : $("#zone").val();
			var themeNos = $("input[name='themeName']").val();
			
			if(zoneNo == 0 && themeNos == "") {
				alert("자가검진 유형을 선택해주세요.");
				return false;
			}
			
			location.href = "${pageContext.request.contextPath}/user/mukkaCafe/search?zoneNo="+zoneNo+"&themeNos="+themeNos+"&searchTheme=";
			
			return false;
		})	
	})
</script>

	<!--content area start-->
	<div id="content" class="pmd-content inner-page">
	<!--tab start-->
	    <div class="container-fluid full-width-container value-added-detail-page">
			<div>				
				<!-- Title -->
				<h1 class="section-title subPageTitle" id="services">
					<span>자가검진</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">자가검진</li>
				</ol><!--breadcrum end-->
			</div>
			
			<!-- searchBox start -->
			<div class="mainSearchBox">
				<div class="mainSearch">
					<div class="keysWrap">
						<ul class="keys">
							<li data-keyword="성격유형" data-themeNo="1" data-key="date" data-onImg="key1_1.png" data-Img="key1.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key1.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText">
									<span class="keyword blue">#성격유형</span>자가검진
								</div>
							</li>
							<li data-keyword="사랑유형" data-themeNo="2" data-key="view" data-onImg="key2_2.png" data-Img="key2.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key2.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText">
									<span class="keyword blue">#사랑유형</span>자가검진
								</div>
							</li>
							<li data-keyword="스트레스" data-themeNo="3" data-key="ame" data-onImg="key3_3.png" data-Img="key3.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key3.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText">
									<span class="keyword blue">#스트레스</span>자가검진
								</div>
							</li>
							<li data-keyword="우울" data-themeNo="4" data-key="dessert" data-onImg="key4_4.png" data-Img="key4.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key4.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText ">
									<span class="keyword blue">#우울</span>자가검진
								</div>
							</li>
							<li data-keyword="불안" data-themeNo="5" data-key="dog" data-onImg="key5_5.png" data-Img="key5.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key5.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText">
									<span class="keyword blue">#불안</span>자가검진
								</div>
							</li>
							<li data-keyword="자살" data-themeNo="6" data-key="work" data-onImg="key6_6.png" data-Img="key6.png">
								<div class="keyIcon keyItem">
									<img src="${pageContext.request.contextPath }/resources/images/key6.png" alt="keyIcon" />
								</div>
								<div class="spot keyItem"></div>
								<div class="keyText">
									<span class="keyword blue">#자살</span>자가검진
								</div>
							</li>
						</ul>
						<div class="line"></div>
					</div>
					<div class="searchBarWrap clearfix">
						<div class="zoneBar bar">
							<input type="hidden" name="zoneName" id="zone"/>
							<div class="zoneBarBox barBox">
								<img src="${pageContext.request.contextPath }/resources/images/point.png" alt="icon" />
								<span class="zoneTitle">위치별 추천</span>
							</div>							
							<div class="zoneList" style="z-index: 9;">
								<ul>
									<c:forEach var="zone" items="${zoneList }">
										<li class="zoneItem" data-zoneNo="${zone.zoneNo }" data-zone="${zone.zoneName }">
											<img src="${pageContext.request.contextPath }/resources/images/point.png" alt="icon" />
											<c:if test="${zone.zoneNo < 6}">
												<span class="zoneName"><b>${zone.zoneName } <span class="hotPlace">HOT</span></b></span>
											</c:if>
											<c:if test="${zone.zoneNo > 5}">
												<span class="zoneName">${zone.zoneName }</span>
											</c:if>			
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="themeBar bar">
							<input type="hidden" name="themeName"/>
							<div class="themeBarBox barBox">
								<img src="${pageContext.request.contextPath }/resources/images/bar_search.png" alt="icon" />
								<span class="themeSapn">나의 마음건강은?</span>
							</div>	
						</div>
						<div class="searchBtn">
							<a id="sendBtn" href="#">
								<img src="${pageContext.request.contextPath }/resources/images/main_search.png" alt="searchIcon" />
							</a>
						</div>
					</div>
				</div>
			</div>
			<!-- searchBox end -->
		</div>
	</div>


<%@ include file="../userInclude/footer.jsp" %>