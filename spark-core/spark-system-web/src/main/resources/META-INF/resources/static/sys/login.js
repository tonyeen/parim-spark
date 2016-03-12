$(function(){
	//刷新验证码
	$("#code-img").click(function(){
		$(this).attr("src",_ctx+"/kaptcha.jpg?"+Math.floor(Math.random()*100));
	});
	//表单验证，验证成功后提交登录请求
	$('#dataForm').validate({
		submitHandler: function(form){
			//如果存在验证码，则异步校验验证码的正确性，否则直接提交登录请求
			if($("#code").length > 0){
				$.ajax({
					url: _ctx + "/login/check_code/ajax",
					data: {"code" : $("#code").val()},
					dataType:"text",
					success:function(result){
						if(result == "true"){
							form.submit();//提交登录请求
						}else{
							$(".error").text("验证码错误");
							return;
						}
					},
					error:function(XMLHttpRequest,err){
						$(".error").text("未知错误，请重试");
						return;
					}
				});
			}else{
				form.submit();//提交登录请求
			}
		}
	});
	
});