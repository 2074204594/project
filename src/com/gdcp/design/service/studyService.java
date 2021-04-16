package com.gdcp.design.service;

import com.gdcp.design.entity.BookDetail;

import java.util.List;

public interface studyService {

    public BookDetail getGame(String listname, int num);

//    public void add(BookDetail bookDetail);
public int editUserdataWord(int userid,int memory);

    public int updateStudyCompleteed(String username);
}
