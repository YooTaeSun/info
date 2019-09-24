<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

$(document).ready(function() {

  if(location.hash == '#niceLogin'){
	  setTimeout(function(){
        history.pushState(null, null, '#');///location.href = '#';
	    history.go(-2);
	    location.href = location.href.replace(/[#].*/, '');
	  }, 1);
  }

  var ht = '<c:out value="${param.ht}" />';

  if(ht != '') {
    var ht = parseInt(ht);
    var pageHistory = history.length;

    window.addEventListener("hashchange", function(event) {
      console.log('stack : ' + history.length);
      var newURL = (event.newURL || '').match(/[#](.*)/, '$1');
      var oldURL = (event.oldURL || '').match(/[#](.*)/, '$1');
      if ((oldURL && oldURL[1] === 'forward')) {
        history.pushState('dummy', null, '#dummy');
        history.go(ht - history.length);
      }
    }, false);

    setTimeout(function() {
      location.href = '#'; //window가 완전 로드된 상태에서 히스토리가 적재됨.
      setTimeout(function() {
          location.href = '#forward'; //window가 완전 로드된 상태에서 히스토리가 적재됨.
      }, 300);
    }, 300);

    $('.certification-header-inner img').click(function(e) {
      history.go(-1);
    })
  }

	var form_chk = $("form [name=form_chk]");
	if(form_chk.length == 0){
		$('body:last').prepend('<form id="form_chk" name="form_chk" method="post">' +
	   	"<input type=\"hidden\" name=\"m\" value=\"checkplusSerivce\">" +
		"<input type=\"hidden\" name=\"EncodeData\" value=\"\">" +
        "<input type=\"hidden\" name=\"param_r1\" id=\"param_r1\" value=\"\">" +
        "<input type=\"hidden\" name=\"param_r2\" id=\"param_r2\" value=\"\">" +
        "<input type=\"hidden\" name=\"param_r3\" id=\"param_r3\" value=\"\">" +
	   	"</form>");
	}

	$("#myPageImg").on('click',function(e){

  		var successUrl =  "<c:url value='/user/mypage' />";
  		var failUrl =  window.location.pathname;

		fn_niceLogin(successUrl, failUrl);
	});
});

	//로그인 체크 후 나이스 인증
	function fn_niceLogin(successUrl, failUrl, data) {

		if($.type(data) != 'object'){
			data = {};
		}

		$.get('/login/chkGetEnc', {}).done(function(res){
	    		//로그인이 되어 있으면
      		if(res.success === 'Y'){
      			window.location.href = successUrl;
      		}else{
      			var resData = res.data;
      			var encData = resData.encData;

      		  location.href = "#niceLogin";

      	    data['ht'] = "" + history.length;

      	    var str = "";
      	    for ( var e in data) {
      	      str += "&" + e + "="+ data[e]
      	    }
      	    str = str.substring(1);

      			fn_goNiceIDLogin(successUrl, failUrl, encData, str);
      		}
    	}).fail(function(res){
    		alert(res.message);
    	});

	}

	//나이스 인증
	function fn_goNiceIDLogin(successUrl, failUrl, encData, data) {

		var $form_chk = $("form[name=form_chk]");
		$form_chk.find("input[name=EncodeData]").val(encData);
		$form_chk.find("input[name=param_r1]").val(successUrl);
		//$form_chk.find("input[name=param_r1]").val(successUrl);
		$form_chk.find("input[name=param_r2]").val(failUrl);
		if(data != undefined){
			$form_chk.find("input[name=param_r3]").val(data);
		}
		$form_chk.attr("action", "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb").submit();
	}

	var niceFailStatus = '<c:out value="${param.niceFailStatus}"/>';
	if(niceFailStatus != ''){
		console.log("" + niceFailStatus);
		alert("나이스 인증 실패하였습니다.");
	}

</script>