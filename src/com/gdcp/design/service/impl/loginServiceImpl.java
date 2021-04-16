package com.gdcp.design.service.impl;

import com.gdcp.design.dao.loginDao;
import com.gdcp.design.entity.User;
import com.gdcp.design.service.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class loginServiceImpl implements loginService {
    @Autowired
    private loginDao loginDao;

    @Override
    public String login(User user) {
        return loginDao.login(user);
    }
}
