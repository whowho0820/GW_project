<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gw</title>
<!-- user css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/userCommon.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/userHeaderFooterMenu.css" />

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
<!-- handlebars -->
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<!-- 로그인, 회원가입 modal 관련 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/modal.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- 다음 주소검색 -->
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- 별점 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/w3.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/fontawesome-stars.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.barrating.min.js"></script>
<!-- 탭 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/jquery-ui.css"> 

<script src="${pageContext.request.contextPath }/resources/js/jquery-ui.min.js"></script>

<script>
/* 아이디 중복 체크 */
$( function() {
	  

	$("#btnDuplCheckId").click(function() {				
		var userId = $("input[name='duplCheckId']").val();
		
		if(userId == ""){
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		var json = JSON.stringify({"userId":userId});
		
		$.ajax({
			url:"${pageContext.request.contextPath }/rest/duplcheckid/",
			type:"post",
			headers:{"Content-Type":"application/json"},
			data:json,
			dataType:"text",
			success:function(res){
				if(res == "duplicate"){
					alert("이미 사용중이 아이디입니다.");
					$("input[name='duplCheckId']").val("");
				}else{
					alert("사용 가능한 아이디입니다.");
					$("#flagId").val("true");
				}
			}
		})
	})	  
	

	/* 로그인, 아이디 찾기, 비번찾기, 회원가입 전환시 작동 */		
	$(".login").click(function() {
		loginShow();
	})
	
	$("#findId").click(function() {
		$('#findIdModal').removeClass("fade");
		$('#loginModal').removeClass("fade");
		$('#loginModal').modal('hide');
		$('#findIdModal').modal('show');
		$('#findIdModal').addClass("fade");
		$('#loginModal').addClass("fade");
	})
	$("#findPass").click(function() {
		$('#findIdModal').removeClass("fade");
		$('#findPassModal').removeClass("fade");
		$('#loginModal').removeClass("fade");
		$('#loginModal').modal('hide');
		$('#findIdModal').modal('hide');
		$('#findPassModal').modal('show');
		$('#findIdModal').addClass("fade");
		$('#findPassModal').addClass("fade");
		$('#loginModal').addClass("fade");
	})
	$(".join").click(function() {
		$('#findIdModal').removeClass("fade");
		$('#findPassModal').removeClass("fade");
		$('#joinModal').removeClass("fade");
		$('#loginModal').removeClass("fade");
		$('#loginModal').modal('hide');
		$('#findIdModal').modal('hide');
		$('#findPassModal').modal('hide');
		$('#joinModal').modal('show');
		$('#joinModal').addClass("fade");
		$('#findIdModal').addClass("fade");
		$('#findPassModal').addClass("fade");
		$('#loginModal').addClass("fade");
	})
	/* 로그인 처리 */
	$("#loginForm").submit(function (e) {
		var id = $("input[name='userId']").val();
		var password = $("input[name='password']").val();
		
		if(id == "" || password == ""){
			alert("사용자ID와 비밀번호를 정확히 입력해주세요.")
			return false;
		}
	})
	var result = $("#result").val();
	if(result == 1){
		alert("해당 아이디가 존재하지 않습니다. 회원가입을 해주세요.");
		$("#logo").trigger("click");
	}else if(result == 2){
		alert("비밀번호가 틀렸습니다. 다시 확인해주세요.");
		$("#logo").trigger("click");
	}else if(result == 3){
		alert("관리자 권한이 없습니다. 다시 확인해주세요.");
		$("#logo").trigger("click");
	}
	
	/* 아이디 찾기 */
	$("#btnFindId").click(function() {
		var userType = $("input[name='userType']").val();
		var name = $("input[name='name']").val();
		var email = $("input[name='email']").val();
		
		if(userType == "" || name == "" || email == ""){
			alert("모든 항목을 선택/입력 해주세요.")
			return false;
		}
		var json = JSON.stringify({"userType":{"userType":userType}, "name":name, "email":email});
		
		$.ajax({
			url:"${pageContext.request.contextPath }/rest/findid/",
			type:"post",
			headers:{"Content-Type":"application/json"},
			data:json,
			dataType:"text",
			success:function(res){
				$("input[name='userType']").removeAttr("checked");
				$("input[name='name']").val("");
				$("input[name='email']").val("");
				 
				if(res == "NULL"){
					alert("찾고 있는 아이디가 없습니다. 회원가입을 해주세요.");
					return false;
				}
				
				var con = confirm("회원님의 아이디는 "+res+"입니다. 비밀번호도 찾으시겠어요?");
				if(con == true){
					$("#findPass").trigger("click");	
				}else{
					$(".login").trigger("click");
				}
				
			}
		})
	})
	
	/* 비번 찾기 */
	$("#btnFindPass").click(function() {
		var userType = $("input[name='userTypePw']").val();
		var userId = $("input[name='userIdPw']").val();
		var email = $("input[name='emailPw']").val();
		
		if(userType == "" || userId == "" || email == ""){
			alert("모든 항목을 선택/입력 해주세요.")
			return false;
		}
		var json = JSON.stringify({"userType":{"userType":userType}, "userId":userId, "email":email});
		
		$.ajax({
			url:"${pageContext.request.contextPath }/rest/findpass/",
			type:"post",
			headers:{"Content-Type":"application/json"},
			data:json,
			dataType:"text",
			success:function(res){
				alert("회원님의 임시비밀번호를 발급하였습니다. 이메일을 확인하시고 로그인해주세요.");
				$("input[name='userTypePw']").removeAttr("checked");
				$("input[name='userIdPw']").val("");
				$("input[name='emailPw']").val("");
				$(".login").trigger("click");
			}
		})
	})
	

	/* 비밀번호 정규표현식 체크 */
	var passRules = /^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,50}$/;
	
	$("#pass1").change(function() {
		var pass1 = $("#pass1").val();
		if(passRules.test(pass1)){
			alert("사용가능한 비밀번호입니다.");
		}else{
			alert("사용 불가능한 비밀번호입니다.(숫자, 특수문자, 영문 1자리 이상 포함, 8자리 이상)")
			$("#pass1").val('');
		}
	})
	$("#pass2").change(function() {
		var pass1 = $("#pass1").val();
		var pass2 = $("#pass2").val();
		if(pass1 == pass2){
			alert("비밀번호가 일치합니다.");
		}else{
			alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
			$("#pass2").val('');
		}
	})
	
	/* 닉네임 중복 체크 */
	$("#btnDuplCheckNick").click(function() {
		var nick = $("input[name='duplCheckNick']").val();
		
		if(nick == ""){
			alert("닉네임을 입력해주세요.");
			return false;
		}
		
		var json = JSON.stringify({"nick":nick});
		
		$.ajax({
			url:"${pageContext.request.contextPath }/rest/duplchecknick/",
			type:"post",
			headers:{"Content-Type":"application/json"},
			data:json,
			dataType:"text",
			success:function(res){
				if(res == "duplicate"){
					alert("이미 사용중인 닉네임입니다.");
					$("input[name='duplCheckNick']").val("");
				}else{
					alert("사용 가능한 닉네임입니다.");
					$("#flagNick").val("true");
				}
			}
		})
	})
	/* 가입하기 */
	$("#btnJoin").click(function() {
		var userId = $("input[name='duplCheckId']").val();
		var password = $("#pass2").val();
		var name = $("#joinName").val();
		var nick = $("input[name='duplCheckNick']").val();
		var gender = $("select[name='gender']").val();
		var birthday = $("#joinBirth").val();
		var tel = $("#joinTel").val();
		var address = $("input[name='address']").val();
		var detailAddress = $("input[name='detailAddress']").val();
		var email = $("#joinEmail").val();
		var userType = $("input[name='joinUserType']").val();
		
		if(userId=="" || password=="" || name=="" || nick=="" || gender=="" || birthday=="" || tel=="" || address=="" || email=="" || userType==""){
			alert("모든 항목을 작성해주세요.");
			return false;
		}
		var flagId = $("#flagId").val();
		var flagNick = $("#flagNick").val();
		alert(flagId);
		alert(flagNick);
		if(flagId == "false" || flagNick == "false"){
			alert("아이디 또는 닉네임 중복확인을 해주세요.");
			return false;
		}
		
		var json = JSON.stringify({"userId":userId, "password":password, "name":name, "nick":nick, 
								   "gender": gender, "birthday":birthday, "tel":tel, "address":address, 
								   "detailAddress":detailAddress, "email":email, "userType":{"userType":userType}});
		
		$.ajax({
			url:"${pageContext.request.contextPath }/rest/register/",
			type:"post",
			headers:{"Content-Type":"application/json"},
			data:json,
			dataType:"text",
			success:function(res){
				if(res == "SUCCESS"){
					alert("회원 가입이 되었습니다. 로그인한 후 이용해주세요.");
					$("input[name='duplCheckId']").val("");
					$("#pass1").val("");
					$("#pass2").val("");
					$("#joinName").val("");
					$("input[name='duplCheckNick']").val("");
					$("select[name='gender']").val("성별");
					$("#joinBirth").val("");
					$("#joinTel").val("");
					$("input[name='address']").val("");
					$("input[name='detailAddress']").val("");
					$("#joinEmail").val("");
					$("input[name='joinUserType']").removeAttr("checked");
					$(".login").trigger("click");
				}
			}
		})			
	})	 	
	
	
});
	

/* 주소 검색 */
function openDaumZipAddress() {
	new daum.Postcode({
		oncomplete:function(data) {
			jQuery("#address").val(data.address);
			jQuery("#detailAddress").focus();
			console.log(data);
		}
	}).open();
}

/* 로그인 show */
function loginShow() {
	$('#findIdModal').removeClass("fade");
	$('#findPassModal').removeClass("fade");
	$('#joinModal').removeClass("fade");
	$('#loginModal').removeClass("fade");
	$('#findIdModal').modal('hide');
	$('#findPassModal').modal('hide');
	$('#joinModal').modal('hide');
	$('#loginModal').modal('show');
	$('#findIdModal').addClass("fade");
	$('#findPassModal').addClass("fade");
	$('#joinModal').addClass("fade");
	$('#loginModal').addClass("fade");
}
	

</script>

<style>
	.container {
	    width: 100%;
	    height: 100%;
	    margin: 0 auto;
	    position: relative;
	    z-index: 3;
	    box-sizing: border-box;
	    max-width: 600px;
	}
	.inner{
	    padding-top: 13.333em;
	    margin: 0;
	    padding: 0;
	    border: 0;
	    font-size: 100%;
	    font: inherit;
	    vertical-align: baseline;
	    text-decoration: none;
	}
	.login_area{
		overflow: hidden;
	    overflow-x: hidden;
	    overflow-y: hidden;
	    text-align: center;	    
	}
	.swiper-container{
	    margin-top: 200px;
	    margin-right: auto;
	    margin-bottom: 0px;
	    margin-left: auto;
	    position: relative;
	    overflow: hidden;
	    overflow-x: hidden;
	    overflow-y: hidden;
	    list-style: none;
	    list-style-position: initial;
	    list-style-image: initial;
	    list-style-type: none;
	    padding: 0;
	    padding-top: 0px;
	    padding-right: 0px;
	    padding-bottom: 0px;
	    padding-left: 0px;
	    z-index: 1;
	}	

	.swiper-wrapper{
		position: relative;
	    width: 100%;
	    height: 100%;
	    z-index: 1;
	    display: -webkit-box;
	    display: -webkit-flex;
	    display: -ms-flexbox;
	    display: flex;
	    -webkit-transition-property: -webkit-transform;
	    transition-property: -webkit-transform;
	    -o-transition-property: transform;
	    transition-property: transform;
	    transition-property: transform, -webkit-transform;
	    -webkit-box-sizing: content-box;
	    box-sizing: content-box;
	}
	.login_area .green{
		border: 1px solid #3eae95;
	}
	.login_area .swiper-slide{
		padding: 3.333em 1em 0;
		padding-top: 3.333em;
	    padding-right: 1em;
	    padding-bottom: 0px;
	    padding-left: 1em;
	    background-color: #fff;
	    box-sizing: border-box;
	    border-radius: 0.8em;
	    position: relative;
	    height: 30em;
	    overflow: hidden;
	}
	.logo {
	    width: 18em;
	    transition: 0.5s ease-in-out;
	    transition-delay: 0.1s;
	    padding-top: 1.8em;
	    margin-bottom: 2.333em;
	}
	img {
	    max-width: 100%;
	    display: block;
	    margin: 0 auto;
	}
	.swiper-slide{
		-webkit-flex-shrink: 0;
	    -ms-flex-negative: 0;
	    flex-shrink: 0;
	    width: 100%;
	    height: 100%;
	    position: relative;
	    -webkit-transition-property: -webkit-transform;
	    transition-property: -webkit-transform;
	    -o-transition-property: transform;
	    transition-property: transform;
	    transition-property: transform, -webkit-transform;
	}
	#wrap {
	    position: relative;
	    overflow: hidden;
	    overflow-x: hidden;
	    overflow-y: hidden;
	}
	#site-main {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background: url(/resources/images/bg_part_2.png) no-repeat bottom center;
	    background-image: url(/resources/images/bg_part_2.png);
	    background-position-x: center;
	    background-position-y: bottom;
	    background-size: cover;
	    background-repeat-x: no-repeat;
	    background-repeat-y: no-repeat;
	    background-attachment: initial;
	    background-origin: initial;
	    background-clip: initial;
	    background-color: initial;
	    background-size: cover;
	}
	.color-green {
	    color: #049db4;
	}
	#site-main .login_area .forward p {
	    font-size: 1.2em;
	    line-height: 1.667em;
	    margin-bottom: 2.333em;
	    letter-spacing: -0.02em;
	    word-break: keep-all;
    }
	.weight-bold {
	   font-weight: bold!important;
	}

	@media screen and (max-width: 1600px){
	    .container.contant { width: 94%; padding-left: 250px; max-width: none; }
		.site-header .site-title { width: 180px; }
		.site-header .site-nav { width: auto; }
		.site-header .site-util { width: 100px; }
	    .site-header .site-util ul li{padding: 0.15em 0}
	}
	@media screen and (min-width:769px) and (max-width: 1200px){
	/*    #site-main .login_area > div{width:49.5%;}*/
	
	}
	@media screen and (max-width: 1200px){
	/*    #site-main .login_area > div > div{width:100%;box-sizing:border-box;}*/
	/*    #site-main .login_area .logo{width:55.7%;}*/
	
	    .session_graph li:first-child{padding-left:2.667em;}
	    .session_graph li:last-child{padding-right:2.667em;}
	
	}
	@media screen and (max-width: 1024px){
		body { font-size: 14px; }
	    .half > *:last-child{margin-bottom:0!important}
	}
	@media screen and (min-width: 769px) and (max-width: 1024px){
	    .m-w100p > *{float:none!important}
	    .m-w100p > *:not(img){width:100%!important;margin-left:0!important;margin-right:0!important;max-width:100%;display:block;}
	
	    .session_graph.graph-style-02 > li .inner{min-height:14em}
	
	    .bul-bluedotlist-small.half > li{margin-bottom:1em}
	}
	@media screen and (max-width: 768px){
		body { font-size: 13px;}
	    .site-header { height: 5.537em; position: fixed; top: 0; left: 0; z-index: 92; }
		.site-header .site-title { width: 33.333%; }
		.site-header .site-title a { font-size: 1.600em; }
		.site-header .site-nav { width: 33.333%; }
		.site-header .site-nav li:not(.active),
		.site-header .site-nav li:before,
		.site-header .site-nav li:after,
		.site-header .site-nav li .txt { display: none; }
	    .site-header .site-nav li{}
	    .site-header .site-nav li .num{position: absolute;width:3.143em;height:3.143em;line-height:2.743em;left: 50%;display: block;margin-left: -1em;top:50%;margin-top: -1.45em;font-size:1em;border:0.3em solid #206ebd;}
	    .site-header .site-util ul li.menu_btn .btn{position: absolute;right:3%;top:58%;margin-top: -1.33em}
		.site-header .site-util { width: 33.333%; }
		.site-header .site-util ul li { display: none; }
		.site-header .site-util ul li.menu_btn { display: block; }
	
		.site-sidebar {padding-top: 4.5em;padding-bottom: 5.334em;position: fixed;left: -240px;z-index: 91;}
		.site-sidebar.on { left: 0; }
	
		.m-site-util { display: block; }
	
		.site-session.on { display: block; }
		.site-body { padding-top: 4.5em; }
	
		.container.contant { padding-left: 0; width:100%; }
	
	    .content-header{padding:0 3%;}
		.content-header .location { display: none; }
	
		.content-body { padding: 1em 3%; }
		.content-footer.btn_group { text-align: center; }
		.content-footer.btn_group .btn { width: 48%; margin: 0 0.5%; border-radius: 0.2em; height: 4em; line-height: 4em; }
	
		.join_select .select .snsJoin .btn { height: 4em; line-height: 4em; }
		.jon_input ul li .tit { display: block; line-height: 1; }
		.jon_input ul li .cont { display: block; }
	
	    #site-main .login_area > div{width:100%;}
	    .site-title img{width: 6.3em;margin-top: 0.1em;}
	
	    .table-survey thead tr th{line-height:1.2}
	    #site-main .copyright_area .family li.mindspa img{margin-bottom: 3px;}
	
	}
	
	@media screen and (min-width: 641px) {
	    .swiper-button-prev.swiper-button-disabled, .swiper-button-next.swiper-button-disabled{display:none;}
	    #site-main .swiper-wrapper, #site-main .swiper-slide > *:not(.back){transform:translate3d(0px,0px,0px)!important;-webkit-transform:translate3d(0px,0px,0px)!important}
	}
	
	@media screen and (max-width: 640px){
	    .m-view{display:block}
	    .m-intro{float:none;padding:0}
	
	    .fifths > *, .fourths > *{width:calc(50% - 0.55em);margin:0 0.55em}
	    .fifths > *:nth-child(2n-1), .fourths > *:nth-child(2n-1){margin:0.55em 0.55em 0.55em 0;} /* odd */
	    .fifths > *:nth-child(2n), .fourths > *:nth-child(2n){margin:0.55em 0 0.55em 0.55em;} /* even */
	    .thirds > *{max-width:none;}
	
	    .m-w100p > *, m-w100p-2 > *{float:none!important}
	    .m-w100p > *:not(img), .m-w100p-2 > *:not(img){width:100%!important;margin-left:0!important;margin-right:0!important;max-width:100%;display:block;}
	
	    .half.m-w100p.half-gap > :first-child, .half.m-w100p-2.half-gap > :first-child{margin:1em 0 0.55em}
	    .half.m-w100p.half-gap > :last-child, .half.m-w100p-2.half-gap > :last-child{margin:0.55em 0 1em}
	    .half > .bul-bluedotlist-small > li:last-child{margin-bottom:0.667em}
	
	    .bul-bluedotlist-small.half > li{margin-bottom:1em}
	
	    .btn-style-01-01{top:auto;right:auto;bottom:-1.333em;left:-2.1em;transform:rotate(125deg);-ms-transform:rotate(125deg);-webkit-transform:rotate(125deg);}
	    .btn-style-01-02{top:auto;right:calc(50% - 1.8em);bottom:-1.333em;transform:rotate(90deg);-ms-transform:rotate(90deg);-webkit-transform:rotate(90deg);}
	
	    .s1s4_goal.s4s8{width:100%;}
	
	    .covered{display:none;}
	    #site-main{background:none;}
	    #site-main:before{content:none;}
	    #site-main .login_area, #site-main .inner{padding-top:0;height:100%;}
	    #site-main .login_area .logo{max-width:72%;}
	    #site-main .login_area .logo.on{width:50%;}
	    #site-main .login_area .btn_area{padding:0;}
	    #site-main .login_area .swiper-slide{background-color:transparent;border:none;padding:0 23%;min-height:30%;margin-top:15%;}
	    #site-main .login_area .input_area{margin-top:1.667em;padding:0;}
	    #site-main .login_area .btn-main-confirm{background-color:#fff;}
	    #site-main .login_area .findpass{text-align:center;margin-top:2em;}
	    #site-main .login_area .closeBtn-main{top:0;right:23%}
	    #site-main .login_area .forward p{margin-bottom:1.333em}
	    #site-main .swiper-container{height:100%;background-image:url('../images/main/bg_m_2.png');background-size:100%;}
	    #site-main .copyright_area{position:absolute;bottom:0;left:0;width:100%;}
	    #site-main .parallax-bg{position: absolute;left: 0;top: 0;width: 130%;background-image:url('../images/main/bg_m_1.png');height: 100%;-webkit-background-size: cover;background-size: 70%;background-position:left bottom;background-repeat:no-repeat;}
	
	    .br-w640{display:inline;}
	}
	@media screen and (min-width:481px) and (max-width:640px){
	    .session_graph.graph-style-02 > * > .inner{min-height:13em}
	}
	@media screen and (max-width:480px){
	    .session_graph li{padding:2.667em}
	    .session_graph li:first-child{padding-top:0}
	    .session_graph li:last-child{padding-bottom:0}
	    .session_graph li:before{top:0;left:50%;}
	    .session_graph.graph-style-02 > li{max-width:100%;}
	    .session_graph.graph-style-02 > li:first-child:before{border-top:0;height:16em}
	    .session_graph.graph-style-02 > li:last-child:before{display:none;}
	
	    .ipt_group.birthday .w100:nth-child(2), .ipt_group.birthday .w100:last-child{width:calc(50% - 50px - 0.667em)!important;min-width:auto}
	    .ipt_group.school .w100{width:calc(100% - 200px - 0.667em)!important;min-width:auto;}
	    .ipt_group .ipt_direct.w260{width:calc(100% - 7em)!important;}
	
	    .table-survey thead th:not(.th){padding:1.533em 0.333em}
	    .table-survey tbody tr > *:first-child{text-align:center}
	    .table-survey.table-score-white tbody tr .th{padding:1em;height:auto;line-height:1.2;padding:1em;}
	}
	
	@media screen and (max-width: 399px){
		body { font-size: 12px; }
	  #site-main .copyright_area .family li.mindspa img{margin-bottom: 0;}
	}
	
	@media screen and (max-width: 360px){
		body { font-size: 11px; }
	  #site-main .copyright_area .family li.mindspa img{margin-bottom: -3px;}
	
	}
/* 	버튼 */
	#site-main .login_area .btn_area{padding:0 14%;box-sizing:border-box;}
	#site-main .login_area .btn-main{vertical-align:middle;font-size:1.2em;line-height:2.889em;min-width:auto;border-radius:4px;}
	#site-main .login_area .btn_area .btn-main-login{color:#fff;}
	#site-main .login_area .green .btn-main-join{color:#0e9978;}
	#site-main .login_area .green .btn-main-login{background-color:#0e9978;}
	#site-main .login_area .btn-main-confirm{width:100%;border-radius:4px;border-color:#333!important;color:#333;margin-top:1.333em;}
	#site-main .login_area .input_area{margin-top:1.667em;padding:0 15%;}
	#site-main .login_area .input_area input{height:2.889em;border-color:#ccc;font-size:1.2em;padding:0 6%;font-family:'Nanum Square';}
	#site-main .login_area .input_area input[type="password"]{font-family: sans-serif;}
	#site-main .login_area .green .input_area .ipt:focus{border-color:#0e9978!important}
	#site-main .login_area .forward p{font-size:1.2em;line-height:1.667em;margin-bottom:2.333em;letter-spacing:-0.02em;word-break:keep-all;}
	#site-main .login_area .closeBtn-main{position:absolute;top:1.6em;right:1.6em;z-index:5;background-size:100%;color:transparent;border:none;outline-style:none;background-color:transparent;background-repeat:no-repeat;width:1.6em;height:1.6em;cursor:pointer;}
	#site-main .login_area .green .closeBtn-main{background-image:url('../images/main/closebtn_green.png');}
	#site-main .login_area .green .strong-txt{border-bottom:1px solid #049db4;color:#049db4;}
	/*#site-main .login_area .findpass{text-align:left;font-size:0.933em;margin-top:0.667em;display:block}*/
	#site-main .login_area .findpass{text-align:left;font-size:0.933em;display:inline-block;}
	#site-main .login_area .findpass span{border-bottom:1px solid #333;}	
	#site-main .swiper-button-next, #site-main .swiper-button-prev{width:12.5%;min-height:8em;top:calc(30% - 3.8em);background-size:100%;outline-style:none;background-position:center;}
	#site-main .swiper-button-next{background-image:url('../images/main/slide_next.png');right:0.333em;}
	#site-main .swiper-button-prev{background-image:url('../images/main/slide_prev.png');left:1em;}
	#site-main .login_area .green .btn {
	    border-color: #0e9978;
	    border-top-color: rgb(14, 153, 120);
	    border-right-color: rgb(14, 153, 120);
	    border-bottom-color: rgb(14, 153, 120);
	    border-left-color: rgb(14, 153, 120);
	}	
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
<div id="wrap">
 <section id="site-main"> 
	<div class="content container">
		<div class="inner">
			<div class="login_area">
				<form name="logFrm" id="logFrm" method="post" action="">
				  <div class="swiper-container swiper-container-horizontal">
					   <div class="parallax-bg"></div>					   
						    <div class="swiper-wrapper" >				
								<div class="swiper-slide green swiper-slide-active">				
									<img src="${pageContext.request.contextPath }/resources/images/logo_green2.png" alt="logo" id="logo" class="logo" data-swiper-parallax="-100"/>
									<div class="forward">
									<p class="weight-bold">
										<strong class="color-green">마음:TACT</strong>
										은
										<strong class="color-green">코로나블루</strong>
										를 <br>예방하기 위해
										<strong class="color-green">언제 어디서든 소통</strong>
										<br>할 수 있는 공간입니다.
									</p>
									<div class="btn_area half half-gap2 m-w100p-2">
									<c:choose>
										<c:when test="${Auth == null }">
											<input type="hidden" value="0" name="AuthNo">										
											<a class="btn btn-main btn-main-join shadow" href="#" data-toggle="modal" data-target="#joinModal">신규회원</a>
											<a class="btn btn-main btn-main-login shadow" href="#" data-toggle="modal" data-target="#loginModal">기존회원</a>
											<input type="hidden" value="${error }" id="result">
										</c:when>
										<c:when test="${Auth == '관리자' }">
											<input type="hidden" value="${AuthNo }" name="AuthNo">
											<a class="btn btn-main btn-main-login shadow" href="${pageContext.request.contextPath }/admin/">관 리 자</a>											
											<a class="btn btn-main btn-main-join shadow" href="${pageContext.request.contextPath }/user/logout">LOGOUT</a>
										</c:when>
										<c:when test="${Auth != '관리자' }">
											<input type="hidden" value="${AuthNo }" name="AuthNo">
											<input type="hidden" value="${userId }">
											<li><a class="btn btn-main btn-main-login shadow" href="${pageContext.request.contextPath }/user/mypage?userId=${userId}">${Auth}님</a></li>
											<li><a class="btn btn-main btn-main-join shadow" href="${pageContext.request.contextPath }/user/logout">LOGOUT</a></li>
										</c:when>
									</c:choose>
									</div>										
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
 </section>
</div>
		<!-- 로그인 modal start -->
		<div class="modal fade" id="loginModal">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
				    
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title">로그인</h3>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						<form id="loginForm" action="${pageContext.request.contextPath }/user/" method="post">
							<%-- <img src="${pageContext.request.contextPath }/resources/images/h.jpg" style="width: 460px;"> --%>
							<h3 style="color: #85cc28;margin: 10px;"></h3>
							<input class="inputRegi" type="text" name="userId" placeholder="아이디" style="margin-bottom: 20px;"><br>
							<input class="inputRegi" type="password" name="password" autocomplete="on" placeholder="비밀번호" style="margin-bottom: 5px;"><br>
							
							<div class="checkbox">
                              <label>
                                  <input name="remember" type="checkbox" value="Y"  <c:if test='${userid != null && userid != ""}'>checked</c:if>> 로그인유지
                              </label>
                             </div>                             

							<input type="submit" class="btn btn-primary" style="margin-top: 5px;width: 337px;cursor: pointer;" value="로그인">
							<a href="#" id="findId" style="color:64CD3C;margin-left: 150px;">아이디 찾기</a>
							<a href="#" id="findPass" style="color:64CD3C;margin-left: 10px;">비밀번호 찾기</a><br>
						</form>
					</div>
					
					<!-- Modal footer -->
					<div style="border-top: 1px solid #ccc;">
						<div style="text-align: center;margin: 16px;">
							<span>아이디가 없으신가요?</span> <a href="#" class="join" style="color:#64CD3C;">회원가입</a>
						</div>
					</div>
				    
				</div>
			</div>
		</div>
		<!-- 로그인 modal end -->
		
		<!-- 아이디찾기 modal start -->
		<div class="modal fade" id="findIdModal">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
				    
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title">마음:TACT 아이디 찾기</h3>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						<div>
							<input type="radio" name="userType" value="2" style="margin-bottom: 25px;"> <label style="margin-right:30px;">개인 회원</label>
							<input type="radio" name="userType" value="1"> <label>사업자 회원</label>
							<input class="inputRegi" type="text" name="name" placeholder="이름" style="margin-bottom: 20px;"><br>
							<input class="inputRegi" type="email" name="email" placeholder="이메일" style="margin-bottom: 30px;"><br>
							<input type="button" class="btn btn-danger login" style="margin-top: 5px;width: 167px;margin-right: -15px;cursor: pointer;" value="돌아가기">
							<input type="button" class="btn btn-primary" id="btnFindId" style="margin-top: 5px;width: 167px;cursor: pointer;" value="아이디 찾기">
						</div>
					</div>
					
					<!-- Modal footer -->
					<div style="border-top: 1px solid #ccc;">
						<div style="text-align: center;margin: 16px;">
							<span>아이디가 없으신가요?</span> <a href="#" class="join" style="color:#64CD3C;">회원가입</a>
						</div>
					</div>
				    
				</div>
			</div>
		</div>
		<!-- 아이디찾기 modal end -->
		
		<!-- 비밀번호 찾기 modal start -->
		<div class="modal fade" id="findPassModal">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
				    
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title">마음:TACT 비밀번호 찾기</h3>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						<div>
							<input type="radio" name="userTypePw" value="2" style="margin-bottom: 25px;"> <label style="margin-right:30px;">개인 회원</label>
							<input type="radio" name="userTypePw" value="1"> <label>사업자 회원</label>
							<input class="inputRegi" type="text" name="userIdPw" placeholder="아이디" style="margin-bottom: 20px;"><br>
							<input class="inputRegi" type="email" name="emailPw" placeholder="이메일" style="margin-bottom: 30px;"><br>
							<input type="button" class="btn btn-danger login" style="margin-top: 5px;width: 167px;margin-right: -15px;cursor: pointer;" value="돌아가기">
							<input type="button" id="btnFindPass"class="btn btn-primary" style="margin-top: 5px;width: 167px;cursor: pointer;" value="비밀번호 찾기">
						</div>
					</div>
					
					<!-- Modal footer -->
					<div style="border-top: 1px solid #ccc;">
						<div style="text-align: center;margin: 16px;">
							<span>아이디가 없으신가요?</span> <a href="#" class="join" style="color:#64CD3C;">회원가입</a>
						</div>
					</div>
				    
				</div>
			</div>
		</div>
		<!-- 비밀번호 찾기 modal end -->
		
		<!-- 회원가입 modal start -->
		<div class="modal fade" id="joinModal">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
				    
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title">마음:TACT 회원 가입</h3>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						<input class="inputRegi1" type="text" name="duplCheckId" id="duplCheckId" placeholder="아이디">
						<input type="hidden" id="flagId" value="false">
						<button class="btnCheck" id="btnDuplCheckId" onclick="btnDuplCheckId();"  style="cursor: pointer;">중복확인</button><br>
						<form>
							<input class="inputRegi" type="password" id="pass1" autocomplete="on" placeholder="비밀번호"><br>
							<input class="inputRegi" type="password" id="pass2" autocomplete="on" placeholder="비밀번호 확인"><br>
						</form>
						<input class="inputRegi" type="text" id="joinName" placeholder="이름"><br>
						<input class="inputRegi1" type="text" name="duplCheckNick" id="duplCheckNick" placeholder="닉네임">
						<button class="btnCheck"  id="btnDuplCheckNick" style="cursor: pointer;">중복확인</button><br>
						<input type="hidden" id="flagNick" value="false">
						<select class="inputRegi" name="gender"style="height: 42px;width: 337px;color: #949494;">
							<option selected="selected">성별</option>
							<option value="MALE">남자</option>
							<option value="FEMALE">여자</option>
						</select>
						<input class="inputRegi" type="date" id="joinBirth" placeholder="생년월일" style="color: #949494;"><br>
						<input class="inputRegi" type="text" id="joinTel" placeholder="전화번호"><br>
						<input class="inputRegi1" type="text" name ="address" id="address" placeholder="주소">



						<input type="button" value="주소검색" class="btnCheck"  id="btnSearchAddr" onclick="openDaumZipAddress();" style="cursor: pointer;"><br>
						<input class="inputRegi" type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
						<input class="inputRegi" type="email" id="joinEmail" placeholder="이메일"><br>
						<input type="radio" name="joinUserType" id="joinUserType" value="2"> <span class="chgColorSpan">개인회원</span>
						<input type="radio" name="joinUserType" id="joinUserType" value="1" style="margin-left:20px;"> <span class="chgColorSpan">관리자</span><br>
						<button type="button" class="btn btn-primary" id="btnJoin" style="cursor: pointer;">가입하기</button>
					</div>
					
					<!-- Modal footer -->
					<div style="border-top: 1px solid #ccc;">
						<div style="text-align: center;margin: 16px;">
							<span>이미 가입하셨나요?</span> <a href="#" class="login" style="color:#64CD3C;">로그인</a>
						</div>
					</div>
				    
				</div>
			</div>
		</div>
		<!-- 회원가입 modal end -->
</body>
</html>
