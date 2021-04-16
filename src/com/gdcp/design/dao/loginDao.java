package com.gdcp.design.dao;

import com.gdcp.design.entity.User;
import org.apache.ibatis.annotations.Select;

public interface loginDao {
    @Select("select * from user where username=#{username} and password=#{password}")
    public String login(User user);
}
