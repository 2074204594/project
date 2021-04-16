package com.gdcp.design.entity;

public class Userdata {
    private int id;
    private int userid;//广联的用户id
    private int bookid;//使用的书库
    private int word;//已背单词
    private int memory;//记忆模式

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public int getWord() {
        return word;
    }

    public void setWord(int word) {
        this.word = word;
    }

    public int getMemory() {
        return memory;
    }

    public void setMemory(int memory) {
        this.memory = memory;
    }

    @Override
    public String toString() {
        return "Userdata{" +
                "id=" + id +
                ", userid=" + userid +
                ", bookid=" + bookid +
                ", word=" + word +
                ", memory=" + memory +
                '}';
    }
}
