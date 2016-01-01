package net.parim.sns.modules.sys.interceptor;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import net.parim.common.config.Global;

public class ThemeInterceptor
	extends HandlerInterceptorAdapter{

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if(modelAndView!=null){
			//如果没有@UseTeme(value=false)注解，说明启用theme
			//TODO: 处理非 InternalResourceViewResolver 视图解析器，如 JSON、XML等的解析器的情况
			if(handler instanceof HandlerMethod){  
	            HandlerMethod method = (HandlerMethod)handler;  
	            UseTheme useTheme = method.getMethodAnnotation(UseTheme.class);  
	            //判断方法上注解的UseTheme值，如果否则不拦截。默认对进入此拦截器的所有方法拦截
	            if(useTheme == null || useTheme.value() == true){
	            	modelAndView.setViewName(Global.getThemePath() + modelAndView.getViewName());
	            	//TODO: 进一步修改theme为非系统变量，而是通过系统的可写配置（可维护，安装、预览、卸载等）
	            }
	        }
		}
	}
		
	@Target({ElementType.TYPE, ElementType.METHOD})
	@Retention(RetentionPolicy.RUNTIME)
	@Documented
	public @interface UseTheme{
		boolean value() default true; 
	}
}
