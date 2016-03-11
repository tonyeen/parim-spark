package net.parim.system.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.parim.common.config.Global;
import net.parim.common.utils.Constants;
import net.parim.common.utils.StringUtils;
import net.parim.system.entity.User;
import net.parim.system.interceptor.ThemeInterceptor.UseTheme;
import net.parim.system.security.UsernamePasswordToken;
import net.parim.system.service.AccountService;
import net.parim.system.service.UserService;

@Controller
public class AuthenticateController {

    @Autowired
    private DefaultWebSecurityManager securityManager;
    @Autowired
    AccountService accountService;

    @RequestMapping(value = { "/login",
            "${adminPath}/login" }, method = RequestMethod.GET)
    @UseTheme(value = false)
    public String login(Model model) {
    	boolean openValidation = false;//是否开启验证码
    	int loginFailTimes = 0;
    	if("enable".equals(Global.getConfig("kaptcha.status")) && (loginFailTimes >= 5)){
    		openValidation = true;
    	}
    	model.addAttribute("openValidation", openValidation);
        return Global.getThemePath() + "login";
    }

    @RequestMapping(value = { "/login",
            "${adminPath}/login" }, method = RequestMethod.POST)
    @UseTheme(value = false)
    public String loginFailed(Model model) {
    	boolean openValidation = false;//是否开启验证码
    	if("enable".equals(Global.getConfig("kaptcha.status"))){
    		openValidation = true;
    	}
    	model.addAttribute("openValidation", openValidation);
        return Global.getThemePath() + "login";
    }

    @RequestMapping(value = { "/logout",
            "${adminPath}/logout" }, method = RequestMethod.GET)
    @UseTheme(value = false)
    public String logout(Model model) {

        return Global.getThemePath() + "login";
    }


    @RequestMapping("/login/ajax")
    @ResponseBody
    public Map<String, Object> ajaxLogin(
            @RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName,
            @RequestParam(value = "rememberMe", required = false,defaultValue="false") Boolean rememberMe,
            @RequestParam(value = "code", required = false) String code,
            @RequestParam("password") String password, Model model,
            HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Boolean flag = false;
        String message = "验证码错误";
        if (("enable").equals(Global.getConfig("kaptcha.status"))) {
            if (!this.checkKaptchaCode(request, code)) {
                resultMap.put("result", flag);
                resultMap.put("message", message);
                return resultMap;
            }
        }
        String host = StringUtils.getRemoteAddr((HttpServletRequest) request);
        SecurityUtils.setSecurityManager(securityManager);
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            UsernamePasswordToken token = new UsernamePasswordToken(userName,
                    password, rememberMe, host, code, false);

            try {
                subject.login(token);
                User user = accountService.findUserByUsername(userName);
                subject.getSession().setAttribute(Constants.CURRENT_USER, user);
                flag = true;
                message = "登录成功";
            } catch (UnknownAccountException ex) {
                message = "账号或密码错误";
            } catch (IncorrectCredentialsException ex) {
                message = "账号或密码错误";
            } catch (LockedAccountException ex) {
                message = "账号已被锁定，请与系统管理员联系";
            } catch (AuthenticationException ex) {
                message = "其他错误";
            } finally {
                resultMap.put("result", flag);
                resultMap.put("message", message);
            }
        } else {
            resultMap.put("result", true);
            resultMap.put("message", "登录成功");
        }
        return resultMap;

    }

    @RequestMapping("/login/check")
    @ResponseBody
    public String checkLoginStatus() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            return "true";
        } else {
            return "false";
        }
    }
    @RequestMapping("/login/check_code/ajax")
    @ResponseBody
    public boolean checkKaptchaCode(HttpServletRequest request,
    		@RequestParam(value = "code", required = true) String code) {
        String kaptchaValue = getKaptchaCode(request);
        // 比较输入的验证码和实际生成的验证码是否相同
        if (kaptchaValue != null 
                && code.equalsIgnoreCase(kaptchaValue)) {
            return true;
        } else {
            return false;
        }
    }

    private String getKaptchaCode(HttpServletRequest request){
    	String kaptchaValue = (String) request.getSession().getAttribute(
                "KAPTCHA_SESSION_KEY");
    	return kaptchaValue;
    }
    /**
     * ajax登出 spring mvc 实现
     */
    @RequestMapping(value = "/ajaxLogout")
    @ResponseBody
    public String ajaxLogout() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        // 返回json数据
        return "success";
    }

}
