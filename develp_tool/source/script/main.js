var agent = navigator.userAgent.toLowerCase();
var ie = false;
if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	ie = true;
}

function ajaxSubmit(url, data, success_callback, ar_callbackCode) {
	var queCode = pageLoadQue();

	if (!ar_callbackCode) {
		ar_callbackCode = ['0000'];
	}

	if (!success_callback) {
		success_callback = function() {};
	}

	var opt = {
		url: url,
		dataType: 'json',
		method: 'POST',
		data: data,
		success: function(data, textStatus, jqXHR) {
			var resultCode = data.resultCode;

			if ($.inArray(data.resultCode, ar_callbackCode) === -1) {
				var msg = data.msg;
				if (msg) {
					alert(msg);
				} else if (messageSource['result.code.' + resultCode]) {
					alert(messageSource['result.code.' + resultCode]);
					if(resultCode == '0014') success_callback(data);
				}
			} else if (data.resultCode == '9999') {
				alert(messageSource['result.code.' + resultCode]);
			} else {
				success_callback(data);
			}
		},
		statusCode: {
			401: function(){
				alert('로그인 필요');
			},
			403: function(){
				alert('로그인 필요');
			}
		},
		error: function(xhr, status, err) {
			if (!xhr || !xhr.status || (xhr.status != 403 && xhr.status != 401)) {
				//alert('error');
			}
		},
		complete: function(){
			pageLoadQue(queCode);
		}
	};

	if(jQuery.type(data) === "string"){
		opt.contentType = "application/json";
	}

	$.ajax(opt);

}

function pageLoadQue(queCode) {
	var ques = $(document).data('ques');

	if (!ques) {
		$(document).data('ques', []);
		ques = $(document).data('ques');
	}

	if (queCode) {
		var queIndex = $.inArray(queCode, ques);
		if (queIndex !== -1) {
			ques.splice(queIndex, 1);
		}
	} else {
		var rnd = rand(100000, 999999);
		queCode = new Date().getTime() + '_' + rnd;

		ques.push(queCode);
	}

	if (ques.length) {
		pageLoad();
	} else {
		$.unblockUI();
	}

	return queCode;
}

function rand(min, max){
	var rand = Math.ceil((max - min + 1) * Math.random() + min);

	return rand;
}

function pageLoad() {
	if (!$('.loading').length) {
		$('body').append('<img src="/img/loading.png" class="loading" />');
	}

	$.blockUI({
		message: $('.loading'),
		css: {
			backgroundColor: '',
			border: 0
		},
		overlayCSS: {
			opacity: 0.5
		}
	});
}


function layer_open(el, func){

    var temp = $('#' + el);
    var bg = temp.prev().hasClass('bg');   //dimmed 레이어를 감지하기 위한 boolean 변수

    if(bg){
       temp.parents('.layer:first').fadeIn();   //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다.
    }else{
       temp.fadeIn();
    }

    // 화면의 중앙에 레이어를 띄운다.
    if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
    else temp.css('top', '0px');
    if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
    else temp.css('left', '0px');

	if(func && func instanceof Function ){
		func.apply(null,[]);
	}
}

function layer_close(el) {
	if(el){
		$('#' + el).trigger('layerClose').parents(".layer").fadeOut();
	}else{
		$(".pop-layer").trigger('layerClose').parents(".layer").fadeOut();
	}
}

// 상단타이틀
function header_title(titl) {
	$('#header .headerArea h2').text(titl);
}

function mobile_header_title(titl) {
	$('header.site-header>h1 span').text(titl);
}

function ckConfig(opt) {
	var conf = {
		toolbar: [
			{ name: 'document', items: [ 'Source', '-', 'NewPage', 'Preview', 'Print', '-', 'Templates' ] },
			{ name: 'clipboard', items : [ 'Paste','PasteText','-','Undo','Redo' ] },
			{ name: 'colors', items : [ 'TextColor','BGColor' ] },
			{ name: 'insert', items : [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] },
			{ name: 'tools', items: [ 'Maximize' ] },
			{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
			'/',
			{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
			{ name: 'links', items : [ 'Link','Unlink' ] },
			{ name: 'styles', items : [ 'Styles', 'lineheight', 'Format','Font','FontSize' ] }
		],
		//contentsCss: '/css/style.css',
		enterMode: CKEDITOR.ENTER_DIV,
		extraPlugins: 'uploadimage,image2,lineheight',
		filebrowserUploadUrl: '/file/editor_upload.do',
		'line_height': '50%;80%;100%;120%;140%;160%;180%;200%'
	};

	if (opt) {
		$.extend(conf, opt);
	}

	CKEDITOR.on( 'dialogDefinition', function( ev ) {
	      // Take the dialog name and its definition from the event data.
		var dialogName = ev.data.name;

		if(dialogName == 'image2'){//이미지 속성창
			var dialogDefinition = ev.data.definition;
			var dialog = ev.data.definition.dialog;

			dialog.on('show', function () {
				if(this["data-once"] != "Y"){
					this["data-once"] = "Y";
					$(".cke_dialog_body .cke_dialog_contents .cke_dialog_ui_vbox_child .cke_dialog_ui_labeled_label").last().text("서버로 전송 20MB");
				}
			});
		}
	});

	return conf;
}

// 파일다운로드
function fileDownload(filePath) {
	if (!$('body').is(':has(iframe#downloadIframe)')) {
		$('body').append('<iframe id="downloadIframe" class="hidden"></iframe>');
	}

	$('iframe#downloadIframe').attr('src', '/cmmn/file_download.do?filePath=' + filePath);
}

function executeCondition(bFunction, callback, arg){
	var tf = arguments.callee;

	if(!arg) arg = {};
	if(!arg["cnt"]) arg["cnt"] = 0;
	if(!arg["timeout"]) arg["timeout"] = 5000;

	arg["cnt"]++;

	if(bFunction()){
		callback(arg);
		return;
	}else{
		if(arg["cnt"]*100 > arg["timeout"]){
			if(!arg["onTimeout"]) arg["onTimeout"] = function(){};

			arg["onTimeout"](arg);
			return;
		}

		setTimeout(function(){
			tf(bFunction, callback, arg);
		}, 100);
	}
}

// 페이스북공유
function shareFacebook() {
	window.open('http://www.facebook.com/sharer/sharer.php?u=' + location.href);
}

// 네이버공유
function shareNaver(title) {
	var url = encodeURI(encodeURIComponent(location.href));
    var titl = encodeURI(title);
    var shareURL = "http://share.naver.com/web/shareView.nhn?url=" + url + "&title=" + titl;
    window.open(shareURL);
}

// 카카오공유
function shareKakao() {
	var url = encodeURIComponent(location.href);

	window.open('https://story.kakao.com/share?url=' + url);
}

// url복사
function copyUrl() {
	prompt('컨트롤 + c 를 눌러서 복사하세요.', location.href);
}

(function ($) {
    $.fn.serializeFormJSON = function () {

        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

 // 숫자
    $.fn.onlyNumber = function (p) { // 숫자만, 1: 소숫점, 2: 마이너스, 3: 마이너스 소숫점
        $(this).each(function(i) {
        	$(this).off('keypress keyup');

        	$(this).on('keypress keyup',function(e){
        		var val = $(this).val();
            	var regexp = /[^-\.0-9]/g;
            	var repexp = "";
            	var len = 3;
            	val = val.replace(regexp,repexp);
            	if(val.split(".").length > 1){
            		val = val.split(".")[0] +"."+ val.split(".")[1].substr(0,len);
        	    }

            	var newval;
                switch (p) {
				case 1:
					regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
					repexp = '$2$3$5';
					break;
				case 2:
					regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;
					repexp = '$1$2$4';
					break;
				case 3:
					regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
					repexp = '$1$2$3$5';
					break;

				default:
					regexp = /[^0-9]/g;
					repexp = '';
					break;
				}

                var newval = val.replace(regexp,repexp);

                if ($(this).val() != newval) {
                	$(this).val(newval);
				}
            });
        });
    };
})(jQuery);

jQuery(function($){
	$.unblockUI();

	$('input, textarea').placeholder();

	// datepicker default
	$.datepicker.setDefaults({
		dateFormat: 'yy.mm.dd',
		numberOfMonths: 1,
		buttonImageOnly: true,
		autoSize: true, //오토리사이즈(body등 상위태그의 설정에 따른다)
		currentText: '오늘 날짜', // 오늘 날짜로 이동하는 버튼 패널
		closeText: '',  // 닫기 버튼 패널
		showMonthAfterYear: true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
		yearSuffix: '',
        dayNamesMin: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'], // 요일
        monthNames: ['.01', '.02', '.03', '.04', '.05', '.06', '.07', '.08', '.09', '.10', '.11', '.12'],
        monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
	});

	$(document).on('click', 'button', function(){
		if (!$(this).is('.btnShare_02') && !$(this).is('.btnShare') ) {
			return false;
		}
	});

	$('form').on('invalid', function(e, obj){
		if ($(obj).is('input:radio') || $(obj).is('input:checkbox')) {
			var offset = $(obj).next('label').offset();

			$('html, body').scrollTop(offset.top);
		}
	});

	$('.btnPrint, .btnPrint_02').on('click', function(){
		print();

		return false;
	});

	//--------------------	 popup event start	--------------------/
	$('.layer').on('click', '.bg', function(e){
		var $temp =  $(this).next();
		var $layer =  $(this).parent();

		var dataType = $.trim($temp.attr("data-type"));
		if(dataType == "") dataType = "layer";

		if(dataType == "layer"){
			$layer.fadeOut();
			$('.layer').fadeOut();
		}else if(dataType == "alert"){
		}else if(dataType == "confirm"){
		}
		e.preventDefault();
	})
	.on('click', '.btnClose', function(e){
		$(e.target).parents(".pop-layer").trigger('layerClose').parents(".layer").fadeOut();

		return false;
	})
	.on('click', '.btnOk', function(e){
		$(e.target).parents(".pop-layer").trigger('layerConfirmClick').parents(".layer").fadeOut();

		return false;
	}).on('click', '.btnNo', function(e){
		$(e.target).parents(".pop-layer").trigger('layerCancelClick').parents(".layer").fadeOut();

		return false;
	});
	//--------------------	 popup event end	--------------------/

	$(window)
	// 페이지 이동시 로딩표시
	.on('beforeunload', function(){
//		if (navigator.userAgent.indexOf('Safari') == -1 || navigator.userAgent.indexOf('Chrome') != -1) {
			pageLoad();
//		}
	})
	// 페이스북 로그인 후 주소창 clean
	.on('load', function(e){
		if (window.location.hash == '#_=_') {
			window.location.hash = ''; // for older browsers, leaves a # behind
			history.pushState('', document.title, window.location.pathname); // nice and clean
			e.preventDefault(); // no page reload
		}
	});

	if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1) {
		$(window)
		.on('pageshow', function(ev){
			if (ev.originalEvent.persisted) {
				location.reload();
			}
		});
	}

	$.validator.setDefaults({
		onkeyup: false,
		onclick: false,
		onfocusout: false,
		showErrors: function(errorMap, errorList) {
			if (this.numberOfInvalids()) {
				alert(errorList[0].message);
				$(errorList[0].element.form).trigger('invalid', [errorList[0].element]);
				$(errorList[0].element).focus();
			}
		}
	});

	//--------------------	 jQuery validator addMethod start	--------------------/
	$.validator.addMethod("lettersonly", function(value, element){
		return this.optional(element) || /^[a-z]+$/i.test(value);
	}, "Letters only please");

	$.validator.addMethod("lettersSpaceonly", function(value, element){
		return this.optional(element) || /^[a-z," "]+$/i.test(value);// accept space
	}, "Letters and spaces only please");
	$.validator.addMethod("pwd", function(value, element){
		 //var chk1 = /^[a-zA-Z\d]{8,20}$/i;  //a-z와 0-9이외의 문자가 있는지 확인
		 var chk1 = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[\^,\~,\!,\@,\#,\%,\$,\*,\(,\),\=,\+,\_,\.,\|,\[,\],\{,\},\<,\>,\`,\?,\/,\:,\;,\-,\&,\',\",\\]).*$/; //a-z와 0-9와 특수문자가 있는지 확인
		 //var chk2 = /[a-zA-Z]/i;  //적어도 한개의 a-z 확인
		 //var chk3 = /\d/;  //적어도 한개의 0-9 확인
		return this.optional(element) || (chk1.test(value));
	}, "password");
	$.validator.addMethod("regx", function(value, element, regexpr) {
	    return this.optional(element) || regexpr.test(value);
	}, "regx");

	$.validator.addMethod('equalOnly', function(value, element, $target){
		return this.optional(element) || $target.val() === value;
	}, 'equalOnly');

	$.validator.addMethod('preventEqual', function(value, element, $target){
		return this.optional(element) || $target.val() !== value;
	}, 'prevent equal');
	//--------------------	 jQuery validator addMethod end	--------------------/
});