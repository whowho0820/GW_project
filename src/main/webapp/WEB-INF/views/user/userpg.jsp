<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../userInclude/header.jsp" %>
<style>
	.content-body {
	    border: 0;
	    padding: 2.5em 2em;
	}
	
	.panel {
	    background-color: #fff;
	    border: 1px solid #ced9ee;
	    border-radius: 0.333em;
	    box-sizing: border-box;
	    margin-bottom: 2em;
	    margin-right: 7em;    
	}
	.panel.trans {
    border: 0;
    background-color: transparent;
	}
	.panel.trans .panel-head {
    background-color: transparent;
    padding: 0 0 1em;
    border-bottom: 1px solid #ccc;
	}
	.panel-head h2 {
	    font-size: 1.467em;
	}
	.color-blue {
	    color: #2887d6;
	}
	h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
	}	
	.panel.trans .panel-head + .panel-body {
    padding: 1em 0;
	}
	.panel.trans .panel-body {
	    padding: 0;
	    word-break: keep-all;
	}
	.color-green {
    color: #0e9978;
	}
	strong {
	    font-weight: 400;
	}
	.panel.gray {
    border: 0;
	}
	.panel.gray .panel-body {
	    background-color: #f5f5f5;
	    border: 1px solid #f5f5f5;
	    border-radius: 0.333em;
	}
	.block_m {
    display: inline;
	}
	.bg_green {
	    color: #fff;
	    position: relative;
	}
	.bg_green:before {
	    position: absolute;
	    top: 0%;
	    width: 101%;
	    height: 100%;
	    content: '';
	    background: #0e9978;
	}
	.bg_green > span {
	    position: relative;
	    z-index: 1;
	}
	.btn_group.right {
	    text-align: right;
	    margin-right: 9em;
	}
	.btn_group {
	    position: relative;
	    vertical-align: middle;
	    margin-top: 1.667em;
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
					<span>프로그램 개요</span>
				</h1><!-- End Title -->
				<!--breadcrum start-->
				<ol class="breadcrumb text-left">
				  <li><a href="${pageContext.request.contextPath }/admin/">Works</a></li>
				  <li class="active">프로그램 개요</li>
				</ol><!--breadcrum end-->
					<section class="content-body panel" id="summary">
						<div class="panel trans">
							<div class="panel-head">
								<h2 class="color-blue">코로나 블루 온라인 자가관리 프로그램 '마음:TACT'에 오신 것을 환영합니다.</h2>
							</div>
							<div class="panel-body">
							코로나19가 장기화되면서 성인남녀 절반 이상이 우울감, 불안감, 무기력증 등을 경험하고 있습니다. <br>
							이를 ‘코로나 블루(코로나 우울)’이라고 하는데, ‘코로나19’와 ‘우울감(blue)’이 합쳐진 신조어로 일상생활에 제약이 생기면서 느끼는 심리적 이상 증세를 말합니다.
							<br><br>
							<strong class="color-green">코로나 블루 원인은</strong>
							<br><br>
							코로나19는 우리의 평범한 일상을 앗아갔습니다. 생계에 필요한 외출 외에 모임을 자제하면서 사회적 고립감을 안겨줬으며, 증명되지 않은 민간요법과 가짜 뉴스는 불안감을 가중시키고 있습니다. 
							<br>
							경제가 어려워지자 기업에서는 채용을 하지 않고, 일자리 유지가 힘든 자영업자나 직장인도 생겨났습니다. 실내에 머무는 시간이 늘면서 ‘확찐자, 작아격리, 집콕족, 집콕 챌린지’ 등 관련 신조어가  
							<br>
							생겨난 반면, 부족한 신체 활동으로 무기력을 호소하는 사람도 많습니다.
							<br><br>
							<div class="panel gray">
								<div class="panel-body">
									<strong class="color-green">코로나 블루 자가진단</strong>
									<br><br>
									현재 코로나 블루를 정확하게 진단할 수 있는 정신의학적 기준은 없습니다. 하지만, 코로나 블루로 인해 다양한 신체, 정신적 증상을 호소하는 사람들이 많고, <br>
									일상생활에 지장을 줄 정도라면 전문가의 도움을 적극적으로 받아야 합니다. 위 기준은 질병관리청의 우울증 자가진단 기준으로 4가지 이상 해당한다면 우울증 상담이 필요한 상태입니다. <br>
									장시간 마스크 착용으로 숨이 차서 병원을 찾은 환자가 공황 장애로 진단받은 사례도 있습니다.
									<br><br>
									<strong class="color-green">코로나 블루 극복을 위한 심리방역</strong>
									<br><br>
									코로나19로 인해 변화된 내 일상을 자연스럽게 받아들여야 합니다. 지금 느끼는 이 감정은 새로운 환경에 적응하기 위한 자연스러운 현상일 뿐입니다.<br>
									집에서 생활하더라도 이전과 같은 생활 패턴을 유지하는 것이 중요한데요. 같은 시간에 일어나고 잠에 드는 것이 몸과 마음 건강을 지키는 데 도움이 됩니다. <br>
									실내에서 할 수 있는 마음이 즐거운 취미나 여가 시간을 가지고, 스트레칭, 걷기 등 신체활동도 꾸준히 해야 합니다. 매일 쏟아지는 수많은 정보는 불안과 걱정을 가중시키지만, <br>
									숫자에 집착하지 않고 방역 지침만 잘 실천하면 됩니다.
									<br><br>
								</div>							
							</div>		
								<h2 class="color-green">이에 코로나 블루 온라인 자기관리 프로그램 <span class="block_m"><span class="bg_green"><span>"마음:TACT"</span></span> 을 개발하였습니다.</span></h2>					
							</div>
						</div>
					</section>
					<section class="content-footer btn_group margin right">
						<a href="/user/mukkaCafe" class="btn radius20 shadow green">Next</a>						
					</section> 
			</div>
		</div>
	</div>
<%@ include file="../userInclude/footer.jsp" %>