package com.qf.oa.controller;


import com.qf.oa.interceptor.Page;
import com.qf.oa.interceptor.PagePlugin;
import org.springframework.beans.PropertyValuesEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletRequest;


/**
 *
 * 组长在这个地方写了一段注释
 *
 * @author ken
 *
 */
@ControllerAdvice
public class BaseController {

	/**
	 * @InitBinder - 表示初始化绑定
	 * 该注解标记的方法会先于controller的方法执行，初始化方法的参数
	 */
	@InitBinder
	public void init(WebDataBinder webDataBinder, final HttpServletRequest request){
		webDataBinder.registerCustomEditor(Page.class, new PropertyValuesEditor() {
			@Override
			public void setValue(Object value) {
				Page page = (Page) value;
				//动态设置page的url
				String url = request.getRequestURL().toString();
				//获得传递过来的参数
				String params = request.getQueryString();
				if(params == null){
					url += "?1=1";
				} else {
					url += "?" + params;
				}

				if(url.indexOf("&page=") != -1){
					url = url.substring(0, url.indexOf("&page="));
				}
				page.setUrl(url);

				//开始分页
				PagePlugin.startPage(page);

				super.setValue(page);
			}
		});
	}
}

/**
 * 组员在这里写了一段注释
 */

