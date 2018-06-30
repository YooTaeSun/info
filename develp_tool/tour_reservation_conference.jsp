<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tiles/layout/head_taglib.jsp" %>
<style>
<!--
.not_operaion {background: olive;}
.coronation {background: #f5f5f5;}
.reservaion {background: red;}
.preDate {background: #f5f5f5;}
-->
</style>
<script>
//console.table = null;
//---------------  전역 영역 start ---------------------
var CELL_HEIGHT = 25;
var curDate = "${result.curDate}";
var limitDate = "${result.limitDate}";
var limitTime = "${result.limitTime}";
//---------------  전역 영역 end ---------------------
jQuery(function($){

	mobile_header_title('대관');

    var jssor_1_SlideoTransitions = [
        [{b:-1,d:1,o:-1},{b:0,d:1000,o:1}],
        [{b:1900,d:2000,x:-379,e:{x:7}}],
        [{b:1900,d:2000,x:-379,e:{x:7}}],
        [{b:-1,d:1,o:-1,r:288,sX:9,sY:9},{b:1000,d:900,x:-1400,y:-660,o:1,r:-288,sX:-9,sY:-9,e:{r:6}},{b:1900,d:1600,x:-200,o:-1,e:{x:16}}]
      ];

		var jssor_1_options = {
		  $AutoPlay: true,
		  $SlideDuration: 800,
		  $SlideEasing: $Jease$.$OutQuint,
		  $CaptionSliderOptions: {
			$Class: $JssorCaptionSlideo$,
			$Transitions: jssor_1_SlideoTransitions
		  },

		  $BulletNavigatorOptions: {
			$Class: $JssorBulletNavigator$,
			$AutoCenter: 1
		  }
		};
      var jssor_1_slider = new $JssorSlider$("reserSlide", jssor_1_options);

      /*responsive code begin*/
      /*you can remove responsive code if you don't want the slider scales while window resizing*/
      function ScaleSlider() {
          var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
          if (refSize) {
              refSize = Math.min(refSize, 1920);
              jssor_1_slider.$ScaleWidth(refSize);
          }
          else {
              window.setTimeout(ScaleSlider, 30);
          }
      }
      ScaleSlider();
      $(window).bind("load", ScaleSlider);
      $(window).bind("resize", ScaleSlider);
      $(window).bind("orientationchange", ScaleSlider);
      /*responsive code end*/

      //선택된 대관시설 앞으로 옮기기
	$(".cateMenu:eq(0)").prepend($(".cateMenu:eq(0) a.on").parent().detach());
	//----------------------- 시설예약 버튼  -----------------
	$(".btnApply").on( "click", function(e){
		$('#form')
		.attr('action', '<c:url value="/m/support/tour_reservation_conference_apply.do"/>')
		.submit();
	});
	//----------------------- 시설안내 버튼  -----------------
	$(".btnApplyGuide").on( "click", function(e){
		$('#form')
		.attr('action', '<c:url value="/m/info/facilities_guide.do"/>')
		.submit();
	});
	//----------------------- 오늘 ,이전 , 다음 버튼  -----------------
	var newDate = "${result.curDate}";
	var date = new Date();

	var fromDate = $.datepicker.formatDate('yy.mm.dd',new Date(curDate.substring(0,4),parseInt(curDate.substring(5,7)-4),curDate.substring(8,10)));
	var toDate = $.datepicker.formatDate('yy.mm.dd',new Date(curDate.substring(0,4),parseInt(curDate.substring(5,7))+2,curDate.substring(8,10)));
	var direction = "next";
	//console.log(" fromDate >>" + fromDate);
	//console.log(" toDate >>" + toDate);
	//console.log(" curDate >>" + curDate);

	$("#btn_today,#btn_previous_week,#btn_next_week").on( "click", function(e){
		var id = $(this).attr("id");
		if(id == "btn_previous_week" || id == "btn_next_week"){
			var dateObj = null;
			if(id == "btn_previous_week"){
				if(direction == "next"){
					newDate = $.datepicker.formatDate('yy.mm.dd',new Date(newDate.substring(0,4),parseInt(newDate.substring(5,7)-1),parseInt(newDate.substring(8,10))-1));
				}
				dateObj = fn_getPeriod(newDate,"pre");
				if(fromDate >= dateObj.startDate) return;
				newDate = dateObj.startDate;
				direction = "pre";
				fn_selectScheInfo(dateObj);
			}else{
				if(direction == "pre"){
					newDate = $.datepicker.formatDate('yy.mm.dd',new Date(newDate.substring(0,4),parseInt(newDate.substring(5,7)-1),parseInt(newDate.substring(8,10))+1));
				}
				dateObj = fn_getPeriod(newDate,"next");
				if(toDate <= dateObj.endDate) return;
				newDate = dateObj.endDate;
				direction = "next";
				fn_selectScheInfo(dateObj);
			}
		}else if(id == "btn_today"){
			direction = "next";
			newDate = curDate;
			$("#btn_next_week").trigger("click");
		}
	});
	$("#btn_next_week").trigger("click");

	$("#cal").on("click","li.date div[data-num]:not(.reservaion,.disable,.coronation,.preDate)",function(e){

		var minTm = parseInt($("#minTm").val());//최소예약시간(분) 15분
		var rsvtUnit = parseInt($("#rsvtUnit").val());//예약단위(분) 30

		if(rsvtUnit < minTm){
			alert("최소예약시간 "+minTm+"(분)보다 커야 합니다.");
			return;
		}


		//입주단체만 이용가능, 로그인 체크
		if(!properties.checkLogin(true,true)){
			alert("로그인 해야 이용 가능한 서비스 입니다.");
			return;
		}

		var f = '${result.confSem.fctMstIdx}';
		var m = '${memberDetails.mbrTypCd}';
		var mfMsg = '';

		if (f == '9' || f == '10') { // 모두모임방
			if(m != "015001" &&  m != '015002' && m != '015003'){//입주단체, 비입주단체, 혁신가가 아니면
				mfMsg = '혁신멤버만 이용 가능한 서비스 입니다.';
			} else {
				mfMsg = '모두모임방은 휴대폰(모바일 버전)으로 대관하실 수 없습니다.';
			}
		} else {
			if("${memberDetails.mbrTypCd}" != "015001" &&  "${memberDetails.assMbrTypCd}" != "015001"){//입주단체가 아니면
				mfMsg = '입주한 혁신멤버와 가입한 직원만 이용 가능한 서비스 입니다.';
			}
		}

		if(mfMsg){//입주단체가 아니면
			//alert("입주한 혁신멤버만 이용 가능한 서비스 입니다.");
			alert(mfMsg);
			return;
		}

		var $ui = $(this);
		var dataDay = $ui.attr("data-date");
		var dataTm = $ui.attr("data-tm");
		var dataTmEnd = $ui.attr("data-tm-end");
		var $sample = $("#dragSample").clone().removeClass("hidden");
		$sample.removeAttr("id").css("height",CELL_HEIGHT);
		$sample.find(".circle_info_drag").html(dataTm + "~" + dataTmEnd);
		$ui.append($sample);

		if ('${result.confSem.fctMstIdx}' == '9' || '${result.confSem.fctMstIdx}' == '10') {

		} else {
			pageLoad();

			window.setTimeout(function(){
				$('#form')
				.attr('action', '<c:url value="/m/support/tour_reservation_conference_apply.do"/>')
				.append("<input type=\"hidden\" name=\"apply_start\" value=\""+dataDay+"\">")
				.append("<input type=\"hidden\" name=\"apply_start_time\" value=\""+dataTm+"\">")
				.append("<input type=\"hidden\" name=\"apply_end\" value=\""+dataDay+"\">")
				.append("<input type=\"hidden\" name=\"apply_end_time\" value=\""+dataTmEnd+"\">")
				.append("<input type=\"hidden\" name=\"rsvtPlcCd\" value=\"${result.rsvtPlcCd}\">")
				.append("<input type=\"hidden\" name=\"fctMstIdx\" value=\"${result.confSem.fctMstIdx}\">")
				.submit();
			}, 500);
		}
	});
});


//해당 날짜의 이틀 날짜 구하기
function fn_getPeriod(dateStr,direction){
	var startDate = "";
	var endDate = "";

	if(direction == 'pre'){//이전
		startDate = $.datepicker.formatDate('yy.mm.dd',new Date(dateStr.substring(0,4),dateStr.substring(5,7)-1,dateStr.substring(8,10)-1));
		endDate =  dateStr;
	}else{//다음
		startDate = dateStr
		endDate = $.datepicker.formatDate('yy.mm.dd',new Date(dateStr.substring(0,4),dateStr.substring(5,7)-1,dateStr.substring(8,10)-0+1));
	}
	//console.log( " dateStr >> " + dateStr  + " startDate >> " + startDate + " endDate >> " + endDate);
	return {
		startDate : startDate,
		endDate : endDate
	}
}

//페이지 이동
function fn_goUrl(thisObj){
	var dataFctMstIdx = $.trim($(thisObj).attr("data-fctMstIdx"));

	if(dataFctMstIdx != ""){
		$('#form')
		.append("<input type=\"hidden\" name=\"fctMstIdx\" value=\""+dataFctMstIdx+"\">")
		.submit();
	}else{
		var dataUrl = $.trim($(thisObj).attr("data-url"));
		$('#form').attr('action', dataUrl)
		.submit();
	}
}

function fn_selectScheInfo(dateObj){

	var url = '<c:out value="/support/selectScheduleReservationConference.json"/>';
	var submitData = {
		startDate : dateObj.startDate,
		endDate : dateObj.endDate,
		fctMstIdx : "${result.confSem.fctMstIdx}",
		rtaYn : $("#rtaYn").val(),
		rsvtUnit : $("#rsvtUnit").val()
	};

	var callback = function(data) {
		var result = data.result;
		//head
		var scheHead = result.scheHead;
		$(".reserTbl_header li:not(:first)").remove();

		if(scheHead != null && scheHead.length > 0){

			//console.log("================	scheHead 	===================");
			//if(console.table) console.table(result.scheHead);

			var _scheHead = null;
			$("#dataPeriod").text(scheHead[0].clndDt);
			for (var i = 0, len = scheHead.length; i < len; i++) {
				_scheHead = scheHead[i];
				var $li = $("<li>"+ _scheHead.head +"</li>");
				//$li.data("data",_scheHead);
				$(".reserTbl_header li:last").after($li);
			}
		}

		$("#cal").empty();
		if(result && result.scheList){
			var scheList = result.scheList;
			if(scheList != null && scheList.length > 0){

				//console.log("================	scheList 	===================");
				//if(console.table) console.table(result.scheList);

				var _clndDt = "";
				var $liTag = null;//day
				var liList = [];

				for (var i = 0,len = scheList.length; i < len; i++) {
					sche = scheList[i];
					var clndDt = sche.clndDt;
					var tm = sche.tm;
					var tmEnd = sche.tmEnd;
					var fctRsvtIdx = $.trim(sche.fctRsvtIdx);//예약번호
					var rtaYn = sche.rtaYn;//대관
					var fctSchYn = sche.fctSchYn;//예약가능

					if(i == 0) {
						_clndDt = clndDt
						$liTag = $("<li class=\"date\" data-date=\""+clndDt+"\"></li>");//day
					}

					if(clndDt != _clndDt){//날짜 변경
						liList.push($liTag);
						$liTag = $("<li class=\"date\" data-date=\""+clndDt+"\"></li>");//day
						_clndDt = clndDt;
					}

					var $div = $("<div data-num=\""+i+"\" data-date=\""+clndDt+"\" fctRsvtIdx=\""+fctRsvtIdx+"\" data-tm=\""+tm+"\" data-tm-end=\""+tmEnd+"\"></div>");

					if(rtaYn == 'Y'){
						$div.attr("fctRsvtIdx","");
						$div.addClass("coronation");
					}else if(fctSchYn == 'N'){
						$div.attr("fctRsvtIdx","");
						$div.addClass("disable");
					}else if(fctRsvtIdx != ""){
						$div.addClass("reservaion");
					}
					$liTag.append($div);
				}

				if($liTag.find("div").length > 0){
					liList.push($liTag);
				}

				$.each(liList, function( li_i, $li ) {
					//선택 제한
					if($li.attr("data-date") <= limitDate){//
						if($li.attr("data-date") < limitDate){//
							$li.find("div").addClass("preDate");
						}else if($li.attr("data-date") == limitDate){
							$.each($li.find("div"), function( div_i, div ) {
								if($(div).attr("data-tm").replace(':','') <= limitTime.replace(':','')){
									$(div).addClass("preDate")
								}
							});
						}
					}
					if(li_i == 0){
						var $liTime = $("<li class=\"time\" id=\"time\"></li>");
						$.each($li.find("div"), function( div_i, div ) {
							$div = $(div);
							var dataTm = $div.attr("data-tm");
							$liTime.append("<div>"+dataTm.substring(0,2) + ":" + dataTm.substring(3,5)+"</div>");
						});
						$liTime.addClass("time");
						$("#cal").append($liTime);
					}else{
						$li.addClass("date");
					}
					$li.appendTo("#cal");
				});

				//예약
				var facilitiesReserveList = result.facilitiesReserveList;
				for ( var i in facilitiesReserveList) {
					var facilitiesReserve = facilitiesReserveList[i]
					var fctRsvtIdx = $.trim(facilitiesReserve.fctRsvtIdx);
					var rsvtPgr = facilitiesReserve.rsvtPgr;//예약진행상태 공통코드(020)
					var oztnNm = $.trim(facilitiesReserve.oztnNm);
					var srtDate = facilitiesReserve.srtDate;
					var endDate = facilitiesReserve.endDate;
					var srtTm = $.trim(facilitiesReserve.srtTm);
					var endTm = $.trim(facilitiesReserve.endTm);
					var _srtDate = new Date(srtDate.substring(0,4),parseInt(srtDate.substring(5,7)-1),srtDate.substring(8,10));
					var _endDate = new Date(endDate.substring(0,4),parseInt(endDate.substring(5,7)-1),endDate.substring(8,10));

					var str  = "";
					/*
					if(srtDate == endDate){
						str  = srtTm + "~" + endTm + " ";
					}else{
						str  = srtDate + " " + srtTm + "~" + endDate + " " + endTm + " ";
					}
					*/

					if(oztnNm != ""){
						str += oztnNm + "<br/>";
					}

					if(rsvtPgr != "020001"){//검토중
						str += "예약번호" + fctRsvtIdx;
					}

					for (var k = _srtDate; k <= _endDate; k.setDate(k.getDate() + 1)) {
						var dataDate =  $.datepicker.formatDate('yy.mm.dd',k);
						var $reserveGroup = $("#cal div[fctRsvtIdx=\""+fctRsvtIdx+"\"][data-date=\""+dataDate+"\"]").addClass("disable");

						var timeInterval = $reserveGroup.length;
						var $sample = $("#sample").clone().removeClass("hidden");
						$sample.removeAttr("id").css("height",timeInterval*CELL_HEIGHT-1);
						if(rsvtPgr == "020001"){//검토중
							$sample.find("span:first").addClass("circle_check");/* 검토중  */
						}else if(rsvtPgr == "020002"){//승인완료
							$sample.find("span:first").addClass("circle_req");/* 결제요청시 */
						}else if(rsvtPgr == "020003"){//예약완료
							$sample.find("span:first").addClass("circle_fin");/* 결제완료시 */
						}
						$sample.find(".circle_info").html("<span class=\"time\">"+srtTm + "~" + endTm+"</span><span class=\"txt\">"+str+"</span>");
						$reserveGroup.eq(0).append($sample);
					}
				}
			}
		}

		var useYn = '<c:out value="${result.confSem.useYn}"/>';
		if(useYn == 'N'){
			//모든 dim처리
			$("#cal li > div").addClass("disable");
		}
	}
	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}

</script>
<form method="get" id='form'>
<input type="hidden" id="pfctMstIdx" name="pfctMstIdx" value="${result.confSem.fctMstIdx}">
<input type="hidden" id="minTm" value="${result.confSem.minTm}"><!-- 최소예약시간(분) -->
<input type="hidden" id="rsvtUnit" value="${result.confSem.rsvtUnit}"><!-- 예약단위(분) -->
<input type="hidden" id=rtaYn value="${result.confSem.rtaYn}"><!-- 대관가능여부 -->

<section class="subtop">
		<div class="cateBox">
			<ul class="cateMenu">
				<c:forEach var="item" items="${result.reservePlaces}">
					<c:if test="${item.cmmnCd != '002004' && item.cmmnCd != '002007' && item.cmmnCd != '002007'}"> <!-- 002004 우드파크 002005	모두모임방,  002007	파크투어 -->
					<c:choose>
						<c:when test="${item.cmmnCd == '002001'}"><c:set var="dataUrl" value="/m/support/tour_reservation_conference.do"/></c:when>
						<c:when test="${item.cmmnCd == '002002'}"><c:set var="dataUrl" value="/m/support/tour_reservation_outside.do"/></c:when>
						<c:when test="${item.cmmnCd == '002003'}"><c:set var="dataUrl" value="/m/support/tour_reservation_maker.do"/></c:when>
						<c:when test="${item.cmmnCd == '002006'}"><c:set var="dataUrl" value="/m/support/tour_reservation_etc.do"/></c:when>
						<c:when test="${item.cmmnCd == '002008'}"><c:set var="dataUrl" value="/m/support/tour_reservation_theater.do"/></c:when>
						<c:when test="${item.cmmnCd == '002009'}"><c:set var="dataUrl" value="/m/support/tour_reservation_cook.do"/></c:when>
						<c:when test="${item.cmmnCd == '002010'}"><c:set var="dataUrl" value="/m/support/tour_reservation_multipurpose.do"/></c:when>
					</c:choose>
						<li><a href="javascript:void(0);" class="<c:if test="${item.cmmnCd == result.rsvtPlcCd}">on</c:if>" onclick="fn_goUrl(this);" data-url="${dataUrl}">${item.cmmnCdNm}</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<div class="btnCateBox">
				<a href="javascript:void(0);" class="btnCate">메뉴펼침</a>
			</div>

			<ul class="cateMenu_open hidden">
				<c:forEach var="item" items="${result.reservePlaces}">
					<c:if test="${item.cmmnCd != '002004' && item.cmmnCd != '002007' && item.cmmnCd != '002007'}"> <!-- 002004 우드파크 002005	모두모임방,  002007	파크투어 -->
					<c:choose>
						<c:when test="${item.cmmnCd == '002001'}"><c:set var="dataUrl" value="/m/support/tour_reservation_conference.do"/></c:when>
						<c:when test="${item.cmmnCd == '002002'}"><c:set var="dataUrl" value="/m/support/tour_reservation_outside.do"/></c:when>
						<c:when test="${item.cmmnCd == '002003'}"><c:set var="dataUrl" value="/m/support/tour_reservation_maker.do"/></c:when>
						<c:when test="${item.cmmnCd == '002006'}"><c:set var="dataUrl" value="/m/support/tour_reservation_etc.do"/></c:when>
						<c:when test="${item.cmmnCd == '002008'}"><c:set var="dataUrl" value="/m/support/tour_reservation_theater.do"/></c:when>
						<c:when test="${item.cmmnCd == '002009'}"><c:set var="dataUrl" value="/m/support/tour_reservation_cook.do"/></c:when>
						<c:when test="${item.cmmnCd == '002010'}"><c:set var="dataUrl" value="/m/support/tour_reservation_multipurpose.do"/></c:when>
					</c:choose>
						<li class="<c:if test="${item.cmmnCd == result.rsvtPlcCd}">on</c:if>"><a href="javascript:void(0);" onclick="fn_goUrl(this);" data-url="${dataUrl}">${item.cmmnCdNm}</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>

		<script>/*-- 카테고리 메뉴 */
			$(document).ready(function(){
				$('.btnCate').click(function(){
					$('.cateMenu_open').toggleClass('hidden');
					$('.btnCate').toggleClass('rotate');
				});
			});
		</script>

		<div style="width:100%; border-top:1px solid #ddd;"><!-- 셀렉트 / 카테고리 -->
			<div class="styledSelect">
				 <select onchange="fn_goUrl(this.selectedOptions);">
					<c:forEach var="item" items="${result.confSemList}">
						<li class=""><a href="javascript:void(0);" >${item.fctNm}</a></li>
						<option <c:if test="${item.fctMstIdx == result.confSem.fctMstIdx}">selected="selected"</c:if> data-fctMstIdx="${item.fctMstIdx}" data-rsvtPlcCd="${item.rsvtPlcCd}">${item.fctNm}</option>
					</c:forEach>
				 </select>
			</div>
		</div>

		<div class="submenuBox">
			<ul class="submenu">
				<li class="fl"><button type="button" class="btnApplyGuide">시설안내</button></li>
				<c:if test="${result.confSem.useYn eq 'Y'}">
					<li class="fr"><button type="button" class="btnApply">내게맞는시설</button></li>
				</c:if>
			</ul>
		</div>

		<div id="reserSlide" style="position: relative; margin: 0 auto; top: 0px; left: 0px;  width:320px; height:160px; "><!-- 이미지슬라이드 / 등록이미지사이즈 640x320 -->
			<div class="reserBox" data-u="slides" style="cursor:default; width:320px; height:160px; overflow: hidden;">
				<c:choose>
					<c:when test="${empty param.fctMstIdx or param.fctMstIdx eq '1' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk1-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk1-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk1-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '2' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk2-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk2-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk2-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '3' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk3-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk3-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk3-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '4' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk4-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk4-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk4-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '5' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk5-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk5-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/smalltalk5-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '6' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/bigtalk1-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/bigtalk1-2.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '7' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/bigtalk2-1.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/bigtalk2-2.jpg' />
						</div>
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/bigtalk2-3.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '8' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/multiroom.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '9' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/everymeet1.jpg' />
						</div>
					</c:when>
					<c:when test="${param.fctMstIdx eq '10' }">
						<div data-p="112.50">
							<img data-u="image" src='<spring:eval expression="@propertiesService['upload.url.root']" />/static/reservation/everymeet2.jpg' />
						</div>
					</c:when>
				</c:choose>
			</div><!-- /memLst -->

			<!-- 슬라이드 컨트롤러 -->
			<div data-u="navigator" class="reserSlideBul">
				<div data-u="prototype"></div>
			</div>
		</div><!-- /reserSlide -->

		<ul class="reserInfoTbl">
			<li>
				<span class="tit time">운영시간</span>
				<span class="txt">${result.confSem.oprTmInfo}</span>
			</li>
			<li>
				<span class="tit member">예약가능회원</span>
				<span class="txt">${result.confSem.rsvtMbrInfo}</span>
			</li>
			<li>
				<span class="tit count">사용가능인원</span>
				<span class="txt">${result.confSem.psblMinPsct}명 ~ ${result.confSem.psblMaxPsct}명(${result.confSem.fctFoa}㎡)</span>
			</li>
			<li>
				<span class="tit pay">이용료</span>
				<span class="txt">
				<c:choose>
					<c:when test="${empty result.confSem.dftPrc or result.confSem.dftPrc eq '0' }">무료</c:when>
					<c:otherwise>${result.confSem.dftPrc} 원</c:otherwise>
				</c:choose>
				</span>
			</li>
			<li>
				<span class="tit memo">특이사항</span>
				<span class="txt">${result.confSem.rmk}</span>
			</li>
			<li>
				<span class="tit person">담당자</span>
				<span class="txt">${result.confSem.mngrNm}</span>
			</li>
		</ul>

	</section>

	<section class="sub_container">

		<div class="facilityCal">
			<div class="facilityCalTop">
				<div class="cal_nav">
					<a href="javascript:void(0);" class="btnMonthPrev" id="btn_previous_week">이전달</a>
					<a href="javascript:void(0);" class="btnMonthNext" id="btn_next_week">다음달</a>
					<span id="dataPeriod">2016.10.13</span>
				</div>
				<button type="button" class="btnLine" id="btn_today">오늘</button>
			</div>

			<div class="facilityNotice">원하시는 시작 시간을 선택하신 뒤, 다음화면에서 종료시간을 선택해주세요.</div>

			<ul class="reserTbl_header">
				<li class="time">시간</li>
<!--
				<li>8월 1일(월)</li>
				<li>8월 2일(화)</li>
-->
			</ul>

			<ul class="reserTbl" id="cal">
<!--
				<li class="time"></li>
				<li class="date"></li>
-->
			</ul>
		</div>
	</section>
</form>

<div id="sample" class="row hidden"><!-- div 높이값 24px / 예약시간 높이값 변경 클래스 .row  -->
	<span></span><!-- 결제요청시 -->
	<span class="circle_info"><!-- 09:30~11:30 시민참여팀<br/>결제요청 --></span>
</div>
<div id="dragSample" class="drag hidden">
	<span class="circle_drag"></span>
	<span class="circle_info_drag"><!-- 09:30~11:30 --></span>
</div>