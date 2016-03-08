/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ZH (Chinese, 中文 (Zhōngwén), 汉语, 漢語)
 */
jQuery.extend(jQuery.validator.messages, {
        required: "必选字段",
		remote: "请修正该字段",
		email: "请输入正确格式的电子邮件",
		url: "请输入合法的网址",
		date: "请输入合法的日期",
		dateISO: "请输入合法的日期 (ISO).",
		number: "请输入合法的数字",
		digits: "只能输入整数",
		creditcard: "请输入合法的信用卡号",
		equalTo: "请再次输入相同的值",
		accept: "请输入拥有合法后缀名的字符串",
		maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
		minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
		rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
		range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
		max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
		min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});

jQuery.validator.addMethod("isZipCode", function(value, element) {   
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "请正确填写您的邮政编码");
jQuery.validator.addMethod("mobilePhone", function(value, element) {   
	var tel = /^[0-9]{11}$/;
	return this.optional(element) || (tel.test(value));
}, "请填写正确的手机号");
jQuery.validator.addMethod("username", function(value, element) {   
	var tel = /^[a-zA-Z\d][a-zA-Z\d\_\@]{3,18}[a-zA-Z\d]$/;
	return this.optional(element) || (tel.test(value));
}, "请填写合法用户名，支持英文大小写、下划线、@和数字，不能以下划线和@开头和结尾，最大长度为20");

jQuery.validator.addMethod("birthday", function(value, element) {   
	var currentDate = new Date();
	var inputDate = new Date(value.replace(/-/g,"/"));
	return this.optional(element) || (currentDate>inputDate);
}, "生日不能是未来日期");

jQuery.validator.addMethod("plus", function(value, element) { 
	var tel = /^[0-9]*[1-9][0-9]*$/;
	return this.optional(element) || (tel.test(value));
}, "请填写大于0的整数");

jQuery.validator.addMethod("plusZero", function(value, element) { 
	var tel = /^[0-9]+$/;
	return this.optional(element) || (tel.test(value));
}, "请填写非负整数");
jQuery.extend(jQuery.validator.defaults, {
    errorElement: "span",
    errorClass : 'help-block',  
    focusInvalid : false,
    highlight : function(element) {  
        $(element).closest('.form-group').addClass('has-error');  
    },  

    success : function(label) {  
        label.closest('.form-group').removeClass('has-error');  
        label.remove();  
    },  

    errorPlacement : function(error, element) {  
        element.parent('div').append(error);  
    },  

    submitHandler : function(form) {  
        form.submit();  
    } 
});