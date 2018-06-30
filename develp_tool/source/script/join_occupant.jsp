<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tiles/layout/head_taglib.jsp" %>
<style>
<!--
.file { display:none; }
.seaLstBox {
    margin-top: 30px;
    height: 240px;
    overflow-y: auto;
    min-width: 550px;
}
-->
</style>
<script>
jQuery(function($){
	header_title('혁신멤버가입');
	//--------------------  숫자와 -만 -----------------
	$('input[name=ceoPhn], input[name=ofcPhn]').onlyNumber();

	//-------------------- 단체소개 글자수 제한  -----------------
	$('[name=oztnItdc]').on('keyup', function(e) {
		fn_limitTxtCnt(e, $(this), 500, $('.tipTxt'));
    });
	//------------------------ 태그이벤트 --------------------
	$("input[name='tagNms']").on("keyup blur", function(e) {
		fn_tagEvent(e, $(this));
	});
	//------------------------ 위치 정보 --------------------
	$("input[name='locTypCd']").on( "change", function(e){
		fn_locationEvent(e, $(this));
	});
	$("input[name='locTypCd']:eq(0)").trigger("click");
	//----------------------- accordion-----------------
	var accordionIndex = "0";
	$(".joinArea .teCon").not(":eq("+accordionIndex+")").hide();
	$(".joinArea .teTit").not(":eq("+accordionIndex+")").prop("disabled",true);
	$(".joinArea .teTit:eq("+accordionIndex+")").addClass("selected");
	$(".joinArea .teTit>a>p").removeClass("off").addClass("on");
	$(".joinArea .teTit:eq(0)>a>p").removeClass("on").addClass("off");

	$(".joinArea .teTit").on( "click", function(e){
		if($(this).prop("disabled") ==  true){
			//return;
		}
		fn_accordion(e, $(this));
	});
	//----------------------- 비밀번호 이벤트 -----------------
	$("input[name=mbrPwd]").on( "keyup", function(e){
		fn_pwdEvent(e, $(this));
	});
	//----------------------- 약관동의 이벤트 -----------------
	$("#agree,#agree_02,#agree_03").on( "change", function(e){
		fn_agreeChange(e, $(this));
	});
	//----------------------- 업체 조회 버튼  -----------------
	$("#btn_popComSelect").on( "click", function(e){
		fn_popComSelect(e, $(this));
	});
	//----------------------- 인증번호 받기 버튼  -----------------
	$("#btn_popCertiNum").on( "click", function(e){
		$("#certiconfirmMsg").html("");
		$(".joinArea .teTit").not(":eq(0)").prop("disabled",true);
		fn_popCertiNum(e, $(this));
	});
	//----------------------- 인증번호확인 버튼  -----------------
	$("#btn_certiconfirm").on( "click", function(e){
		fn_certiconfirm(e, $(this));
	});
	//----------------------- 단체명 enter  -----------------
	$("#reqOztnNm").on( "keypress", function(e){
		if (e.which == 13) {/* 13 == enter key@ascii */
			$("#btn_comSearch").trigger("click");
		}
	});
	//----------------------- 입주업체조회   -----------------
	$("#btn_comSearch").on( "click", function(e){
		fn_comSearch(e, $(this));
	});
	//----------------------- blog중복체크   -----------------
	$("#btn_blogDoubleCheck").on( "click", function(e){
		fn_blogDoubleCheck(e, $(this));
	});

	//영문,숫자만 가능
	$("input[name=blog]").keyup(function(event){
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
		var inputVal = $(this).val();
		$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		}
	});
	//----------------------- jquery form validate   -----------------
	fn_formValidate();
	//----------------------- 파일업로드   -----------------
	fn_fileupload();//파일업로드
	//------------------------ 업종  --------------------
	$(".joinArea").on( "change", $("input[name=svcAct]:checked"),function(e){
		if($("input[name=svcAct]:checked").length >= 4){
			alert("업종은 3개 까지 선택 가능합니다.");
			$(e.target).prop("checked", false);
			return false;
		}
	});
	//-----------------	popup callback event start	-------------------------
	$('.pop-layer').on('layerClose', function(e){
		var id = $(this).attr('id');
		if (id== 'popCertiNum') {//인증번호받기:레이어팝업

		}else if (id== 'popBlogDoubleCheck') {//블로그주소 중복확인:레이어팝업

		}
	})
	.on('layerConfirmClick', function(e){
		var id = $(this).attr('id');
		if (id== 'popCertiNum') {//인증번호받기:레이어팝업

		}else if (id== 'popBlogDoubleCheck') {//블로그주소 중복확인:레이어팝업
			var val = $("input[name='blog']").val();
			$("input[name='c_blog']").val(val);
		}
	})
	.on('layerCancelClick', function(e){
		var id = $(this).attr('id');

		if (id== 'popCertiNum') {//인증번호받기:레이어팝업

		}else if (id== 'popBlogDoubleCheck') {//블로그주소 중복확인:레이어팝업
			$("input[name='blog']").val("");
			$("input[name='c_blog']").val("");
		}
	})
	//-----------------	popup callback event end	-------------------------
});
//---------------  전역 영역 start ---------------------
var con_uploadUrlRoot = '<spring:eval expression="@propertiesService['upload.url.root']"/>';
var con_relateMemberCode = "${result.relateMemberCode}";
var con_memberType = "${result.memberType}";//혁신멤버 구분 공통코드(015001) 입주업체
var occupantCom = {};
//---------------  전역 영역 end ---------------------

//페이지 이동
function fn_goUrl(url){
	window.location.href = url;
}

//파일태그 선택
function fn_fileSelect(fileId){
	$("#" + fileId).trigger("click");
}

//업로드한 파일 삭제
function fn_fileRemove(filePathId){

	if(filePathId == "oztnImgPath"){
		$("#oztnImg").attr("src","");
		$("#oztnImgPath").val("");
		$("#oztnImgAddArea").show();
		$("#oztnImgUploadedArea").hide();
	}else if(filePathId == "locImgPath"){
		$("#locImg").attr("src","");
		$("#locImgPath").val("");
		$("#locImgAddArea").show();
		$("#locImgUploadedArea").hide();
	}
}

//파일업로드 관련
function fn_fileupload(){
	$('#locImgPathFile,#oztnImgPathFile').fileupload({
		autoUpload: true,
		dataType: 'json',
		url: '<c:out value="/file/uploadFile.json"/>',
        add: function (e, data) {
            var uploadFile = data.files[0];
			if(uploadFile.name.length > 50){
				alert("원본 파일명은 50자 이하 입니다.");
				return;
			}
            var isValid = true;
            if (!(/png|jpe?g|gif/i).test(uploadFile.name)) {
                alert('png, jpg, gif 만 가능합니다');
                isValid = false;
            } else if (uploadFile.size > (20971520)) {
                alert('파일 용량은 20메가를 초과할 수 없습니다.');
                isValid = false;
            }
            if (isValid) {
				var target = e.target.id;
				var formData = null;
				if(target == "oztnImgPathFile"){
					formData = {
							thumnailType : "CROP",
							maxWidth: 114,
							maxHeight: 114
					}
				}else if(target == "locImgPathFile"){
					formData = {}
				}
				data.formData = formData;
                data.submit();
            }
        },
        fail :function (e, data) {
        	try {var data = JSON.parse(data.jqXHR.responseText); if(data && data.msg){alert(data.msg);}} catch (e) { alert("파일 업로드 도중 에러가 발생했습니다.");};
        },
    	done: function (e, data) {
			var target = e.target.id;
    		$.each(data.result.files, function (index, file) {
				if(target == "oztnImgPathFile"){
					$("#oztnImgAddArea").hide();
					$("#oztnImgUploadedArea").show();
					$("input[name='oztnImgPath']").val(file.filePath);
					$("#oztnImg").attr("src",con_uploadUrlRoot + file.filePath);
				}else if(target == "locImgPathFile"){
					$("#locImgAddArea").hide();
					$("#locImgUploadedArea").show();
	  				$("input[name='locImgPath']").val(file.filePath);
	   				$("#locImg").attr("src",con_uploadUrlRoot + file.filePath);
				}
    		});
		}
	});
}
function fn_formValidate(){
	$('#form').on('invalid', function(e, element){
		$("[name="+element.name+"]").parents(".teCon").prev(".teTit").find("P").trigger("click");
	});

	jQuery.validator.setDefaults({
		success : "valid",
		ignore: []//type hidden도 체크
	});

	$.validator.addMethod('customFn', function(value, element, result){
		return this.optional(element) || result;
	}, 'customFn');


	$('#form').validate({
		showErrors: function(errorMap, errorList) {
			if(!$.isEmptyObject(errorList)){
				if (this.numberOfInvalids()) {
					var name = errorList[0].element.name;
	            	var $obj = $("[name="+name+"]");
	        		if($.trim($obj.attr("each")) == "true"){//각각  실행시 param
						if(name == "pwd"){
						}
						$obj.removeAttr("each");
	        		}else{
						$(errorList[0].element.form).trigger('invalid', [errorList[0].element]);
	        			alert(errorList[0].message);
						$(errorList[0].element).focus();
	        		}
				}
			}
		},
		rules: {
			oztnNm : {required: true},//단체명
 			mbrId : {required: true},//아이디
 			certiNum : {//인증번호
 				required : {
 					depends : function(element){
	 					var val = element.value;
	 					var emil = $.trim($("#c_ceoEmil").val());
	 					var cceCd = $.trim($("#c_certiNum").val());
	 					var oztnNm = $.trim($("#c_oztnNm").val());

	 					if(emil != "" && cceCd != ""){
	 						$.ajax({
	 							url: '<c:out value="/mail/confirmSessionCerti.json"/>',
	 							async: false,
	 							dataType: 'json',
	 							contentType: "application/json",
	 							method: 'POST',
	 							data : JSON.stringify({
		 							emil : emil,//아이디
		 							cceCd : cceCd,//인증번호
		 							oztnNm : oztnNm,//단체명
		 						}),
		 						success: function(data, textStatus, jqXHR) {
		 							var resultCode = data.resultCode;
		 							var result = data.result;
		 							if(result == true){
		 								return false;//없어 있으면 통과
		 							}else{
		 								$("#c_ceoEmil").val("");
		 								$("#c_certiNum").val("");
		 								$("#c_oztnNm").val("");
		 								return true;//있으면 통과
		 							}
	 							}
	 						});
	 					}else{
	 						return true;//있으면 통과
	 					}
 					}
 				},
 				customFn : function(element){
 					var emil = $.trim($("#c_ceoEmil").val());
	 				var cceCd = $.trim($("#c_certiNum").val());
	 				var oztnNm = $.trim($("#c_oztnNm").val());
 					if(emil != "" && cceCd != "" && oztnNm != ""){
 						var result  = true;
						return result;//통과
 					}else{
 						var result  = false;
 						return result;//
 					}
 				}
 			},
 			agree : {required: true},
			agree_02 : {required: true},
			agree_03 : {required: true},
			mbrPwd : {//비밀번호
				required: true,
				pwd: true
			},
			mbrPwdCheck : {//비밀번호체크
				required: true,
				equalTo: "input[name=mbrPwd]",
			},
			oztnTypCd : {//입주그룹
				required:  function () {
				if ($("select[name=oztnTypCd] option:selected").val() == "") {
	                    return true;
	                } else {
	                    return false;
	                }
				}
	        },
	        svcAct: {
                required: true,
                minlength: 1
            },
	        ofcPhn : {//대표전화
				required: true,
				regx: /^\d{2,3}-?\d{3,4}-?\d{4}$/
			},
	        ceoPhn : {//대표휴대전화
				required: true,
				regx: /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/
			},
			oztnAddr : {required: true},//단체주소
			blog: {
				required: true,
				rangelength: [3,20],
				equalTo : "#c_blog",
				customFn : function(element){
					var blog = $(element).val();
					if( $.isNumeric(blog) == true || /^[A-Za-z0-9]{3,20}$/.test(blog) == false){
						return false;
					}else{
						return true;
					}
 				}
	        }
		},
		messages: {
			oztnNm : {required: "단체명,프로젝트명을 입력하세요."},//단체명
 			mbrId : {required: "단체를 대표하는 이메일을 입력하세요."},//아이디
 			certiNum : {//인증번호
 				required: "인증 확인 하세요.",
 				customFn : "인증 확인 하세요."
 			},
 			agree : {required: "이용약관 동의를 체크해 주세요."},
			agree_02 : {required: "개인정보 수집 및 이용 동의를 체크해 주세요."},
			agree_03 : {required: "대관 운영규정 동의를 체크해 주세요."},
			mbrPwd : {//비밀번호
				required: "비밀번호를  입력해 주세요.",
				pwd: "사용 불가한 비밀번호입니다."
			},
			mbrPwdCheck : {//비밀번호체크
				required: "비밀번호재확인을  입력해 주세요.",
				equalTo: "비밀번호가 일치하지 않습니다.",
			},
			oztnTypCd : {required: "입주그룹을  선택해 주세요."},//입주그룹
			svcAct : {required: "업종을  선택해 주세요."},//업종
				ofcPhn : {//대표전화
				required: "대표전화을  입력해 주세요.",
				regx: "대표전화 형식이 틀립니다."
	        },
	        ceoPhn : {//대표휴대전화
	        	required: "대표휴대전화을  입력해 주세요.",
	        	regx: "대표휴대전화 형식이 틀립니다."
	        },
	        oztnAddr : {required: "단체주소을  입력해 주세요."},//
			blog: {
				required: "영문,숫자조합 3~20자 이내로 입력하십시오.",
				rangelength: "영문,숫자조합 3~20자 이내로 입력하십시오.",
				equalTo : "블러그 중복확인 하세요.",
				customFn: "영문,숫자조합 3~20자 이내로 입력하십시오.",
	        }
		}
	});
}

//아코디언
function fn_accordion(e, $this){
	//teTit teCon
		if(e.target.tagName != "P") return;

		// 펼칠 내용 영역 선택
		var $teCon = $this.next();
		var $openedteCon = $(".joinArea .teCon:visible");

		if($teCon[0] == $openedteCon[0]){return;}

		if($teCon[0] == $(".joinArea .teCon:eq(2)")[0]){
			fn_getGoogleMapJs();
		}

		$this.toggleClass("selected");
		$(".joinArea .teTit").not(this).removeClass("selected");
        // 나머지 내용 영역을 선택
        var other = $(".joinArea .teCon").not($teCon)
        // 애니메이션으로 열고 닫기 처리
        $teCon.slideToggle(300);
        other.slideUp(300);

		$(".joinArea .teTit>a>p").removeClass("off").addClass("on")
		$this.find("p").removeClass("on").addClass("off");
}


//구글 맵 js
var isGoogleMap = false;
function fn_getGoogleMapJs(){
	if(isGoogleMap === false){
	   $('<script>').attr({
		    type: 'text/javascript',
		    src: 'https://maps.googleapis.com/maps/api/js?key=<spring:eval expression="@propertiesService['spring.googleMap.secret']"/>&callback=fn_googleMap',
		    cid: 'googleMap'
		}).appendTo('head');
	   isGoogleMap = true;
	}
}
//비밀번호 이벤트
function fn_pwdEvent(e, $this){
	var validResult =  $("input[name=mbrPwd]").attr("each","true").valid();

	if(validResult == false) {
		if($.trim($("input[name=mbrPwd]").val()) == ""){
			$("#mbrPwdMsg").html("");
		}else{
			$("#mbrPwdMsg").html("사용 불가한 비밀번호입니다.");
		}
	}else{
		$("#mbrPwdMsg").html("적합한 비밀번호입니다.");
	}
}

function fn_limitTxtCnt(e, $this, limitCnt, viewText){
    if($this.val().length > limitCnt) {
        $this.val($this.val().substring(0, limitCnt));
    }
    if(viewText && viewText.length > 0){
    	viewText.text($this.val().length);
    }
}


//약관동의
function fn_agreeChange(e, $this){

	if($("#agree").is(":checked") && $("#agree_02").is(":checked") && $("#agree_03").is(":checked")){

		var emil = $.trim($("#c_ceoEmil").val());
		var cceCd = $.trim($("#c_certiNum").val());
		var oztnNm = $.trim($("#c_oztnNm").val());

		if(emil != "" && cceCd != ""){
			var url = '<c:out value="/mail/confirmSessionCerti.json"/>';
			var submitData = {
				emil : emil,//아이디
				cceCd : cceCd,//인증번호
				oztnNm : oztnNm//단체명
			};

			var callback = function(data) {
				var result = data.result;
				if(result == true){
					$("#v_ceoEmil").html($("#c_ceoEmil").val());
					$("#v_oztnNm").html($("#c_oztnNm").val());
					$("#v_ceoNm").html(con_occupantCom.ceoNm);
					$("input[name=ofcPhn]").val(con_occupantCom.ofcPhn);//대표전화
					$("input[name=ceoPhn]").val(con_occupantCom.ceoPhn);//대표휴대전화
					$("input[name=oztnAddr]").val(con_occupantCom.oztnAddr);//단체주소

					$(".joinArea .teTit").prop("disabled",false);
					$(".joinArea .teTit P:eq(1)").trigger("click");
				}else{
					$(".joinArea .teTit").not(":eq(0)").prop("disabled",true);
				}
			}
			ajaxSubmit(url, JSON.stringify(submitData), callback, null);
		}
	}else{
		$(".joinArea .teTit").not(":eq(0)").prop("disabled",true);
	}
	return true;
}

//업체 조회
function fn_popComSelect(e, $this){
	layer_open("popComSelect", function(){
		$("#popComSelect .seaLstBox").empty().hide();
		$("#popComSelect .seaResult").hide();
		$("#reqOztnNm").val("").focus();
	});
}

//인증번호 받기
function fn_popCertiNum(e, $this){

	var oztnNm = $("input[name=oztnNm]").val();

	if(oztnNm == ""){
		alert("단체명,프로젝트명을 입력하세요.");
		$("input[name=oztnNm]").focus();
		return;
	}

	var to = $.trim($("input[name=mbrId]").val());
	if(to == ""){
		alert("단체를 대표하는 이메일을 입력하세요.");
		$("input[name=mbrId]").focus();
		return;
	}

	if(!checkEmail(to)) {
	    alert("단체를 대표하는 이메일 형식이 올바르지 않습니다.");
	    $("input[name=mbrId]").focus();
	    return;
	}

	//사용 중인 동일한 아이디가 있는지 체크
	var url = '<c:out value="/member/selectMember.json"/>';
	var submitData = {
		mbrId : $.trim($("input[name=mbrId]").val())
	};

 	var callback = function(data) {
		if(data.member){
			alert("이미 같은 아이디가 가입되어 있습니다.");
		}else{
			var url = '<c:out value="/mail/reqSendMail.json"/>';
			var submitData = {
				to : $.trim($("input[name=mbrId]").val()),
				oztnNm : $("input[name=oztnNm]").val()
			};

			var callback = function(data) {
				$("#c_certiNum").val("");
				layer_open("popCertiNum");
				$("#emailTo").html(con_occupantCom.ceoEmil);
				$("#btn_popCertiNum").html("인증번호  다시받기")
			};
			ajaxSubmit(url, JSON.stringify(submitData), callback, null);
		}
	};
	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}

//인증번호확인
function fn_certiconfirm(e, $this){

	var certiNum = $.trim($("input[name=certiNum]").val());

	if(certiNum == ""){
		alert("인증번호를 입력하세요.");
		$("input[name=certiNum]").focus();
		return;
	}

	var to = $.trim($("input[name=mbrId]").val());

	if(to == ""){
		alert("단체를 대표하는 이메일을 입력하세요.");
		$("input[name=mbrId]").focus();
		return;
	}

	if(!checkEmail(to)) {
	    alert("단체를 대표하는 이메일 형식이 올바르지 않습니다.");
	    $("input[name=mbrId]").focus();
	    return;
	}

	var url = '<c:out value="/mail/confirmCerti.json"/>';
	var submitData = {
		emil : to,
		cceCd : certiNum,
		oztnNm :$("input[name=oztnNm]").val()
	};

	var callback = function(data) {
		var result = data.result;
		if(result == true){
			$("#certiconfirmMsg").html("인증에 성공하였습니다.");
			$("#c_ceoEmil").val(data.emil);//아이디
			$("#c_certiNum").val(data.cceCd);//인증번호
			$("#c_oztnNm").val(data.oztnNm);//단체명
			$("input[name=certiNum]").val("");
			$("#agree").trigger("change");
		}else{
			$("#certiconfirmMsg").html("인증에 실패하였습니다.");
			$("#c_ceoEmil").val("");
			$("#c_certiNum").val("");
			$("#c_oztnNm").val("");
			$("input[name=certiNum]").val("");
		}
	}
	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}

//이메일 정규식 체크
function checkEmail(email){
	if($.trim(email) == "") return false;
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regEmail.test(email);
}


//입주업체조회
function fn_comSearch(e, $this){
	var reqOztnNm = $("#reqOztnNm").val();

	if($.trim(reqOztnNm) == ""){
		alert("검색어를 입력하십시오.");
		$("#reqOztnNm").focus();
		return;
	}

	var url = '<c:out value="/member/selectOccupantList.json"/>';
	var submitData = {
		oztnNm : reqOztnNm,
		aplyPgrCd : "${result.aplyPgrCdFordecide}"//입주신청상태 --> 확정코드(022003)
	};

	$("#popComSelect .seaLstBox").empty();
	var callback = function(data) {
		//-------------- list start  -----------------
		var resultList = data.resultList;
		if (resultList && resultList.length > 0) {
			$("#popComSelect .seaLstBox").show();
			$("#popComSelect .seaResult").hide();
			var $ul = $("<ul></ul>");
			$.each(resultList, function(i) {
				if (i != 0 && i % 3 == 0)  {
					$("#popComSelect .seaLstBox").append($ul);
					$ul = $("<ul></ul>");
				}
				this.index = i+1;
				var li = "<li onclick=\"fn_selOccupant(this);\"><p class=\"biz\">"+this.oztnNm+"</p><p class=\"crew\">"+this.ceoNm+"</p></li>";
				var $li = $(li);
				$li.data("data",this);
				$ul.append($li);
			});
			if($ul.find("li").length > 0){
				$("#popComSelect .seaLstBox").append($ul);
			}
		}else{
			$("#popComSelect .seaLstBox").hide();
			$("#popComSelect .seaResult").show();
		}
		//-------------- list end  -----------------
	}
	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}

//blog 중복체크
function fn_blogDoubleCheck(e, $this){
	 var blog = $.trim($("input[name='blog']").val());
	 var blogCnt = blog.length;

	 if( $.isNumeric(blog) == true || /^[A-Za-z0-9]{3,20}$/.test(blog) == false){
		 alert("영문,숫자조합 3~20자 이내로 입력하십시오.");
		 $("input[name='blog']").focus();
		 return;
	 }
	var url = '<c:out value="/member/isExistBlog.json"/>';
	var submitData = {
		blog : $("input[name='blog']").val()
	};

	var callback = function(data) {
		var isExistBlog = data.isExistBlog;

		if(isExistBlog == false){
			$("#v_blog").html($("input[name='blog']").val());
			layer_open('popBlogDoubleCheck');
		}else{
			alert("이미 사용중인 주소입니다.");
		}
	}
	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}


//입주업체조회 입주업체 선택시
function fn_selOccupant(thisObj){
	var data = $(thisObj).data("data");
	$("input[name=oztnNm]").val(data.oztnNm);
	$("input[name=mbrId]").val(data.ceoEmil);
	con_occupantCom = data;

	$("#c_ceoEmil").val("");
	$("#c_certiNum").val("");

	//업종 select
	$("input[name=svcAct]").prop("checked",false);
	if(data.mvinAplyCtgrList){
		var mvinAplyCtgrList = data.mvinAplyCtgrList;
		for (var i = 0, len = mvinAplyCtgrList.length; i < len; i++) {
			$("input[name=svcAct][value="+mvinAplyCtgrList[i].ctgrIdx+"]").trigger("click");
		}
	}

	// 입주그룹 선택
	$('select[name=oztnTypCd] option[value=' + data.oztnTypCd + ']').prop('selected', true);

	layer_close();
}

//태그 이벤트
function fn_tagEvent(e, $this){
	var type = e.type;
	var thisVal = $.trim($this.val());

       if (e.which == 32 || e.which == 8 || e.which == 46 || e.which == 13){//space bar : 32, backspace : 8, del key : 46
       	if (e.which == 32 || e.which == 13){

       		$this.val('');

       		var isExist = false;
       		$.each($("#tagArea a"), function (index, file) {
				var data = $(this).data("data");
       			if(thisVal == data.tagNm){
       				isExist = true;
       				return false; // break;
       			}
       		});

       		if(isExist == false && thisVal != ""){
   				fn_tagCreate("",thisVal);
       		}
       	}
       }
}

//태그추가
function fn_tagCreate(ord, tagNm){
	var btn = "<a href=\"javascript:void(0);\" class=\"btnTag\" onclick=\"fn_removeTag(this);\">#"+tagNm+"</a>";
  	var $btn = $(btn);

	var data = {
		tagLocCd : con_relateMemberCode,
		ord : ord,
		tagNm : tagNm
	}
  	$btn.data("data",data);
	$("#tagArea").append($btn);
}

//태그 지움
function fn_removeTag(thisObj){
	$(thisObj).remove();
}

var map;
var markers = [];
function fn_googleMap(){
	// Try HTML5 geolocation.
	var pos = null;
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			pos = {
				lat: position.coords.latitude,
				lng: position.coords.longitude
			};
	    }, function() {
	    });
	}

	map = new google.maps.Map(document.getElementById('googleMap'), {
    	center: (pos != null)? pos : {lat: 37.565, lng: 126.975},
		disableDoubleClickZoom :  true ,
    	zoom: 13
  	});
	google.maps.event.addListener(map, 'dblclick', function(event) {
		deleteMarkers();
		addMarker(event.latLng);
	});
}

//Adds a marker to the map and push to the array.
function addMarker(location) {
	var marker = new google.maps.Marker({
		position: location,
		map: map
	});

	markers.push(marker);
	var lat = markers[0].position.lat().toFixed(3);
	var lng = markers[0].position.lng().toFixed(3);

	document.getElementById('locLat').value = lat;
	document.getElementById('locLng').value = lng;
	document.getElementById('mapLocTxt').innerHTML = "위도 "+lat+"    경도 "+ lng;
}

//Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}
// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setMapOnAll(null);
}
// Shows any markers currently in the array.
function showMarkers() {
  setMapOnAll(map);
}
// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}

//태그 지움
function fn_locationEvent(e,$this){
		var selCode = $("input[name='locTypCd']:checked").val();
		if(selCode == "016001"){//구글맵설정
			$("#locTypCd_imgArea").hide();
			$("#locTypCd_mapArea").show();
		}else if(selCode == "016002"){//이미지등록
			$("#locTypCd_imgArea").show();
			$("#locTypCd_mapArea").hide();
		}
}

//
function fn_ValidUrl(str) {
	  var expUrl = /^http[s]?\:\/\//i;

	  if(!expUrl.test(str)) {
	    return false;
	  } else {
	    return true;
	  }
}

//채널추가
var channels = {};
<c:forEach var="item" items="${result.channels}">
   channels["${item.cmmnCd}"] = "${item.cmmnCdNm}";
</c:forEach>
function fn_channelCreate(cnlTypCd, cnlUrl){

	var imgSrc = "";
	if(cnlTypCd == "017001"){//홈페이지
		imgSrc = "ico_homepage.png";
	}else if(cnlTypCd == "017002"){//페이스북
		imgSrc = "ico_facebook.png";
	}else if(cnlTypCd == "017003"){//트위터
		imgSrc = "ico_twitter.png";
	}else if(cnlTypCd == "017004"){//카카오스토리
		imgSrc = "ico_kakao_story.png";
	}else if(cnlTypCd == "017005"){//인스타그램
		imgSrc = "ico_insta.png";
	}else if(cnlTypCd == "017006"){//유투브
		imgSrc = "ico_youtube.png";
	}else if(cnlTypCd == "017007"){//네이버블로그
		imgSrc = "ico_blog.png";
	}else if(cnlTypCd == "017008"){//직접입력
		imgSrc = "ico_etc.png";
	}
	var btn = "";
	btn += "<div>";
	btn += "<img src=\"../img/util/"+imgSrc+"\" alt=\""+channels[cnlTypCd]+"\"/><span class=\"channel\"><strong>"+channels[cnlTypCd]+"</strong></span>";
	btn += "<span class=\"\">"+cnlUrl+"<a href=\"javascript:void(0);\" class=\"btnChaDel\" onclick=\"fn_removeChannel(this);\">>삭제</a></span>";
	btn += "</div>";

	var $btn = $(btn);

	var data = {
		//mbrIdx : con_mbrIdx,
		cnlTypCd : cnlTypCd,
		cnlUrl : cnlUrl
	};

	$btn.data("data",data);
	$("#channelArea").append($btn);
}

function fn_removeChannel(thisObj){
	$(thisObj.parentNode.parentNode).remove();
}

function fn_channelAdd(){

	var $option = $("select[name='channels'] option:selected")
	var cnlTypCd = $option.val();
	var cnlUrl = $.trim($("input[name='channelUrl']").val());

	if(cnlUrl == ""){
		alert("URL정보를 입력하십시오.");
		$("input[name='channelUrl']").focus();
		return;
	}else if(!fn_ValidUrl(cnlUrl)){
		alert("타당한 URL정보를 입력하십시오.");
		$("input[name='channelUrl']").focus();
		return;
	}

	var validResult = true;

	$.each($("#channelArea > div"), function (index, file) {

		var data = $(this).data("data");
		if(data.cnlTypCd == cnlTypCd){
			validResult = false;
			alert("이미 추가되었습니다.");
			$("input[name='channelUrl']").focus();
			return false; // break;
		}
	});

	if(validResult == false) return;
	$("input[name='channelUrl']").val("");

	fn_channelCreate(cnlTypCd, cnlUrl);
}


function fn_saveMember(){

	var isSelectedMap = ($("input[name='locTypCd']:checked").val() == "016001");

	//멤버정보수정이 완료되었습니다.
	var url = '<c:out value="/member/insertMember.json"/>';
	var submitData = {
		mbrTypCd :con_memberType,
		mbrId : con_occupantCom.ceoEmil,
		oztnNm :con_occupantCom.oztnNm,
		ceoNm :con_occupantCom.ceoNm,
		mbrPwd : $("input[name='mbrPwd']").val(),//비밀번호
		//oztnTypCd : $("select[name='oztnTypCd']").val(),//입주그룹
		svcActList : [],//업종
		ofcPhn : $("input[name='ofcPhn']").val(),//대표전화
		ceoPhn : $("input[name='ceoPhn']").val(),//대표휴대전화
		oztnAddr : $("input[name='oztnAddr']").val(),//단체주소
		blog : $("input[name='blog']").val(),
		oztnImgPath: $("input[name='oztnImgPath']").val(),   	//대표이미지
		oztnImgInfo: $("input[name='oztnImgInfo']").val(),      //대표이미지 설명
		oztnSlg: $("input[name='oztnSlg']").val(),            //단체슬로건
		oztnItdc: $("textarea[name='oztnItdc']").val(),            //업체소개
		locTypCd: $("input[name='locTypCd']:checked").val(),            //위치정보종류 공통코드(016)
		locLat: (isSelectedMap == true)? $("input[name='locLat']").val() : "",                //위도
		locLng: (isSelectedMap == true)? $("input[name='locLng']").val() : "",                //경도
		locImgPath: (isSelectedMap == false)? $("input[name='locImgPath']").val(): "",        //위치이미지
		locImgInfo: (isSelectedMap == false)? $("input[name='locImgInfo']").val(): "",        //위치이미지 정보'
		newsLttrYn: ($("input[name='newsLttrYn']").is(":checked") == true)? "Y":"N",  //뉴스레터 수신여부
		tagList : [],
		attachTagList : [],
		channelList : []
	};

console.log("	isSelectedMap >> " +isSelectedMap);

console.log("	submitData.locTypCd >> " +submitData.locTypCd);
console.log("	submitData.locLat >> " +submitData.locLat);
console.log("	submitData.locLng >> " +submitData.locLng);

	$.each($("input[name=svcAct]:checked"), function (index, file) {
		submitData.svcActList.push($(this).val());
	});

	$.each($("#tagArea a"), function (index, file) {
		var attachData = $(this).data("data");
		attachData.ord = "" + (index + 1);
		submitData.attachTagList.push(attachData);
		var tagData = $.extend({}, attachData);
		tagData.tagCnt = "0";
		delete tagData['ord'];
		delete tagData['tagLocIdx'];
		delete tagData['tagLocCd'];
		submitData.tagList.push(tagData);
	});

	$.each($("#channelArea > div"), function (index, file) {
		submitData.channelList.push($(this).data("data"));
	});

	var callback = function(data) {
		alert("혁신멤버가입이 완료되었습니다.");
		fn_goUrl('/member/join_complete.do?mbrIdx=' + data.params.mbrIdx);
	}

	ajaxSubmit(url, JSON.stringify(submitData), callback, null);
}

//회원가입
function fn_insertMember(){
 	var validResult =  $("#form").valid();
	if(validResult == false) return;
	fn_saveMember();
}

//회원가입 취소
function fn_conceal(){
	fn_goUrl('/member/memberselect.do');
}
</script>
<!--
<button type="button" class="btnLineSmall ml_10" onclick="layer_open('popComSelect');">popComSelect</button>1017 수정
<button type="button" class="btnLineSmall ml_10" onclick="layer_open('popCertiNum');" >popCertiNum</button>1017 수정
<button type="button" class="btnLineSmall ml_10" onclick="layer_open('popBlogDoubleCheck');" >popBlogDoubleCheck</button>1017 수정
 -->
<form method="post" id='form'>
<input id="c_ceoEmil" type="hidden"><%--아이디--%>
<input id="c_certiNum" type="hidden"><%--인증번호--%>
<input id="c_oztnNm" type="hidden"><%--단체명--%>

<!-- maincon -->
<div id="maincon_none"><!-- 백그라운드 이미지 없는 경우 -->
	<div id="container">
		<div class="joinArea">

			<div class="termsBox"><!-- 인증/약관동의 테이블-->
				<div class="teTit"><!-- teTit 토글 타이틀 -->
					<a href="javascript:void(0);"><p class="on">인증/약관동의 (필수)</p></a>
				</div>
				<div class="teCon"><!-- teCon 토글 내용 -->
					<table class="joinTbl">
						<caption>인증/약관동의</caption>
						<colgroup>
							<col width="125px"></col>
							<col width=""></col>
						</colgroup>
						<tr class="bdb_01">
							<th>단체명</th>
							<td>
								<input type="text" name="oztnNm" placeholder="단체명, 프로젝트명" style="width:254px;" readonly="readonly"><!-- 1017 수정 -->
								<button type="button" id="btn_popComSelect" class="btnLineSmall ml_10" >단체조회</button><!-- 1017 수정 -->
							</td>
						</tr>
						<tr class="bdb_01">
							<th style="vertical-align:top; padding-top:20px;">아이디</th>
							<td>
								<p>
									<input type="text" name="mbrId" placeholder="단체를 대표하는 이메일" style="width:254px;" readonly="readonly"><!-- 1017 수정 -->
									<button type="button" id="btn_popCertiNum" class="btnLineSmall ml_10">인증번호 받기</button>
								</p>
								<p class="mt_8">
									<input type="text" id="certiNum" name="certiNum" placeholder="인증번호 (5분 이내 입력)" class="inp_basic" style="width:254px;">
									<button type="button" id="btn_certiconfirm" class="btnLineSmall_77 ml_10">확인</button>
									<span class="fc_01 pl_10" id="certiconfirmMsg"></span>
								</p>
							</td>
						</tr>
					</table><!-- /joinTbl -->

					<div class="mt_20"><!-- 이용약관 동의 -->
						<p><input type="checkbox" name="agree" id="agree" value="agree"/><label id="label01" for="agree">이용약관 동의</label></p>
						<textarea class="tarea_basic mt_20" readonly="readonly"><%@include file="/WEB-INF/views/include/terms_use.jsp" %></textarea>
					</div>
					<div class="mt_20"><!-- 개인정보수집 동의 -->
						<p><input type="checkbox" name="agree_02" id="agree_02" value="agree_02"/><label for="agree_02">개인정보 수집 및 이용 동의</label></p>
						<textarea class="tarea_basic mt_20" readonly="readonly"><%@include file="/WEB-INF/views/include/terms_privacy.jsp" %></textarea>
					</div>
					<div class="mt_20"><!-- 대관 운영규정 동의 -->
						<p><input type="checkbox" name="agree_03" id="agree_03" value="agree_03"/><label for="agree_03">대관 운영규정 동의</label></p>
						<textarea class="tarea_basic mt_20" readonly="readonly"><%@include file="/WEB-INF/views/include/terms_rent.jsp" %></textarea>
					</div>
				</div><!-- /teCon -->
			</div><!-- /termsBox -->

			<div class="termsBox"><!-- 기본정보 테이블 -->
				<div class="teTit"><!-- teTit 토글 타이틀 -->
					<a href="javascript:void(0);"><p class="on">기본 정보(필수)</p></a>
				</div>
				<div class="teCon mt_10"><!-- teCon 토글 내용 -->
					<table class="joinTbl">
						<caption>기본 정보</caption>
						<colgroup>
							<col width="125px"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<th>아이디</th>
							<td><span id="v_ceoEmil"></span></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="mbrPwd" placeholder="영문, 숫자,특수문자 포함한 8자 이상" class="inp_basic" style="width:254px;" maxlength="20">
								<span class="fc_01 pl_10" id="mbrPwdMsg"></span>
							</td>
						</tr>
						<tr>
							<th>비밀번호재확인</th>
							<td>
								<input type="password" name="mbrPwdCheck" placeholder="영문, 숫자,특수문자 포함한 8자 이상" class="inp_basic" style="width:254px;" maxlength="20">
							</td>
						</tr>
						<tr>
							<th>단체명</th>
							<td><span id="v_oztnNm"></span></td>
						</tr>
						<tr>
							<th>입주그룹</th>
							<td>
								<div style="width:250px;"><!-- 셀렉트 -->
									<div class="styledSelect">
									   <select name="oztnTypCd" disabled="disabled">
										  <option value="">선택</option>
										<c:forEach var="item" items="${result.oztnTypCds}">
										    <option value="${item.cmmnCd}" <c:if test="${item.cmmnCd == '025001'}">selected="selected"</c:if>>${item.cmmnCdNm}</option>
										</c:forEach>
									   </select>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<c:set var="rowspan" value="${fn:length(result.svcActs)/5}"/>
							<th rowspan="<fmt:parseNumber value="${rowspan+(1-(rowspan%1))%1}" integerOnly="true" type="number" />" style="vertical-align:top; padding-top:20px;">업종</th>
							<td>
								<c:forEach var="item" items="${result.svcActs}" varStatus="status">
								    <input type='checkbox' name="svcAct" id="biz_cate_${status.count}" value='${item.ctgrIdx}'>
								    <label for="biz_cate_${status.count}" class="mr_20">${item.ctgrNm}</label>
								    <c:if test="${status.count%5 == 0}"></td></tr><tr><td></c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th>대표자성명</th>
							<td><span id="v_ceoNm"></span></td>
						</tr>
						<tr>
							<th>대표전화</th>
							<td>
								<input type="text" name="ofcPhn" placeholder="" class="inp_basic" style="width:254px;">
							</td>
						</tr>
						<tr>
							<th>대표휴대전화</th>
							<td>
								<input type="text" name="ceoPhn" placeholder="" class="inp_basic" style="width:254px;">
							</td>
						</tr>
						<tr>
							<th>단체주소</th>
							<td>
								<input type="text" name="oztnAddr" placeholder="" class="inp_basic" style="width:100%;"><!-- 1017 수정 -->
							</td>
						</tr>
						<tr>
							<th>블로그</th>
							<td>
								<span class="pr_10">blog.innovationpark.kr/</span>
								<input type="text" name="blog" placeholder="영문,숫자조합 3~20자 이내" class="inp_basic" style="width:254px;" maxlength="20">
								<button type="button" id="btn_blogDoubleCheck" class="btnLineSmall ml_10">중복확인</button>
								<input type="hidden" id="c_blog" name="c_blog" value="">
							</td>
						</tr>
					</table><!-- /joinTbl_02 -->

				</div><!-- /teCon -->
			</div><!-- /termsBox -->


			<div class="termsBox"><!-- 부가정보 테이블 -->
				<div class="teTit"><!-- teTit 토글 타이틀 -->
					<a href="javascript:void(0);"><p class="on">부가 정보</p></a>
				</div>
				<div class="teCon mt_10"><!-- teCon 토글 내용 -->
					<table class="joinTbl">
						<caption>부가 정보</caption>
						<colgroup>
							<col width="125px"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<th style="vertical-align:top; padding-top:20px;">단체대표이미지</th>
							<td>
								<div id="oztnImgAddArea" class="imgAdd fl"><!-- 1017 수정 -->
									<a href="javascript:void(0);" onclick="fn_fileSelect('oztnImgPathFile');">
										<strong>NO IMAGE</strong>
									</a>
								</div>
								<div id="oztnImgUploadedArea" class="picBox fl" style="display: none;">
									<a href="javascript:void(0);" class="btnDelPic" onclick="fn_fileRemove('oztnImgPath');"></a><!-- 등록이미지 삭제버튼 -->
									<img id="oztnImg" src="" alt="" width="114px" height="114px"/>
								</div>
								<input id="oztnImgPathFile" class="file" data-input="false" type="file" name="reqUploadFile" data-url="/file/uploadFile.json" multiple>
								<input type="hidden" id="oztnImgPath" name="oztnImgPath" value="">
								<p class="tipTxt_02 mt_50 fl">(Size/20MB)</p>
								<p><input type="text" name="oztnImgInfo" placeholder="이미지의 간략한 설명 20자 이내" class="inp_basic mt_10" style="width:100%;" maxlength="20"></p>
							</td>
						</tr>
						<tr>
							<th>단체슬로건</th>
							<td>
								<input type="text" name="oztnSlg" placeholder="50자 이내" class="inp_basic" style="width:100%;" maxlength="50">
							</td>
						</tr>
						<tr>
							<th style="vertical-align:top; padding-top:20px;">단체소개</th>
							<td>
								<textarea name="oztnItdc" class="tarea_basic_02 mb_5"></textarea>
								<span class="tipTxt_02"><span class="tipTxt">0</span> / 500자</span>
							</td>
						</tr>
						<tr>
							<th style="vertical-align:top; padding-top:20px;">태그</th>
							<td>
								<input type="text" name="tagNms" placeholder="태그 입력 후 스페이스바를 누르면 입력 됩니다." class="inp_basic" style="width:100%;">
								<p id="tagArea">
									<!-- <a href="" class="btnTag">#혁신파크</a><a href="" class="btnTag">#제안</a> -->
								</p>
							</td>
						</tr>
						<tr>
							<th>위치정보</th>
							<td>
								<c:forEach var="item" items="${result.locTypCds}" varStatus="status">
			    					<input type="radio" name="locTypCd" id="locTypCd_${status.count}" value='${item.cmmnCd}'>
			    					<label for="locTypCd_${status.count}"  class="mr_20">${item.cmmnCdNm}</label>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="locTypCd_mapArea">
								<div id="googleMap" class="imaAdd_02 mb_10" style="padding-top:0px;"><!-- 1017 수정 -->
								</div>
								<span class="tipTxt_02" id="mapLocTxt">&nbsp;</span>
								<input type="hidden" id="locLat" name="locLat" value="">
								<input type="hidden" id="locLng" name="locLng" value="">
							</td>
							<td id="locTypCd_imgArea" colspan="2" style="display: none;">
								<div id="locImgAddArea" class="imaAdd_02 mb_10"><!-- 1017 수정 -->
									<p class="fs_40"><strong>NO IMAGE</strong></p>
									<p class="fs_14">(최적화 이미지 사이즈 900x385px / 20MB)</p>
									<a href="javascript:void(0);" onclick="fn_fileSelect('locImgPathFile');"></a>
								</div>
								<div id="locImgUploadedArea" class="picBox_02 mb_10" style="display: none;">
									<a href="javascript:void(0);" class="btnDelPic" onclick="fn_fileRemove('locImgPath');"></a><!-- 등록이미지 삭제버튼 -->
									<img id="locImg" src="" alt="" width="900px" height="385px">
								</div>

								<input type="text" name="locImgInfo" placeholder="이미지의 간략한 설명 20자 이내" class="inp_basic" style="width:100%;">
								<input id="locImgPathFile" class="file" data-input="false" type="file" name="reqUploadFile" data-url="/file/uploadFile.json" multiple>
								<input type="hidden" id="locImgPath" name="locImgPath" value="">
							</td>
						</tr>
						<tr>
							<th style="vertical-align:top; padding-top:20px;">타채널정보</th>
							<td>
								<div class="fl" style="width:152px;"><!-- 셀렉트 / 셀렉트 너비값을 넣어주세요. -->
									<div class="styledSelect">
										<select name="channels">
										<c:forEach var="item" items="${result.channels}">
										    <option value="${item.cmmnCd}">${item.cmmnCdNm}</option>
										</c:forEach>
										</select>
									</div>
								</div>
								<input type="text" name="channelUrl" placeholder="http(s)://로 시작하는 url입력" class="inp_basic ml_5" style="width:515px;">
								<button type="button" class="btnLineSmall ml_5" onclick="fn_channelAdd();"><span class="ico_plus">채널추가</span></button>
								<div class="mt_10" id="channelArea">
								</div>
							</td>
						</tr>
						<tr>
							<th>뉴스레터</th>
							<td>
								<input type="checkbox" name="newsLttrYn" id="newsLttrYn" value=""/><label for="newsLttrYn" class="mr_7">수신</label>
								<span class="tipTxt_02">서울혁신파크 소식을 전달하는 정기발행물 입니다.</span>
							</td>
						</tr>
					</table><!-- /joinTbl_02 -->

				</div><!-- /teCon -->
			</div><!-- /termsBox -->

			<div class="btnWrap mt_30"><!-- 버튼 -->
				<button type="button" class="btnLineBig_156" onclick="fn_insertMember();">확인</button>
				<button type="button" class="btnGrayBig_156 ml_5" onclick="fn_conceal();">취소</button>
			</div>

		</div><!-- /joinArea -->
	</div><!-- /container -->
</div>
<!-- /maincon_none -->

	<!-- 레이어팝업 -->
	<div class="layer">
		<div class="bg"></div>
		<!-- 입주업체조회:레이어팝업 -->
		<!-- popup 종류  layer, alert,confirm,-->

		<!-- 입주업체조회:레이어팝업 -->
		<div id="popComSelect" class="pop-layer"><!-- 1017 수정 : 아이디명-->
			<h1>입주단체조회</h1><!-- 1017 수정 -->
			<div><a href="javascript:void(0);" class="btnClose"><img src="../img/common/ico_close.png" alt="닫기"/></a></div>
			<div class="popcon" style="width:530px;">
				<div class="searchBox">
					<div class="popSearch">
						<input type="text" id="reqOztnNm" placeholder="단체명" class="inp_pop_basic">
						<button type="button" id="btn_comSearch" class="btnSearch">검색</button>
					</div>
					<!-- 조회결과리스트-->
					<div class="seaLstBox" style="display: none;"></div>
					<!--/조회결과리스트-->

					<!--조회결과없을때-->
					<div class="seaResult" style="display: none;">
						조회결과가 없습니다.
					</div>

				</div>
			</div>
		</div>
	</div>
	<!--  /입주업체조회:레이어팝업-->


	<!-- 인증번호받기:레이어팝업-->
	<div class="layer">
		<div class="bg"></div>
		<div id="popCertiNum" class="pop-layer" data-type="alert"><!-- 1017 수정 : 아이디명-->
			<div class="popcon_02" style="width:340px;">
				<div class="logBox_03">
					<p class="result">
					<span id="emailTo"></span> 로<br/>인증번호가 발송되었습니다.<br/>5분이내에 인증번호를 입력하십시오.
					</p>
				</div>
				<div class="popBtnWrap">
					<button type="button" class="btnPopBlack btnClose">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!--  /인증번호받기:레이어팝업-->
	<!-- 블로그주소 중복확인:레이어팝업 -->
	<div class="layer">
		<div class="bg"></div>
		<div id="popBlogDoubleCheck" class="pop-layer" data-type="confirm">
			<div class="popcon_02" style="width:340px;">
				<div class="logBox_04">
					<p class="result">
					<span id="v_blog"></span> 은 사용 가능한 주소입니다.<br/>블로그 주소로 사용하시겠습니까?
					</p>
				</div>
				<div class="popBtnWrap_02">
					<button type="button" class="btnOk btnPopGreen_50 fl">예</button>
					<button type="button" class="btnNo btnPopBlack_50 fl">아니오</button>
				</div>
			</div>
		</div>
	</div>
	<!--  /블로그주소 중복확인:레이어팝업-->
	<!--  /레이어팝업-->
</form>
