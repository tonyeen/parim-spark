
		var id="";
		var arrChk;//复选框数组
		var count;//被选中的个数
		
		function del(path)
		{
			count = 0;
			arrChk=$("input[name='chk_list']");
			$(arrChk).each(function(){
				if($(this).attr("checked") == "checked")
					{
					id=id+$(this).val()+",";
					count++;
					}
			})
				if(count == 0)
					{
					alert("请选择至少一条记录!");
					return;
					}
				if(count >= 1)
					{
					 if(confirm("确定要删除"+count+"条数据吗")){
						 //location.href = "${ctxAdmin }/devwork/post/deleteAll/"+id;
						 location.href = "http://localhost:8080/devwork-site/admin/devwork/"+path+"/deleteAll/"+id;
					}
					}
		}
		
		//新增
		function add(path)
		{
			location.href = "http://localhost:8080/devwork-site/admin/devwork/"+path+"/properties";
		}
		//全选、取消
		$("a[name='checkAll']").click(function(){
			var flag = true;
			var arrChk=$("input[name='chk_list']");
		      $(arrChk).each(function(){
		         if($(this).attr("checked") != "checked")
		    	   {
		    	   		flag = false;
		    	   }
		    });  
		    //如果已经全部都被选中，则再次点击时取消全选
		     if(flag)
		    	{
		    		$("input[name='chk_list']").attr("checked",false);
		    	}else{
		    		$("input[name='chk_list']").attr("checked",true);
		    	}
		});
		
		function check(info0,info1){
			arrChk=$("input[name='chk_list']");
			count = 0;
			$(arrChk).each(function(){
				if($(this).attr("checked") == "checked")
					{
					count++;
					}
			})
			if(count>1)
				{
				alert(info1);
				return;
				}
			if(count==0)
				{
				alert(info0);
				return;
				}
		}
		