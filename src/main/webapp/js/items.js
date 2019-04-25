$(document).ready(function(){
	builderIndex();
	calculateMoney();
	$("#addItemButton").click(
		function(){
			$("#items").children("div").last().after($("#items").children("div").first().clone());
			$("#items").children("div").find("button").click(
				function(){
					$(this).parent().parent().remove();
					if($("#items").children("div").size()==1){
						$("#items").find("button").attr("disabled",true);
					}
					builderIndex();
					calculateMoney();
				}
			);
			$("#items").find("button").attr("disabled",false);
			builderIndex();	
			$(".money").change(
				function(){
					calculateMoney();
				}
			);
			calculateMoney();
		}
	);
	$(".money").change(
		function(){
			calculateMoney();
		}
	);
});// JavaScript Document

function builderIndex(){
	$.each($("#items").children(),function(i,val){
		$("#items").children("div").eq(i).children().eq(0).find("select").attr("name","items["+i+"].item");		
		$("#items").children("div").eq(i).children().eq(1).find("input").attr("name","items["+i+"].amount");				
		$("#items").children("div").eq(i).children().eq(2).find("input").attr("name","items["+i+"].comment");
				
	});	
}
function calculateMoney(){
	var totalMoney=0;
	$.each($(".money"),function(i,val){
		totalMoney+=parseFloat($(".money").eq(i).val());
	});
	$("#totalMoney").attr("value",totalMoney);
}

function validate_cause(){
	//校验报销单事由
	var cause = $("#claimVoucher\\.cause").val();
	if(isEmpty(cause)){
		//应该清空这个元素之前的样式
		show_validate_msg("#claimVoucher\\.cause", "error", "请输入报销单事由");
		return false;
	}else{
		show_validate_msg("#claimVoucher\\.cause", "success", "");
		return true;
	}
}

function validate_money(){
    var flag = 0;
	$.each($(".money"),function(i,val){
		if(!isNumber($(".money").eq(i).val())){
			alert("请输入金额");
			$(".money").eq(i).focus();
			flag=1;
		}
	});
	if(flag) return false;
	else return true;
}

function validate_add_form() {
	if(validate_cause() && validate_money()) {
		return true;
	} else {
		return false;
	}
}

//判断字符是否为空的方法
function isEmpty(obj){
	if(typeof obj == "undefined" || obj == null || obj == ""){
		return true;
	}else{
		return false;
	}
}

function isNumber(value) {
	var patrn = /^(-)?\d+(\.\d+)?$/;
	if (patrn.exec(value) == null || value == "") {
		return false
	} else {
		return true
	}
}

//显示校验结果的提示信息
function show_validate_msg(ele,status,msg){
	//清除当前元素的校验状态
	$(ele).parent().removeClass("state-success state-error");
	$(ele).next("span").text("");
	if("success"==status){
		$(ele).parent().addClass("state-success");
		$(ele).next("span").text(msg);
	}else if("error" == status){
		$(ele).parent().addClass("state-error");
		$(ele).next("span").text(msg);
	}
}