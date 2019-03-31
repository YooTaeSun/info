<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<style type="text/css">
table{line-height:1.5;text-align:left;border-collapse:collapse;	border-spacing:0;}
.grid{ border-top:2px solid #545C73; border-bottom:1px solid #DDDEE0; }
.grid th{ height:53px; vertical-align:middle; text-align:center; padding:0px 2px; }
.grid td{ color:#555; height:51px; vertical-align:middle; text-align:center; padding:0px 2px; border-top:1px solid #DDDEE0; }
.bbs-list > table{ width:100%; table-layout:fixed; }
</style>
<script type="text/javascript"
	src="<c:url value="/js/jquery-1.12.4.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/jquery-ui-1.12.0/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/main.js"/>"></script>
<script type="text/javascript">
jQuery(function($) {

	//테이블 tr 필터 와 rowspan 합치기
  $("#myInput").on("keyup", function(e) {
	  
	    var val = $(this).val();
	    // basic 모든 컬럼
	    //fn_tableFiletr($("#myTable tr"), val);
	    
	    var data = {
			Lastname : val,
			Firstname : val,
	    }
	    // 특정 컬럼
	    fn_tableFiletr($("#table01"), data);
	  });
  
  //mergeRowSpan($("#table01"));
});

function fn_tableFiletr($table, val) {
	
	//초기화 테이블 데이타 저장
	var trhtml =$table.find("tbody").data("data");
	if(trhtml == undefined){
		var html = $table.find("tbody").html();
		console.log(html);
		$table.find("tbody").data("data",html);		
	}else{
		$table.find("tbody").html(trhtml);
	}
	
	
	var $trs = $table.find("tbody tr");
	
	switch ($.type(val)) {
	case "object":
		
		$trs.hide().filter(function(i, tr) {
			$.each(val, function(e,val){
				//if($(tr).find("[data-filter="+e+"]").text().trim().toLowerCase().indexOf(val.trim().toLowerCase()) > -1){
				if($(tr).find("[data-filter="+e+"]").text().toLowerCase().indexOf(val.toLowerCase()) > -1){					
					$(tr).show();
					return true;
				}
			});
	    });
		break;

	default:
		$trs.filter(function(i, tr) {
			$(this).toggle($(this).text().toLowerCase().indexOf(val) > -1)
	    });
		break;
	}

	mergeRowSpan($("#table01"), ['Firstname','Lastname']);
}
	
//order by 된 데이타 	
function mergeRowSpan($table, val){
	
	$.each(val, function(e,val){
		$table.find("[data-rowspan="+val+"]:visible").each(function(i,v) {
		
		  var rows = $("[data-rowspan="+val+"]:visible:contains('" + $(this).text() + "')");
		  
		  if (rows.length > 1) {
		    rows.eq(0).attr("rowspan", rows.length);
		    rows.not(":eq(0)").remove();
		  }
		});
	});	

	
	$("#table02 .first").each(function(i, v) {
		
		console.log(i);
		console.log($(v).html());
		
		  var rows = $("#table02 .first:contains('" + $(this).text() + "')");
		  if (rows.length > 1) {
		    rows.eq(0).attr("rowspan", rows.length);
		    rows.not(":eq(0)").remove();
		  }
		});
}		


</script>
</head>
<body>
	<h3>file Test</h3>

	<form id="form1" name="form1">
		<div style="width: 100%">
			<p style="margin-top: 14px">Type something in the input field to
				search the table for first names, last names or emails:</p>
			<input id="myInput" type="text" placeholder="Search.."> <br>

			<table class="w3-table-all" border="1" id="table01">
				<thead>
					<tr>
						<!--       
        <th width="30%">Firstname</th>
        <th width="30%">Lastname</th>
        <th width="30%">Email</th>
 -->
						<th width=200 style="word-break: break-all">Firstname</th>
						<th width=200 style="word-break: break-all">Lastname</th>
						<th width=200 style="word-break: break-all">Email</th>
					</tr>
				</thead>
				<tbody id="myTable">
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">aaa</td>
						<td data-filter="Lastname" data-rowspan="Lastname">AAA</td>
						<td data-filter="Email">아무나</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">aaa</td>
						<td data-filter="Lastname" data-rowspan="Lastname">AAA</td>
						<td data-filter="Email">서울</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">aaa</td>
						<td data-filter="Lastname" data-rowspan="Lastname">BBB</td>
						<td data-filter="Email">AB</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">bbb</td>
						<td data-filter="Lastname" data-rowspan="Lastname">BBB</td>
						<td data-filter="Email">333</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">bbb</td>
						<td data-filter="Lastname" data-rowspan="Lastname">DDD</td>
						<td data-filter="Email">333</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">bbb</td>
						<td data-filter="Lastname" data-rowspan="Lastname">DDD</td>
						<td data-filter="Email">333</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">111</td>
						<td data-filter="Lastname" data-rowspan="Lastname">222</td>
						<td data-filter="Email">333</td>
					</tr>
					<tr style="">
						<td data-filter="Firstname" data-rowspan="Firstname">111</td>
						<td data-filter="Lastname" data-rowspan="Lastname">222</td>
						<td data-filter="Email">333</td>
					</tr>
				</tbody>
			</table>

			<br />
			<br />
			<br />
			<script type="text/javascript">


</script>
<div class="grid bbs-list">
	<table border="1" id="table02">
		<thead>
			<tr>
				<th>순서</th>
				<th>제목</th>
				<th>내용</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="first">aaa</td>
				<td>1</td>
				<td>첫째</td>
			</tr>
			<tr>
				<td class="first">aaa</td>
				<td>2</td>
				<td>둘째</td>
			</tr>
			<tr>
				<td class="first">bbb</td>
				<td>3</td>
				<td>셋째</td>
			</tr>
			<tr>
				<td class="first">bbb</td>
				<td>1</td>
				<td>첫째</td>
			</tr>
			<tr>
				<td class="first">bbb</td>
				<td>2</td>
				<td>둘째</td>
			</tr>
			<tr>
				<td class="first">dddd</td>
				<td>3</td>
				<td>셋째</td>
			</tr>
		</tbody>
	</table>
</div>

		</div>
	</form>

</body>



