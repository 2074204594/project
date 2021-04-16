package com.gdcp.design.service;

import com.gdcp.design.entity.User;

public interface registerService {
    public boolean UserRegister(User user);

    public String UserRegisterCheckUsername(String username);

    public boolean UserDataRegister(int userid);
}
