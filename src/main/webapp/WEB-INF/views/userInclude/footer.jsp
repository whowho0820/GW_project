<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Footer Starts -->
<!--footer start-->
<footer class="admin-footer">
	<div class="container-fluid">
		<ul class="list-unstyled list-inline">
			<li style="height: 38px">
				<span class="pmd-card-subtitle-text">Coffee Mukka &copy;<span class="auto-update-year"></span>. All Rights Reserved.</span>
			</li>
		</ul>
	</div>
</footer>
<!--footer end-->
	<!-- Footer Ends -->
	
	<!-- Scripts Starts -->
	<script>
		$(document).ready(function() {
			var sPath=window.location.pathname;
			var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
			$(".pmd-sidebar-nav").each(function(){
				$(this).find("a[href='"+sPage+"']").parents(".dropdown").addClass("open");
				$(this).find("a[href='"+sPage+"']").parents(".dropdown").find('.dropdown-menu').css("display", "block");
				$(this).find("a[href='"+sPage+"']").parents(".dropdown").find('a.dropdown-toggle').addClass("active");
				$(this).find("a[href='"+sPage+"']").addClass("active");
			});
		});
	</script>
	<script type="text/javascript">
	(function() {
	  "use strict";
	  var toggles = document.querySelectorAll(".c-hamburger");
	  for (var i = toggles.length - 1; i >= 0; i--) {
	    var toggle = toggles[i];
	    toggleHandler(toggle);
	  };
	  function toggleHandler(toggle) {
	    toggle.addEventListener( "click", function(e) {
	      e.preventDefault();
	      (this.classList.contains("is-active") === true) ? this.classList.remove("is-active") : this.classList.add("is-active");
	    });
	  }
	
	})();
	</script>
	
	<script src="${pageContext.request.contextPath }/resources/assets/js/propeller.min.js"></script> 
	
	<!-- Javascript for revenue progressbar animation effect-->
	<script>
		function progress(percent, $element) {
			var progressBarWidth = percent * $element.width() / 100;
			$element.find('.progress-bar').animate({ width: progressBarWidth }, 500);
		} 
		
		progress(50, $('.cash-progressbar'));
		progress(30, $('.card-progressbar'));
		progress(60, $('.wallet-progressbar'));
		progress(40, $('.credit-progressbar'));
		progress(10, $('.other-progressbar'));
	</script>
	<!-- Javascript for revenue progressbar animation effect-->	
	
	
	<!--circle chart-->
	<script src="${pageContext.request.contextPath }/resources/themes/js/circles.min.js"></script>
	<script>
	  <!-- javascript for total sales chart-->
			var colors = [
				['#dfe3e7', '#f79332'], ['#dfe3e7', '#f79332'], ['#dfe3e7', '#f79332'], ['#dfe3e7', '#2ab7ee'], ['#dfe3e7', '#00719d']
			], circles = [];
			for (var i = 1; i <= 3; i++) {
				var child = document.getElementById('circles-' + i),
					percentage = 10 + (i * 8);
	
				circles.push(Circles.create({
					id:         child.id,
					value:		percentage,
					radius:     50,
					width:      7,
					colors:     colors[i - 1],
	 				textClass:           'circles-text',
	  				styleText:           true
				}));
			}
	  <!-- javascript for total sales chart-->
	</script>
	
	<!--staked column chart for payment-->
	<script src="${pageContext.request.contextPath }/resources/themes/js/highcharts.js"></script>
	<script src="${pageContext.request.contextPath }/resources/themes/js/highcharts-more.js"></script>
	
	<!-- Payment chart js-->
	<script>
	$(function paymentChart(){
	    $('#payment-chart').highcharts({
	        chart: {
	            type: 'column'
	        },
			colors: "#00719d,#2ab7ee".split(","),
	        title: {
	            text: 'Last 10 days comparison',
				style: {
	                color: "#4d575d",
	                fontSize: "14px",
	            },
	        },
	        xAxis: {
	            categories: ['9-7', '10-7', '11-7', '12-7', '13-7', '14-7', '15-7', '16-7', '17-7', '18-7']
	        },
	        yAxis: {
	            min: 0,
				title: {
						text: "Amount"
				},
				stackLabels: {
						enabled: false,
						style: {
							fontWeight: 'bold',
							color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
						}
					}
				},
	        legend: {
	            enabled: !0,
	            align: "right",
	            layout: "horizontal",
	            labelFormatter: function() {
	                return this.name
	            },
	            borderColor: false,
	            borderRadius: 0,
	            navigation: {
	                activeColor: "#274b6d",
	                inactiveColor: "#CCC"
	            },
	            shadow: false,
	            itemStyle: {
	                color: "#888888",
	                fontSize: "12px",
	                fontWeight: "normal"
	            },
	            itemHoverStyle: {
	                color: "#000"
	            },
	            itemHiddenStyle: {
	                color: "#CCC"
	            },
	            itemCheckboxStyle: {
	                position: "absolute"
	            },
				symbolHeight: 10,
				symbolWidth: 10,
	            symbolPadding: 5,
	            verticalAlign: "bottom",
	            x: 0,
	            y: 0,
	            title: {
	                style: {
	                    fontWeight: "normal"
	                }
	            }
	        },
	        tooltip: {
	            headerFormat: '<b>{point.x}</b><br/>',
	            pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}',
				backgroundColor: '#ffffff',
				borderColor: '#f0f0f0',
				shadow: true
	        },
	        plotOptions: {
	            column: {
	                stacking: 'normal',
	                dataLabels: {
	                    enabled: false,
	                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
	                    style: {
	                        textShadow: '0 0 3px black'
	                    }
	                }
	            }
	        },
			 credits: {
	            enabled: false,
	        },
	        series: [{
	            name: 'Card',
	            data: [25000, 50000, 75000, 75000, 60000, 70000, 10000, 2500, 5000, 25000]
	        }, {
	            name: 'Wallet',
	            data: [75000, 50000, 25000, 25000, 30000, 30000, 90000, 25000, 3000, 50000]
	        }]
			
	    });
	});
	</script>
	
	<!--staked column chart for sms details-->
	<script>
	$( function smsChart() { 
	    $('#sms-chart').highcharts({
	        chart: {
	            zoomType: 'none'
	        },
			colors: "#e75c5c,#9159b8".split(","),
	         title: {
	            text: 'Last 7 days comparison',
				style: {
	                color: "#4d575d",
	                fontSize: "14px",
	            },
	        },
	        xAxis: [{
	            categories: ['3-7', '4-7', '5-7', '6-7', '7-7', '8-7', '9-7']
	        }],
	        yAxis: [{ // Primary yAxis
	            labels: {
	                style: {
	                    color: Highcharts.getOptions().colors[1]
	                }
	            },
	            title: {
	                text: 'User Count',
	                style: {
	                    color: Highcharts.getOptions().colors[1]
	                }
	            }
	        }, { // Secondary yAxis
	            title: {
	                text: 'Total Days',
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            },
	            labels: {
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            },
	            opposite: true
	        }],
			legend: {
	            enabled: !0,
	            align: "right",
				layout: "horizontal",
	            labelFormatter: function() {
	                return this.name
	            },
	            borderColor: false,
	            borderRadius: 0,
	            navigation: {
	                activeColor: "#274b6d",
	                inactiveColor: "#CCC"
	            },
	            shadow: false,
	            itemStyle: {
	                color: "#888888",
	                fontSize: "12px",
	                fontWeight: "normal"
	            },
	            itemHoverStyle: {
	                color: "#000"
	            },
	            itemHiddenStyle: {
	                color: "#CCC"
	            },
	            itemCheckboxStyle: {
	                position: "absolute",
	                width: "12px",
	                height: "12px"
	            },
				symbolHeight: 10,
				symbolWidth: 10,
	            symbolPadding: 5,
	            verticalAlign: "bottom",
	            x: 0,
	            y: 0,
	            title: {
	                style: {
	                    fontWeight: "normal"
	                }
	            }
	        },
	
	        tooltip: {
	            shared: true,
				backgroundColor: '#ffffff',
				borderColor: '#f0f0f0',
				shadow: true
	        },
			 credits: {
	            enabled: false,
	        },
	
	        series: [{
	            name: 'Total Days',
	            type: 'spline',
	            yAxis: 1,
	            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6],
	            tooltip: {
	                pointFormat: '<span style="font-weight: bold; color: {series.color}">{series.name}</span>: '
	            }
	        }, {
	            name: 'Total Days error',
	            type: 'errorbar',
	            yAxis: 1,
	            data: [[48, 51], [68, 73], [92, 110], [128, 136], [140, 150], [171, 179], [135, 143]],
	            tooltip: {
	                pointFormat: '(error range: {point.low}-{point.high})<br/>'
	            }
	        }, {
	            name: 'User Count',
	            type: 'column',
	            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2],
	            tooltip: {
	                pointFormat: '<span style="font-weight: bold; color: {series.color}">{series.name}</span>: <b>{point.y:.1f}</b> '
	            }
	        }, {
	            name: 'User Count error',
	            type: 'errorbar',
	            data: [[6, 8], [5.9, 7.6], [9.4, 10.4], [14.1, 15.9], [18.0, 20.1], [21.0, 24.0], [23.2, 25.3]],
	            tooltip: {
	                pointFormat: '(error range: {point.low}-{point.high})<br/>'
	            }
	        }]
	    });
	});
	</script>
	<!-- Scripts Ends -->
	<!-- Javascript for Datepicker -->
	<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath }/resources/components/datetimepicker/js/moment-with-locales.js"></script>
	<script type="text/javascript" language="javascript" src="${pageContext.request.contextPath }/resources/components/datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script>
		// Linked date and time picker 
		// start date date and time picker 
		$('#datepicker-default').datetimepicker();
		$(".auto-update-year").html(new Date().getFullYear());
	</script> 
	
	<!--detail page table data expand collapse javascript-->
	<script type="text/javascript">
	$(document).ready(function () {
		$(".direct-expand").click(function(){
			$(".direct-child-table").slideToggle(300);
			$(this).toggleClass( "child-table-collapse" );
		});
	});
	</script>
	<!-- Scripts Ends -->
	
	<!-- 메뉴 수정 -->
	<script>
		$(window).resize(function(){
			var w = $(window).width();
			if(w > 1217){
				$("#navIcon").click(function(){
					if($("#basicSidebar").width() > 64){
						$("#navIcon").addClass("menuShow");
					} else {
						$("#navIcon").removeClass("menuShow");
					}
					
					if($("#navIcon").hasClass("menuShow")){
						$("#basicSidebar").mouseover(function(){
							$("#basicSidebar").addClass("pmd-sidebar-open");
						})
						$("#basicSidebar").mouseout(function(){
							$("#basicSidebar").removeClass("pmd-sidebar-open");
						}) 
					} else {
						$("#basicSidebar").off('mouseout');
					}
				})
			}
		})
	</script>
	
</body>
</html>