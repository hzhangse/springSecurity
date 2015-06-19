package com.train.controller;

import org.springframework.web.servlet.mvc.AbstractController;

import com.train.service.UserService;
import com.train.service.UsernameHolder;

public abstract class AbstractCompanyController extends AbstractController {
	
	protected UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getUsername() {
		return UsernameHolder.getAuthenticatedUsername();
	}
}
