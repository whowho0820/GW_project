<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../adminInclude/header.jsp"%>

<style>
	.smallFont {
		font-size: 30px;
	}
	
	.quickBtn:hover {
		font-weight: 700;
	}
	
	@media screen and (max-width : 920px) {
		.quickBtn {
			font-size: 15px;
		}
		
		.tCenter {
			font-size: 50px;
		}
		
		.smallFont {
			font-size: 20px;
		}
	}
</style>

<script>
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);
google.charts.setOnLoadCallback(drawCurveTypes);

function drawBasic() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', '월');
      data.addColumn('number', '등록카페수');

      data.addRows([
        ['${charts[2][0].month}월', ${charts[2][0].cafe_cnt}], 
        ['${charts[1][0].month}월', ${charts[1][0].cafe_cnt}], 
        ['${charts[0][0].month}월', ${charts[0][0].cafe_cnt}]
      ]);

      var options = {
    	width: '100%',
        hAxis: {
          title: '카페 등록 현황'
        },
        vAxis: {
          title: '등록수',
          viewWindow: {
        	  min : 0
          }
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_div1'));

      chart.draw(data, options);
    }

function drawCurveTypes() {
	var chartData = "${reviewCht[0][0]}";
	
    var data = new google.visualization.DataTable();
    data.addColumn('string', '월');
    data.addColumn('number', '탐방기');
    data.addColumn('number', '추천글');

    data.addRows([
      ['${reviewCht[2][0].month}월', ${reviewCht[2][0].cnt}, ${recomCht[2][0].cnt}],    
      ['${reviewCht[1][0].month}월', ${reviewCht[1][0].cnt}, ${recomCht[1][0].cnt}],   
      ['${reviewCht[0][0].month}월', ${reviewCht[0][0].cnt}, ${recomCht[0][0].cnt}]
    ]);

    var options = {
	  width: '100%',
      hAxis: {
        title: '탐방기, 추천글 현황'
      },
      vAxis: {
        title: '등록수',
        viewWindow: {
        	min: 0
        }
      },
      series: {
        1: {curveType: 'function'}
      }
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div2'));
    chart.draw(data, options);
  }
    
    
$(function(){	
    $(window).resize(function(){
    	drawBasic();
    	drawCurveTypes();
    })
})
</script>

	<!--content area start-->
	<div id="content" class="pmd-content content-area dashboard">
	
		<div class="container-fluid">
			<div class="row" id="card-masonry">
			 
			 <!-- 신규 현황 start -->
			 <div class="col-lg-4 col-sm-4 col-xs-12">
			 	<div class="pmd-card pmd-z-depth">
			 		<div class="pmd-card-title"><a href="${pageContext.request.contextPath}/admin/cafeMgn/newCafeManager" class="quickBtn">결재받을 문서 ></a></div>
			 		<div class="pmd-card-body pmd-display3 tCenter">${cafeWaitingCnt} <span class="smallFont">건</span></div>
			 	</div>
			 </div>		
			 <div class="col-lg-4 col-sm-4 col-xs-12">
			 	<div class="pmd-card pmd-z-depth">
			 		<div class="pmd-card-title"><a href="${pageContext.request.contextPath}/admin/boardMgr/cafeReviewMgr" class="quickBtn">신규 게시글 ></a></div>
			 		<div class="pmd-card-body pmd-display3 tCenter">${todayCafeReviewCnt } <span class="smallFont">건</span></div>
			 	</div>
			 </div>		
			 <div class="col-lg-4 col-sm-4 col-xs-12">
			 	<div class="pmd-card pmd-z-depth">
			 		<div class="pmd-card-title"><a href="${pageContext.request.contextPath}/admin/noticeMgr/gwcalendarMgr" class="quickBtn">신규 일정 ></a></div>
			 		<div class="pmd-card-body pmd-display3 tCenter">${todayRecommendCnt} <span class="smallFont">건</span></div>
			 	</div>
			 </div>	
			 <!-- 신규 현황 end -->	
			 
			 <!-- 그래프 start -->
			 <div class="col-xs-12 col-sm-12 col-md-6">
			 	<div class="pmd-card pmd-z-depth">			 	
				 	<div class="pmd-card-title">자가검진 갯수 그래프</div>
				 	<div class="pmd-card-body">
				 		<div id="chart_div1"></div>
				 	</div>
			 	</div>
			 </div>
			 <div class="col-xs-12 col-sm-12 col-md-6">
			 	<div class="pmd-card pmd-z-depth">
				 	<div class="pmd-card-title">공지사항,자유게시판 갯수 그래프</div>
				 	<div class="pmd-card-body">
				 		<div id="chart_div2"></div>
				 	</div>
			 	</div>
			 </div>
			 <!-- 그래프 end  -->
		</div>
	</div>
	
	</div><!--end content area-->
	
<%@ include file="../adminInclude/footer.jsp"%>