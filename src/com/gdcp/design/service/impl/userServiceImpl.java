package com.gdcp.design.service.impl;

import com.gdcp.design.dao.userDao;
import com.gdcp.design.entity.Book;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.entity.User;
import com.gdcp.design.entity.Userdata;
import com.gdcp.design.service.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class userServiceImpl implements userService {
    @Autowired
    private userDao userDao;

    @Override
    public User getUserDetail(String username) {
        return userDao.getUserDetail(username);
    }

    @Override
    public Userdata getuserDetailUserData(int userid) {
        return userDao.getuserDetailUserData(userid);
    }

    @Override
    public Book getuserDetailBook(int bookid) {
        return userDao.getuserDetailBook(bookid);
    }

    @Override
    public List<BookDetail> getUserDetailTodayWord(String listname, int word, int memory) {
        return userDao.getUserDetailTodayWord(listname,word,memory);
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.getUserByUsername(username);
    }

    @Override
    public int editUserUsername(int userid, String newname) {
        return userDao.editUserUsername(userid,newname);
    }

    @Override
    public int editUserMemory(int userid, String newmemory) {
        return userDao.editUserMemory(userid,newmemory);
    }

    @Override
    public User getUserByUsernameANDPassword(String username, String oldpassword) {
        return userDao.getUserByUsernameANDPassword(username,oldpassword);
    }

    @Override
    public int editUserPassword(String username, String newpassword) {
        return userDao.editUserPassword(username,newpassword);
    }

    @Override
    public int updateStudyComplete(String username) {
        return userDao.updateStudyComplete(username);
    }

    @Override
    public Book getBookId(String newbook) {
        return userDao.getBookId(newbook);
    }

    @Override
    public int editUserBook(int userid, int bookid) {
        return userDao.editUserBook(userid,bookid);
    }

    @Override
    public int resetUserdata(int userid) {
        return userDao.resetUserdata(userid);
    }


    @Override
    public List<String> getReadedUsername(int limit,int limited) {
        return userDao.getReadedUsername(limit,limited);
    }

    public List<User> getAllUser(){
        return userDao.getAllUser();
    }

    @Override
    public void updateBookHot(int bookid) {
        userDao.updateBookHot(bookid);
    }

    ;

}
