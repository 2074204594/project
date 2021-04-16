package com.gdcp.design.service;

import com.gdcp.design.entity.Book;

import java.util.List;

public interface bookService {
    public List<Book> findAllBook();

    public List<Book> findHotBook();
}
