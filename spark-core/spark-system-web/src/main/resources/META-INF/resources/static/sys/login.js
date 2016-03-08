$(function(){
	$("#code-img").click(function(){
		$(this).attr("src",_ctx+"/kaptcha.jpg?"+Math.floor(Math.random()*100));
	});
	
	$('#dataForm').validate({
	});
});