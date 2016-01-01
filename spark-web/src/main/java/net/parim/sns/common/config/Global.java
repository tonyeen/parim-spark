package net.parim.sns.common.config;

import java.util.Map;

import net.parim.sns.common.utils.PropertiesLoader;
import net.parim.sns.common.utils.StringUtils;

import com.google.common.collect.Maps;

/**
 * 全局配置
 * @author Tony
 *
 */
public class Global {
	
	/**
	 * 是/否
	 */
	public static final String YES = "1";
	public static final String NO = "0";
	
	/**
	 * 对/错
	 */
	public static final String TRUE = "true";
	public static final String FALSE = "false";
	
	/**
	 * 保存全局属性值
	 */
	private static Map<String, String> map = Maps.newHashMap();
	private static PropertiesLoader loader = new PropertiesLoader("sns.properties");
	
	private Global(){}
	
	/**
	 * 获取配置
	 * @see ${fns:getConfig('adminPath')}
	 */
	public static String getConfig(String key) {
		String value = map.get(key);
		if (value == null){
			value = loader.getProperty(key);
			map.put(key, value != null ? value : StringUtils.EMPTY);
		}
		return value;
	}
	
	/**
	 * 路径前缀
	 * @return
	 */
	public static String getUrlPrefix(){
		return getConfig("web.view.prefix");
	}
	
	/**
	 * 路径后缀
	 * @return
	 */
	public static String getUrlSuffix(){
		return getConfig("web.view.suffix");
	}
	
	/**
	 * 前台主题名称
	 * @return
	 */
	public static String getTheme(){
		return getConfig("site.theme");
	}
	
	/**
	 * 前台主题模板存放基础路径
	 * @return
	 */
	public static String getThemeBasePath(){
		return getConfig("site.theme.basePath");
	}
	
	/**
	 * 前台主题模板路径
	 * @return
	 */
	public static String getThemePath(){
		return getThemeBasePath() + getTheme();
	}
	
	public static String getProjectPath(){
		return getConfig("gen.projectPath");
	}
}
