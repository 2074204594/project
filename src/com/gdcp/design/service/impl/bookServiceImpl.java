package com.gdcp.design.service.impl;

import com.gdcp.design.dao.bookDao;
import com.gdcp.design.entity.Book;
import com.gdcp.design.service.bookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class bookServiceImpl implements bookService {
    @Autowired
    private bookDao bookDao;

    public List<Book> findAllBook(){
        return bookDao.findAllBook();
    }

    @Override
    public List<Book> findHotBook() {
        return bookDao.findHotBook();
    }

    ;
}
