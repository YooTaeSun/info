



/*
 * 테이블 필터
 * */
function fn_tableFilter($trs, val, $total) {
//console.log(" val >> " + JSON.stringify(val));
	switch ($.type(val)) {

	case "object":
		for ( var e in val) {
			if(val[e] == ""){
				delete val[e];
			}
		}

//console.log(" val2 >> " + JSON.stringify(val));
		var keyCnt = Object.keys(val).length;
		var totalCnt = 0;
		if(keyCnt == 0){
			$trs.show();
		}else{
			$trs.hide().filter(function(i, tr) {
				var cnt = 0;
				var text = "";
				//두개 이상의  td의 text OR 비교
				if(e.indexOf(",") > -1){
					var arrKey = e.split(",");
					for(var k in arrKey){
						text += $(tr).find("[data-filter="+arrKey[k]+"]").text().toLowerCase() + "		";
					}
				}else{
					text = $(tr).find("[data-filter="+e+"]").text().toLowerCase();
				}
				$.each(val, function(e,val){

					//한 td의 text [val1,val2] OR 비교
					switch ($.type(val)) {
						case "array":

							$.each(val, function(e2,val2){
								if(text.indexOf(val2.toLowerCase()) > -1){
									console.log("val2 >> " + val2);
									cnt++;
									return false;
								}
							});
							break;
						default:
							if(text.indexOf(val.toLowerCase()) > -1){
								cnt++;
							}
							break;
					}
				});
				if(cnt == keyCnt){
					$(tr).show();
				}
		    });
		}
		break;

	default:
		$trs.filter(function(i, tr) {
			$(this).toggle($(this).text().toLowerCase().indexOf(val) > -1)
	    });
		break;
	}

	if($total && $total.length > 0 ){
		$total.text($trs.parent().find("tr:visible").length);
	}
}

/*
 * 파일 다운로드
 * */
function fn_download(atch_file_id, file_sn, type, data) {
    if(0 >= $('#fileFrame').length)
        $('body:last').prepend(
            '<iframe id="fileFrame" name="fileFrame" width="1" height="1" style="display:none;"></iframe>' +
            '<form id="fileFrm" method="post" target="fileFrame"><input type="hidden" name="atch_file_id" /><input type="hidden" name="file_sn" /><input type="hidden" name="type" /><input type="hidden" name="data" /></form>'
        );

    	var $fm = $('#fileFrm');
    	$fm.find("input[name=atch_file_id]").val(atch_file_id);
    	$fm.find("input[name=file_sn]").val(nvl(file_sn, ""));
    	$fm.find("input[name=type]").val(nvl(type, ""));
    	if(data){
    		$fm.find("input[name=data]").val(nvl(data.replace(/\"/gi,"\^"), ""));
    	}
    	$fm.attr("action","/file/download");
    	$fm.submit();
}

var arrayPopup = [];
function openPopup(popupID){
	arrayPopup.push(popupID);
//	console.log("arrayPopup",arrayPopup);
}

function cloasAllPopup(){
	console.log("cloasAllPopup",arrayPopup);
	for(var i=0;i<arrayPopup.length; i++){
		if(arrayPopup[i] && ! arrayPopup[i].closed){
			console.log("arrayPopup[i]=="+arrayPopup[i]);
			arrayPopup[i].close();
		}
	}
}


function replaceAll(str, searchStr, replaceStr) {
  return str.split(searchStr).join(replaceStr);
}

function getFormatDate(date){
	var year = date.getFullYear();
	var month = (1 + date.getMonth());
	month = month >= 10 ? month : '0' + month;
	var day = date.getDate();
	day = day >= 10 ? day : '0' + day;
	return year + '-' + month + '-' + day;
}

var loderShowFlag=true;
$(window).ajaxStart(function (){
	loderShowFlag=true;
    ajaxLoadingTimeout = setTimeout(function () {
        if(loderShowFlag){
           $(".loader-wrap").show();
        }
    }, 1000);
}).ajaxStop(function (){
	loderShowFlag=false;
    clearTimeout(ajaxLoadingTimeout);
	$(".loader-wrap").hide();
});


/*
 * 테이블  rowSapn sum
 * rowspan.js
 * merge_obj.fn_rowSum($("#listArea tr"), ['reward_cd_nm','eval_item_nm','max_score']);
 * <td data-rowspan="reward_cd_nm"></td>
 * */
var merge_obj={idxObj:{},fn_rowSum:function(r,e){console.log(" targetArray >> "+JSON.stringify(e));var t=this.idxObj,n=r.length;$.each(e,function(e,a){t[a]={};var i="",o="",l=null,s=1,f=r.find("[data-rowspan="+a+"]").toArray().reverse();$.each(f,function(r,e){o=$(e).text(),l=$(e),0==r?s=1:r+1==n?i==o?++s>=2&&(t[a][n-r-1]=n-r-1+s-1):s>=2&&(t[a][n-r]=n-r+s-1):i==o?s++:(s>=2&&(t[a][n-r]=n-r+s-1),s=1),i=o,l})}),console.log("=============================================="),console.log(" idxObj >> "+JSON.stringify(t)),console.log("=============================================="),this.fn_calculate_merge(t)},fn_row_excute:function(r,e){for(var t in console.log(" fn_row_merge val >> "+JSON.stringify(e)),e){var n=parseInt(t-1),a=e[t]+1,i=(e[t],null);if(n<0)i=$("[data-rowspan="+r+"]:lt("+a+")");else i=$("[data-rowspan="+r+"]:lt("+a+"):gt("+n+")");i.attr("merge_"+r,t)}for(var o in e){(i=$("[merge_"+r+"="+o+"]")).eq(0).attr("rowspan",i.length),i.not(":eq(0)").remove()}},putArray:function(r,e,t){console.log("start >> "+e+", end >> "+t);var n={};n[e]=t,r.push(n)},fn_calculate_merge:function(r){var e=[],t=null,n=-1,a=-1,i=null;for(var o in r){var l=r[o];if(e.length>0){var s=[];Object.keys(l).length;for(var f in l){0;t=l[f];console.log(" >> "+f+" : "+t);for(var g=0;g<e.length;g+=2){var u=e[g],c=e[g+1];if(-1==n){if(u>f){if(u>t);else if(u<=t&&t<=c)(n=u)<(a=t)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1);else if(t>c){(n=u)<(a=c)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1);continue}}else if(u<=f&&f<=c)if(n=parseInt(f),u>t)n<(a=t)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1),(n=t+1)<(a=u)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1);else if(u<=t&&t<=c){if(!(t<=c))continue;n<(a=t)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1)}else t>c&&(n<(a=c)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1));else if(f>c)continue}else-1==a&&(n<u&&(n<(a=u-1)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1),n=u),u<=t&&t<=c?n<(a=t)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1):t>c&&(n<(a=c)?(this.putArray(s,n,a),n=-1,a=-1):(n=-1,a=-1),n=c+1))}}}if(n=-1,a=-1,s)if(e.splice(0,e.length),r[o]={},0==s.length)s=i,console.log(" next_array >> "+JSON.stringify(s));else{console.log(" next_array >> "+JSON.stringify(s));for(var h=0;h<s.length;h++){s[h];for(var p in s[h])e.push(parseInt(p)),e.push(s[h][p]),r[o][p]=s[h][p]}}else for(var f in console.log(" next_array >> "+JSON.stringify(s)),e.splice(0,e.length),l)e.push(parseInt(f)),e.push(l[f]);this.fn_row_excute(o,r[o]),i=s}}};


/*
 * day : -1 하루전, 0 현재, 1 내일
 * yyyymmdd : 기준일
 * */
function caldate(day, yyyymmdd){// yyyymmdd

	var caledmonth, caledday, caledYear;
	var loadDt = null;
	if(yyyymmdd == undefined || nvl(yyyymmdd) == ''){
		var loadDt = new Date();
	}else{
		var yyyy = parseInt(yyyymmdd.substring(0,4));
		var mm = parseInt(yyyymmdd.substring(4,6)) -1;
		var dd = parseInt(yyyymmdd.substring(6,8));
		var loadDt = new Date(yyyy, mm, dd);
	}

	var v = new Date(Date.parse(loadDt) + day*1000*60*60*24);

	caledYear = v.getFullYear();

	if( v.getMonth() < 9 ){
		caledmonth = '0'+(v.getMonth()+1);
	}else{
		caledmonth = v.getMonth()+1;
	}

	if( v.getDate() < 9 ){
		caledday = '0'+v.getDate();
	}else{
		caledday = v.getDate();
	}
	return caledYear + '-' + caledmonth + '-' + caledday;
}
