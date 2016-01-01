package net.parim.sns.modules.sys.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="${adminPath}/sys/permission")
public class PermissionController {

	@RequestMapping(value="/")
	public String index(){
		return "admin/sys/permissionIndex";
	}
}
