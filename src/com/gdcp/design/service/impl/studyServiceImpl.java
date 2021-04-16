package com.gdcp.design.service.impl;

import com.gdcp.design.dao.studyDao;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.service.studyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class studyServiceImpl implements studyService {
    @Autowired
    private studyDao studyDao;

    @Override
    public BookDetail getGame(String listname, int num) {
        return studyDao.getGame(listname,num);
    }

    @Override
    public int editUserdataWord(int userid, int memory) {
        return studyDao.editUserdataWord(userid,memory);
    }

    @Override
    public int updateStudyCompleteed(String username) {
        return studyDao.updateStudyCompleteed(username);
    }

//    @Override
//    public void add(BookDetail bookDetail) {
//        studyDao.add(bookDetail);
//    }
}
