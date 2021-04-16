package com.gdcp.design.controller;

import com.gdcp.design.entity.Book;
import com.gdcp.design.service.bookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController {
    @Autowired
    private bookService bookService;

    @RequestMapping("/findAllBook.do")
    @ResponseBody
    public List<Book> findAllBook(){
        System.out.println(bookService.findAllBook());
        return bookService.findAllBook();
    }

    @RequestMapping("/findHotBook.do")
    @ResponseBody
    public List<Book> findHotBook(){
        System.out.println(bookService.findHotBook());
        return bookService.findHotBook();
    }
}
