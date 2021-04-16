package com.gdcp.design.service.impl;

import com.gdcp.design.dao.registerDao;
import com.gdcp.design.entity.User;
import com.gdcp.design.service.registerService;
import com.gdcp.design.utils.CodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;

@Service
public class registerServiceImpl implements registerService {
    @Autowired
    private registerDao registerDao;

    @Override
    public boolean UserRegister(User user) {
        return registerDao.UserRegister(user);
    }

    @Override
    public String UserRegisterCheckUsername(String username) {
        return registerDao.UserRegisterCheckUsername(username);

    }

    @Override
    public boolean UserDataRegister(int userid) {
        return registerDao.UserDataRegister(userid);
    }

}
