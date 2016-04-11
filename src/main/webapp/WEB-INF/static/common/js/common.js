$(document).ready(function(){
	//使用select2控件
	if(!!window.Select2)
		$(".select2").prepend('<option value="">--请选择--</option>').select2({allowClear:true})
		.on('change', function(){
			$(this).closest('form').validate().element($(this));
		}); 
	if(!!$.datepicker)
		$('.date-picker').datepicker().next().on(ace.click_event, function(){
			$(this).prev().focus();
		});
	//textarea控件根据内容增多扩大
	$('textarea[class*=autosize]').autosize({append: "\n"});
	if(!!$.validator){
		//添加公用验证方法
		jQuery.validator.addMethod("mobile", function(value, element) {
			var length = value.length;
			var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
		}, "请正确填写您的手机号码");
		
		jQuery.validator.addMethod("phone", function(value, element) {
			var phone = /(^(\d{3,4}-)?\d{6,8}$)|(^(\d{3,4}-)?\d{6,8}(-\d{1,5})?$)|(\d{11})/;
			return this.optional(element) || (phone.test(value));
		}, "请填写正确的电话号码");
		 
		jQuery.validator.addMethod("chinese", function(value, element) {
			var chinese = /^[\一-\龥]+$/i;
			return this.optional(element) || (chinese.test(value));
		}, "只能输入汉字");
		jQuery.validator.addMethod("idcard", function (value, element) {
	        return this.optional(element) || isIdCardNo(value);
	    }, "请正确输入您的身份证号码");
	}
	if(!!$.ui)
	//override dialog's title function to allow for HTML titles
		$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
			_title: function(title) {
				var $title = this.options.title || '&nbsp;'
				if( ("title_html" in this.options) && this.options.title_html == true )
					title.html($title);
				else title.text($title);
			}
		}));
	
	$.fn.extend({
		loading:function(options){
			var opts = $.extend({}, $.fn.loading.defaults, options),
				$load = $('<div style="text-align: center;display: none;" class="ajax-loading-overlay"><i class="ajax-loading-icon fa fa-spin fa-spinner fa-2x orange"></i> </div>');
			return this.each(function(){
				$(this).data('load',$load.appendTo(opts.container).show());
			});
		}
	});
	$.fn.loading.defaults = {
		container: $(document.body)
	};
	//重载ajax发送请求之前方法
	$(document).ajaxSend(function(evt, request, settings){
		if(!!settings.loading){
			(settings.loading.container||$(document.body)).loading(settings.loading);
		}
	});
	//重载ajax发送请求之后方法
	$(document).ajaxComplete(function(evt, request, settings){
		if(!!settings.loading)
			settings.loading.container.data('load').remove();
	});
	//初始化平台的一些组件
	platform = new Platform();
	//设置定级标题为当前功能标题
	top.document.title=this.title;
});
/**
 * 公用表单验证方法
 * @param form form表单id需要jquery对象
 * @param css 错误css样式
 * @param warp 错误容器
 */
function formValidate(validForm,css,warp,rules,messages){
	return validForm.validate({
		errorElement: warp,
		errorClass: css,
		submitHandler: function(form){
			/*$.jBox.tip('正在提交，请稍等...','loading',{opacity:0});*/
			form.submit();
		},
		errorPlacement: function(error, element) {
			var forGroup = element.closest('.form-group');
			$(warp+"[class='"+css+"']",forGroup).remove();
			if(element.is(':checkbox') || element.is(':radio')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			}
			else error.appendTo(forGroup);
		},
		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-success').addClass('has-error');
			$(e).closest('.form-group').find('span i').attr("class","icon-remove-sign");
		},
		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error').addClass('has-success');
			$(e).closest('.form-group').find('span i').attr("class","ace-icon fa fa-check-circle");
			$(e).remove();
		},
		rules:rules||{},
		messages:messages||{}
	});
}
function isIdCardNo(num) {
    var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
    var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2");
    var varArray = new Array();
    var intValue;
    var lngProduct = 0;
    var intCheckDigit;
    var intStrLen = num.length;
    var idNumber = num;
    // initialize
    if ((intStrLen != 15) && (intStrLen != 18)) {
        return false;
    }
    // check and set value
    for (i = 0; i < intStrLen; i++) {
        varArray[i] = idNumber.charAt(i);
        if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
            return false;
        } else if (i < 17) {
            varArray[i] = varArray[i] * factorArr[i];
        }
    }
    if (intStrLen == 18) {
        //check date
        var date8 = idNumber.substring(6, 14);
        if (isDate8(date8) == false) {
            return false;
        }
        // calculate the sum of the products
        for (i = 0; i < 17; i++) {
            lngProduct = lngProduct + varArray[i];
        }
        // calculate the check digit
        intCheckDigit = parityBit[lngProduct % 11];
        // check last digit
        if (varArray[17] != intCheckDigit) {
            return false;
        }
    }
    else {        //length is 15
        //check date
        var date6 = idNumber.substring(6, 12);
        if (isDate6(date6) == false) {
            return false;
        }
    }
    return true;
}
function isDate6(sDate) {
    if (!/^[0-9]{6}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    if (year < 1700 || year > 2500) return false
    if (month < 1 || month > 12) return false
    return true
}

function isDate8(sDate) {
    if (!/^[0-9]{8}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    day = sDate.substring(6, 8);
    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if (year < 1700 || year > 2500) return false
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
    if (month < 1 || month > 12) return false
    if (day < 1 || day > iaMonthDays[month - 1]) return false
    return true
}
/**
 * 解析url为js对象
 * @param url
 * @returns
 */
function parse(url)  
{  
    //如果URL为空或不带参数则直接返回null  
    //if (null == url || url.split("?").length < 2)  
    if (null == url || url.indexOf("?") == -1)  
    {  
        return null;  
    }  
      
    var argsUrl = url.split("?")[1];  
      
    //if (argsUrl.split("=").length < 2)  
    if (argsUrl.indexOf("=") == -1)  
    {  
        return null;  
    }  
      
    var properties = argsUrl.replace(/&/g, "',").replace(/=/g, ":'").replace(/-/g, "") + "'";  
    var obj = null;  
    var template = "obj = {p}";  
    eval(template.replace(/p/g, properties));  
    return obj;  
}  
function openHref(url){
	window.open(url);
}
/**
 * 获取从数组当中取出数组的随机数
 * @param Arr
 * @returns {Number}
 */
function randomGetNumFromArray(Arr){
	return Math.floor(Math.random() * Arr.length + 1)-1;
}
function bindCheckAllEvent(){
	var $tmp = $('[name^="idList"]:checkbox',$('tbody')),
	$checkAll = $('input[id^="checkAll"]',$('thead'));
	$checkAll.on('click',function(){
		$tmp.prop("checked", this.checked );
	 });
	$tmp.on('click',function(event){
		$checkAll.prop('checked',$tmp.length==$tmp.filter(':checked').length);
		event.stopPropagation();
	 });
}
function getSomeDate(AddDayCount) {
    var dd = new Date();
    dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
    var y = dd.getFullYear();
    var m = dd.getMonth()+1;//获取当前月份的日期
    var d = dd.getDate();
    return Date.parseDate(y+"-"+m+"-"+d);
}
/**
 * 绑定触发时间
 * @param el 容器
 * @param event 事件名称
 * @param handler 回调函数
 */
function autoEvent(el, event, handler){
	if (el.addEventListener)
		el.addEventListener(event, handler, false);

	else if (el.attachEvent)
		el.attachEvent("on"+event, handler);
}
/**
 * 动态设置元素的高度
 */
function setElementHeight(ele, array, wrap, fixHeight){
	wrap = wrap || document.body;
	ele = typeof ele ==='string'?$(ele,$(wrap)):ele;
	
	if(!!!ele.data('sizeParam')){
		ele.data('sizeParam',{'array':array||[],'wrap':wrap,'fixHeight':fixHeight});
		//自适应
		autoEvent(top.window, "resize", function(){
			window.setTimeout(function(){
				var sizeParam = ele.data('sizeParam');
				if(sizeParam)
					setElementHeight(ele, sizeParam['array'], sizeParam['wrap'], sizeParam['fixHeight']);
			},200);
		});
	}
  if(!fixHeight)
    fixHeight = 0;
  for(var i=0; i<array.length; i++){
	var item = array[i];
	var $item = typeof item==='string'?$(item,$(wrap)):item;
    fixHeight += $item.outerHeight();
  }
  ele.height($(wrap).height() - fixHeight);
}
/****cookie****/
//读取cookies
function getCookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}
//删除cookies
function delCookie(name){
    var exp = new Date();
    exp.setTime(exp.getTime() - 10000);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= (name + "="+cval+";expires="+exp.toGMTString()+"; path=/");
}
function setCookie(name,value,time,handler){
    var strsec = getsec(time);
    var exp = new Date();
    exp.setTime(exp.getTime() + strsec*1);
    delCookie(name);
    document.cookie = (name + "="+ escape (value) + ";expires=" + exp.toGMTString()+"; path=/");
    if(!!handler)handler.call(this);
}

function getsec(str){
   var str1=str.substring(1,str.length)*1;
   var str2=str.substring(0,1);
   if (str2=="s"){
        return str1*1000;
   }else if (str2=="h"){
       return str1*60*60*1000;
   }else if (str2=="d"){
       return str1*24*60*60*1000;
   }
}
/**
 * 针对参数取反
 * 返回false或者true
 * @param param
 */
function negatedParam(param){
	return !!eval(param);
}
/**
 * 获取选中的数据id
 * @param single true单选，默认为多选
 */
function getTableChecked(single){
	var $checked = $('input[name="idList"]:checked'),checkArray = [];
	if($checked.size()<=0){
		$.jBox.tip('亲！请先选择您要操作的数据！', 'error');
		return false;
	}
	if(!!!single){
		$checked.each(function(){
			checkArray.push($(this).val());
		});
	}else{
		if($checked.size()>1){
			$.jBox.tip('亲！请选择一条数据进行操作！', 'error');
			return false;
		}
		checkArray.push($(this).val());
	}
	return checkArray.join(',');
}
Date.prototype.format = function(format){ 
	var o = { 
		"M+" : this.getMonth()+1, //month 
		"d+" : this.getDate(), //day 
		"h+" : this.getHours(), //hour 
		"m+" : this.getMinutes(), //minute 
		"s+" : this.getSeconds(), //second 
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
		"S" : this.getMilliseconds() //millisecond 
	};
	
	if(/(y+)/.test(format)) { 
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 
	
	for(var k in o) { 
		if(new RegExp("("+ k +")").test(format)) { 
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
		} 
	} 
	return format; 
};
Date.prototype.parseDate = function (sDate) {

    if (/\s*(\d{1,4})(-|\/)(\d{1,2})(-|\/)(\d{1,2})/.test(sDate)) {//start with yyyy-mm-dd or yyyy/mm/dd
        var m = sDate.match(/\d+/g);
        if (m) {
            if (m.length > 1) m[1] = parseInt(m[1]) - 1;
            return eval('new Date(' + m.join(',') + ')');
        }
    } else {
        var reg = /\s*(\d{4})(\d{2})(\d{2})/
        if (reg.test(sDate)) {//start with yyyymmdd
            var m = reg.exec(sDate);
            if (m) {
                if (m.length > 2) m[2] = parseInt(m[2]) - 1;
                return eval('new Date(' + m.slice(1).join(',') + ')');
            }

        } else {
            var ms = Date.parse(sDate);
            if (ms) {
                var d1970 = new Date(1970, 1, 1, 0, 0, 0, 000);
                d1970.setTime(ms);
                return d1970;
            }
        }
    }
    throw new Error();
};
Array.prototype.indexOf = function(val) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == val) return i;
	}
	return -1;
};
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if (index > -1) {
		this.splice(index, 1);
	}
};