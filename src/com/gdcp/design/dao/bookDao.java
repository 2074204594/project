package com.gdcp.design.dao;

import com.gdcp.design.entity.Book;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface bookDao {
    @Select("select * from book")
    public List<Book> findAllBook();

    @Select("select * from book order by bookhot desc limit 0,5")
    public List<Book> findHotBook();
}
