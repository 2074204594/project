package com.gdcp.design.service;

import com.gdcp.design.entity.Book;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.entity.User;
import com.gdcp.design.entity.Userdata;

import java.util.List;

public interface userService {
    public User getUserDetail(String username);

    public Userdata getuserDetailUserData(int userid);

    public Book getuserDetailBook(int bookid);

    public List<BookDetail> getUserDetailTodayWord(String listname, int word, int memory);

    public User getUserByUsername(String username);

    public int editUserUsername(int userid,String newname);

    public int editUserMemory(int userid,String newmemory);

    public User getUserByUsernameANDPassword(String username,String oldpassword);

    public int editUserPassword(String username,String newpassword);

    public int updateStudyComplete(String username);

    public Book getBookId(String newbook);

    public int editUserBook(int userid,int bookid);

    public int resetUserdata(int userid);


    public List<String> getReadedUsername(int limit,int limited);

    public List<User> getAllUser();

    public void updateBookHot(int bookid);
}
