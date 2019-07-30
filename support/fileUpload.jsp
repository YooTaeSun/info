<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/js/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="/js/jquery.fileupload.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function(){
	//------------------------- 파일업로드  start -------------------------
	// 파일업로드 옵션 초기화
<%--

------------------------------------------------------------------------

참고 detailEtcForm.jsp

------------------------------------------------------------------------

parentId 없을시 참고
	1. 서버단에서  parentId 구하기
		SecurityAuditController.java

			if(detail.get("ATCH_FILE_ID").isEmpty()) {
				detail.put("ATCH_FILE_ID", detailSvc.updateFileId(detail));
			}

	2. 화면단에서  parentId 구하기
		AttachFileController.java
			@RequestMapping(value="/file/fileId")

------------------------------------------------------------------------

	var opt = {
		"file_0" : {
    		data : {
    			 parentId : '<c:out value="${detail.BASIC_ATCH_FILE_ID}"/>'
    			,overwrite : 'Y' /* 같은이름파일 덮어쓰기 */
    			,storageType : 'DB'  /* DB에 파일 저장 */
    			,histYn : 'N'
    		},
    		fileAdd : function(uploadFileName ,data){
    			$("#viewFileName_0").val(uploadFileName);
    		},
    		fileDone : function(param, fileData){
    			$("#viewFileName_0").val('');
    			 doFileList();
    		}
    	},
		"file_1" : {
    		data : {
    			parentId : '00000000000000000001'
    		},
    		fileAdd : function(uploadFileName ,data){
    			$("#viewFileName_1").val(uploadFileName);
    		},
    		fileDone : function(param, fileData){
    			$("#viewFileName_1").val('');
    		}
    	}
	}

	// 파일업로드 옵션 초기화
	fileUploadObj.init(opt);

	//첨부파일 찾기
	$('[data-file-search^="file_"]').on('click', function(e){
		var fileId = $(e.target).attr("data-file-search");
		$('#fileupload').attr("data-target", fileId)
		.trigger('click');
		return false;
	});

	//첨부파일 업로드 (parentId 나중에 줄때)
	$('[data-file-attach]').on('click', function(e){
		var fileId = $(e.target).attr("data-file-attach");
		$('[data-file-attach]').trigger("uploadEvt", [fileId]);

		/*
		if(fileId == 'file_0'){
			var eval_cd = nvl($("input[name=file_eval_cd]:checked").val(),"");
			var addData = {
				eval_cd : eval_cd
			}
			$('[data-file-attach]').trigger("uploadEvt", [fileId, addData]);
		}
		*/

		e.preventDefault();
	});

	//첨부파일 삭제(하나)
	$('[data-file-delete]').on('click', function(e){
		var data = $(e.target).parents("tr").data("data");
		doRemoveFile(data);
		e.preventDefault();
	});
	// 파일다운로드
	$('[data-file-download]').on('click', function(e){
		var data = $(e.target).parents("tr").data("data");
		fn_download(data['ATCH_FILE_ID'], data['FILE_SN']);
		e.preventDefault();
	});



<button class="btn" data-file-attach="file_0">파일등록</button>
<input type="text" style="width:500px" value="" readonly="readonly" id="viewFileName_0">
<label class="t-btn" for="sample01" data-file-search="file_0">파일찾기</label>

	//------------------------- 파일업로드  end -------------------------
--%>
});

var fileUploadObj = {
	filesObj : {},
	init : function(opt){
		var $e = null;
		if($("div.cont-panel:last").length ==  0 && $("body.popup").length > 0){
			$e = $("body.popup:first");
		}else{
			$e = $("div.cont-panel:last");
		}

		$e.append('<input data-input="false" type="file" id="fileupload" name="reqUploadFile" style="display: none;"/>');

		var filesObj = this.filesObj;

		var $fileupload = $('#fileupload').fileupload({
			targetObj : null,
			autoUpload : false,
			dataType : 'json',
			url : '<c:out value="/file/uploadFile"/>',
	        add : function (e, data) {

	        	var uploadFile = data.files[0];
	        	var uploadFileName = uploadFile.name;

	        	//유효성 체크
				if(uploadFileName.length > 255){
					alert("원본 파일명은 255자 이하 입니다.");
					return;
				}else if(uploadFile.size > (50 * 1024 * 1024)){// 50 mb
					alert("업로드 용량은 50메가를 초과할 수 없습니다.");
					return;
				}

	        	var fileAllowExts = '<c:out value="${fileAllowExts}"/>';
	        	console.log("fileAllowExts >> " + fileAllowExts);

				var pattern = /(\.|\/)(<c:out value="${fileAllowExts}"/>)$/i;

				if (!(pattern).test(uploadFileName)) {
					alert(uploadFileName + " 파일 확장자는 업로드 할 수 없습니다.");
					return;
				}

	           	var opt = $('#fileupload').data('opt');
				var fileId = $('#fileupload').attr("data-target");

				var targetObj = this.targetObj = opt[fileId];

				if(targetObj){
					data.fileId = fileId;
					data.param = targetObj;
					if(targetObj.data){
						targetObj.data.fileId = fileId;
						data.formData = targetObj.data;
					}

					if(targetObj.fileAdd){
						if(filesObj[fileId] == undefined){
							filesObj[fileId] = [];
						}else{
							//마지막 첨부한 파일만 업로드 한다.
							filesObj[fileId][0]= null;
							filesObj[fileId].splice(0, 1);
						}
						filesObj[fileId].push(data);
						targetObj.fileAdd.call(this, uploadFileName, data);
					}
				}

				$('[data-file-attach]').on('uploadEvt', {filesObj : filesObj}, function(e, fileId, addData){

	      	    	var filesObj = e.data.filesObj;
	      	    	var fileList = filesObj[fileId];

	      	    	if(fileList != null && fileList.length > 0){
		      	    	var submitObj =  fileList[0];
						if(addData){
							for ( var e in addData) {
								submitObj.formData[e] = addData[e];
							}
						}
		      	    	submitObj.submit();
	      	    	}
	      	      });
	        },
	        fail : function (e, data) {
	        	try {var data = JSON.parse(data.jqXHR.responseText); if(data && data.msg){alert(data.msg);}} catch (e) {
	        		alert("파일 업로드 도중 에러가 발생했습니다.");
				};
	        },
	    	done : function (e, data) {

	    		if(data.result.result){
	        		var targetObj = this.targetObj;

	    			if(targetObj){
	    				if(targetObj.fileDone){
			    			var param = data.result.param;
							var file = data.result.file;
							fileUploadObj.filesObj[param.fileId].splice(0, 1);
							targetObj.fileDone.call(this, param, file);
	    				}
	    			}
	        		alert("저장하였습니다");
	    		} else{
					alert(data.result.msg);
				}
			}
		})
		.data('opt', opt);
		return $fileupload;
	}
}

//]]>
</script>

<%--
//파일 리스트
function doFileList() {

	var params = {
		atch_file_id : '<c:out value="${detail.BASIC_ATCH_FILE_ID}"/>'
		//,is_site : 'Y' //파일 계열사 코드 리스트 요청시
	}


	if(params.atch_file_id == ''){
		console.log("no atch_file_id");
		return;
	}

	$.ajax({
		type: "POST",
		url: '<c:out value="/file/list"/>',
		data : JSON.stringify(params),
		dataType: "json",
		contentType : 'application/json',
		async: false,
		success:function(data) {

			//try {console.table(data.list);} catch (e) {}

			$("#listArea").html('');

			if(data.result) {

				var list = data.list;

				if(list.length > 0){
					$(list).each(function(k, v){
						var $sampleElement = $('#samples #listSample').clone(true);
						$sampleElement.data("data", v);
						$sampleElement.find("[data-nm=no]").text(k+1);
						$sampleElement.find("[data-nm=src_file_nm]").text(v.SRC_FILE_NM);
						$sampleElement.find("[data-nm=reg_nm]").text(v.REG_NM + "("+ v.REG_ID +")");
						$sampleElement.find("[data-nm=reg_dt]").text(v.REG_DT);
						$sampleElement.find("[data-file-delete]").data("data",v);
						$("#listArea").append($sampleElement);
					});
				}else{
					$("#listArea").append('<tr><td colspan="5" class="ac">+++ 등록된 데이타가 없습니다 +++</td></tr>');
				}

			} else{
				alert(data.msg);
			}
		},
		error:function(request) {
        	getAjaxError(request.status)
		}
	});
}

//첨부파일 삭제
function doRemoveFile(params){

	if(!confirm("삭제하시겠습니까?")){
		return;
	}

	var data = {};
	if(params.ATCH_FILE_ID){
		data["atch_file_id"] = params.ATCH_FILE_ID;
	}else{
		alert("no file id");
		return;
	}

	if(params.FILE_SN){
		data["file_sn"] = params.FILE_SN;
	}

	$.ajax({
		type: "POST",
		url: '<c:out value="/file/removeFile"/>',
		data : JSON.stringify(data),
		dataType: "json",
		contentType : 'application/json',
		async: false,
		success:function(data) {
			if(data.result) {
				alert("삭제하였습니다");
				doFileList();
			} else{
				if(data.msg){
					console.log(data.msg);
					alert("삭제하는데 실패하였습니다.");
				}else{
					alert("삭제하는데 실패하였습니다.");
				}
			}
		},
		error:function(request) {
             getAjaxError(request.status)
         }
	});
}


//첨부파일 수정
function doUpdateFile(){

	var data = {
		atch_file_id : "0000005"	//필수
		,file_sn : 1				//필수
		,confirm_yn : 'Y'			//update할 필드
	  //,proof_seq : 'Y'			//update할 필드
	};

	$.ajax({
		type: "POST",
		url: '<c:out value="/file/updateFile"/>',
		data : JSON.stringify(data),
		dataType: "json",
		contentType : 'application/json',
		async: false,
		success:function(data) {
			if(data.result) {
				alert("수정하였습니다");
				doFileList();
			} else{
				if(data.msg){
					console.log(data.msg);
					alert("수정하는데 실패하였습니다.");
				}else{
					alert("수정하는데 실패하였습니다.");
				}
			}
		},
		error:function(request) {
             getAjaxError(request.status)
         }
	});
}

--%>