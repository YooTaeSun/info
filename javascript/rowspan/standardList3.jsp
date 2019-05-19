<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="js/jquery-2.2.4.min.js?aaa=<%=System.currentTimeMillis() %>"></script>
<script type="text/javascript">
//<![CDATA[
$(function(){
	doList();
});

function nvl(str) {
	if(str === undefined){
		return "";
	}
	return str;
}
function doList() {

	
	//try {console.table(data.list);} catch (e) {}

	$("#listArea").html('');
  
	var data = {
		result : true,
		list : [ 
			{
				REWARD_CD_NM : "aaa",
				EVAL_ITEM_NM : "222",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "aaa",
				EVAL_ITEM_NM : "222",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "222",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "333",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "333",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "333",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10", 
			},
			{ 
				REWARD_CD_NM : "ccc", 
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10", 
			},
			{ 
				REWARD_CD_NM : "bbb", 
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "bbb",
				EVAL_ITEM_NM : "333",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
/* 			
			{
				REWARD_CD_NM : "ccc",
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
			{
				REWARD_CD_NM : "aaa",
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10", 
			},
			{
				REWARD_CD_NM : "aaa",
				EVAL_ITEM_NM : "111",
				MAX_SCORE : "1",
				EVAL_TYP_NM : "EVAL_TYP_NM",
				RISK_TYP_CD_NM : "상",
				EVAL_SCORE : "10",
			},
 */			
		]
	}
	 
	if(data.result) {

		var list = data.list;
		var cnt = list.length;

		$(list).each(function(k, v){
			var $sampleElement = $('#samples #listSample').clone(true);
			$sampleElement.find("[data-nm=no]").text(k);
			$sampleElement.find("[data-nm=reward_cd_nm]").text(nvl(v.REWARD_CD_NM,""));
			$sampleElement.find("[data-nm=eval_item_nm]").text(nvl(v.EVAL_ITEM_NM,""));
			$sampleElement.find("[data-nm=max_score]").text(nvl(v.MAX_SCORE,""));
			$sampleElement.find("[data-nm=eval_typ_nm]").text(nvl(v.EVAL_TYP_NM,""));
			$("#listArea2").append($sampleElement.clone(true));
			$("#listArea").append($sampleElement);
		});

		//fn_mergeRowSpan($("#listArea tr"), ['reward_cd_nm','eval_item_nm','max_score']);
		fn_mergeRowSpan($("#listArea tr"), ['reward_cd_nm','eval_item_nm']); 
		
	}
}


/*
 * 테이블  rowSapn
 * */
function fn_mergeRowSpan($trs, targetArray){

	console.log(" targetArray >> " + JSON.stringify(targetArray));
	var idxObj = {};

	var totalCnt = $trs.length;

	$.each(targetArray, function(vi,val){
		idxObj[val] = {};
		var btext = "";
		var text = "";
		var row = [];
		var $td = null;
		var $btd = null;
		var sameCnt = 1;

		var $tds = $trs.find("[data-rowspan="+val+"]").toArray().reverse();

		$.each($tds, function(tdi,td) {
			text = $(td).text();
			$td = $(td);

			if(tdi == 0){//마직막 tr
				sameCnt = 1;
			}else if((tdi+1) == totalCnt){//첫번째 tr
				if(btext == text){
					sameCnt++;
					if(sameCnt >= 2){
						idxObj[val][totalCnt - tdi -1] = totalCnt - tdi -1 + sameCnt;
					}
				}
			}else{
				if(btext == text){
					sameCnt++;
				}else{
					if(sameCnt >= 2){
						idxObj[val][totalCnt - tdi] = totalCnt - tdi +sameCnt;
					}
					sameCnt = 1;
				}
			} 
			btext = text;
			$btd = $td;
		});
	});

	console.log("==============================================");
  	console.log(" idxObj >> " + JSON.stringify(idxObj));

  	var b_idxObj = {};
	var no = 0;
	var val = null;
	var re = {};
	for ( var key in idxObj) {
		var val = idxObj[key];
		
		var indexArray = [];
		if(Object.keys(b_idxObj).length > 0) {
			for ( var b_key in b_idxObj) {
				console.log("b_key >> " + b_key);
				var b_val = b_idxObj[b_key];
			
				for ( var s in val) {
					indexArray.push(parseInt(s));
					indexArray.push(val[s]);
				}
				var gt = indexArray[0];
				
				for ( var b_s in b_val) {
					if(gt <= parseInt(b_s)){
						indexArray.push(parseInt(b_s));
						indexArray.push(b_val[b_s]);
					}
				}
				
				indexArray.sort(function(a, b) {
				    return a - b;
				});
				
				console.log(" indexArray >> " + JSON.stringify(indexArray));
				
				var arrayVal = "";
				var b_val = "";
				for (var ki = 0; ki < indexArray.length; ki++) {
					if(ki >= 1){
						if(indexArray[ki] - b_val > 1){
							re[b_val] =  indexArray[ki];
						}
					}					
					arrayVal=  indexArray[ki];
					b_val = arrayVal;
				}
				idxObj[key] = re;
				console.log(" re >> " + JSON.stringify(re));
				
				var re_s = "";
				var re_e = "";
				  
			}
		}

		fn_merge(key,idxObj[key]);
		
		b_idxObj[key] = val;
	}
} 
  
 
function fn_merge(key,val){
	
	for ( var vi in val) {
		var gtIdx = parseInt(vi-1);
		var ltIdx = val[vi];

		var rows = null;
		if(gtIdx < 0){
			var rows = $("[data-rowspan="+key+"]:lt("+ltIdx+")");
			//str = '$("[data-rowspan='+key+']:lt('+ltIdx+')")';
		}else{
			var rows = $("[data-rowspan="+key+"]:lt("+ltIdx+"):gt("+gtIdx+")");
			//str = '$("[data-rowspan='+key+']:lt('+ltIdx+'):gt('+gtIdx+')")';
		}
		rows.attr("merge_"+ key,vi);
		//rows.text(""+ key,vi);
	}
	
	for ( var vj in val) {
		var rows = $("[merge_"+key+"="+vj+"]");
		rows.eq(0).attr("rowspan", rows.length);
	    rows.not(":eq(0)").remove();
	}
}



//]]>
</script>

<div class="cont-panel">

	<table class="table-style t_cetner" border="1">
		<colgroup>
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:30%;">
			<col style="width:60px;">
			<col style="width:60px;">
		</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>상벌 구분</th>
					<th>평가 항목</th>
					<th>최고점수</th>
					<th>세부 유형</th>
				</tr>
			</thead>
			<tbody id="listArea2">
			</tbody>
		</table>
		 
		<br/>
		<br/>
		<br/>
				
	<table class="table-style t_cetner" border="1">
		<colgroup>
			<col style="width:60px;">
			<col style="width:60px;">
			<col style="width:30%;">
			<col style="width:60px;">
			<col style="width:60px;">
		</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>상벌 구분</th>
					<th>평가 항목</th>
					<th>최고점수</th>
					<th>세부 유형</th>
				</tr>
			</thead>
			<tbody id="listArea">
			</tbody>
		</table>
		
	</div><!-- //cont-panel -->



<div id='samples' class='samples' style="display: none;">
	<table>
		<tr id="popupListSample">
			<td data-nm="no"></td>
			<td data-nm="eval_typ_nm">
				<input type="text" class="wp100" name="eval_typ_nm" value="" maxlength="100">
			</td>
			<td data-nm="risk_typ_cd">
				<softworks:codeList name="risk_typ_cd" type="select" code="${riskTypCdList}" />
			</td>
			<td data-nm="eval_score">
				<input type="text" class="wp100" name="eval_score" value="" maxlength="2">
			</td>
			<td ><button class="t-btn" data-action-rowDelete>삭제</button></td>
		</tr>
		<tr id="listSample">
			<td data-nm="no"></td>
			<td data-nm="reward_cd_nm" data-rowspan="reward_cd_nm"></td>
			<td data-nm="eval_item_nm"  data-rowspan="eval_item_nm"></td>
			<td data-nm="max_score" data-rowspan="max_score"></td>
			<td data-nm="eval_typ_nm"></td>
		</tr>
</table>
</div>