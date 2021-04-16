package com.gdcp.design.dao;

import com.gdcp.design.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface registerDao {

    @Insert("INSERT INTO user(id,username,password,study) VALUES(0,#{username},#{password},#{study})")
    public boolean UserRegister(User user);

    @Select("select * from user where username=#{username}")
    public String UserRegisterCheckUsername(String username);


    @Insert("INSERT INTO userdata(userid,bookid,word,memory) VALUES(#{userid},1,0,10)")
    public boolean UserDataRegister(int userid);
}
