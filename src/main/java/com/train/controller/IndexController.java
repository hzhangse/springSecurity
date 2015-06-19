package com.train.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.train.model.User;

public class IndexController extends AbstractCompanyController {

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("index");
		String username = getUsername();
		User user = userService.getByUsername(username);
		mav.addObject("user", user);
		return mav;
	}

}
