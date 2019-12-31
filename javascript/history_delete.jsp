<script type="text/javascript">
var IS_WIN_LOAD = false;
var DELAY_LOAD_CNT =  0;
window.onload = function() {
	IS_WIN_LOAD = true;
}
	$(document ).ready(function() {

		$(window).on('load', function () {
			if(sessionStorage){
				// history back check event
				fn_loginChkHisotryBackEvent();
				// forward history delete
				fn_loginDelForwardHistory();
				// history back register event
				fn_loginRegiHisotryBackEvent();
			}
		});
	});

	//--------   히스토리 start ----------------------------------
	function fn_loginChkHisotryBackEvent(){
	    window.addEventListener("hashchange", function(event) {
	    	//debugger;
	    	var oldURL = (event.oldURL || '').match(/[#](.*)/, '$1');
			if (oldURL && oldURL[1].indexOf('forward_') > -1) {
				var htObj = getHt();
				var htKey = htObj.key;
				var ht = parseInt(getParameterByName(location.href, "ht_"+ htKey));
				sessionStorage.setItem("isDelLoginHistory_" + htKey, "Y");
				history.go(ht - history.length);
			}
	      }, false);
	}

	// forward history delete
	function fn_loginDelForwardHistory(){
		if(sessionStorage.getItem("isDelLoginHistory") == "Y" || sessionStorage.getItem("isback") == "Y"){
			sessionStorage.removeItem("isDelLoginHistory");
			sessionStorage.removeItem("isback");
			history.pushState(null, '', '#');
			history.replaceState(null, '', location.href.replace(/[#].*/, ''));
			history.go(-1);
		}
	}

	// history back register event
	function fn_loginRegiHisotryBackEvent(){
		if(IS_WIN_LOAD == true || DELAY_LOAD_CNT > 6){

			var htObj = getHt();

			if(htObj && htObj.key != ""){

				var htKey = htObj.key;
				var htVal = htObj.val;

				if(htObj && window.location.hash != '#forward_' + htKey) {
					sessionStorage.removeItem("isback_" + htKey);
					if($("#forward_"+ htKey).length == 0){
						$('body:last').prepend("<a href=\"#\" id=\"forward_" + htKey + "\" onclick=\"location.href='#forward_" + htKey + "'\" style=\"display: none;\">forward</a>");
					}

			    	setTimeout(function() {
						$("#forward_" + htKey).trigger("click");
			      	}, 300);
				}
			}
		}else{
			DELAY_LOAD_CNT++;
		  	setTimeout(fn_loginRegiHisotryBackEvent, 500);
		}
	}
	//--------   히스토리 end ----------------------------------

	function getParameterByName(url, name) {
		if(typeof url === 'undefined'){
			return '';
	    }
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
	    var results = regex.exec(url);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}

	function getHt() {
		var query = window.location.search.substring(1);
		var qsvars = query.split("&");
		var matched = qsvars.filter(function(qsvar){return qsvar.substring(0,3) === 'ht_'});
		//var dddd = matched.map(function(match){ return match.split("=")[1]});
		if(matched && matched.length > 0){
			var htArray = matched[0].split("=");
			if(htArray && htArray.length > 0){
				var key = htArray[0].replace("ht_","");
				var val = htArray[1];
				return {key : key, val: val};
			}
		}
	    return null;
	}
</script>