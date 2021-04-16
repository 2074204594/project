package com.gdcp.design.entity;

public class Book {
    private int bookid;
    private String bookname;//书名
    private int bookhot;//点击次数
    private int word;//词汇
    private String category;//书库类型
    private String listname;//数据对应的表名

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public int getBookhot() {
        return bookhot;
    }

    public void setBookhot(int bookhot) {
        this.bookhot = bookhot;
    }

    public int getWord() {
        return word;
    }

    public void setWord(int word) {
        this.word = word;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getListname() {
        return listname;
    }

    public void setListname(String listname) {
        this.listname = listname;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookid=" + bookid +
                ", bookname='" + bookname + '\'' +
                ", bookhot=" + bookhot +
                ", word=" + word +
                ", category='" + category + '\'' +
                ", listname='" + listname + '\'' +
                '}';
    }
}
