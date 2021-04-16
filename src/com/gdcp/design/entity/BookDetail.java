package com.gdcp.design.entity;

public class BookDetail {
    private int id;//id
    private String word;//中文
    private int bookid;//对应book表的id
    private String english;//英文
    private String example;//例句
    private String examplelose;//例句题目
    private String exampleword;//例句中文
    private String wordclasses;//音标
    private String symbols;//音标
    private String answer;//答案

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getExample() {
        return example;
    }

    public void setExample(String example) {
        this.example = example;
    }

    public String getExamplelose() {
        return examplelose;
    }

    public void setExamplelose(String examplelose) {
        this.examplelose = examplelose;
    }

    public String getExampleword() {
        return exampleword;
    }

    public void setExampleword(String exampleword) {
        this.exampleword = exampleword;
    }

    public String getWordclasses() {
        return wordclasses;
    }

    public void setWordclasses(String wordclasses) {
        this.wordclasses = wordclasses;
    }

    @Override
    public String toString() {
        return "BookDetail{" +
                "id=" + id +
                ", word='" + word + '\'' +
                ", bookid=" + bookid +
                ", english='" + english + '\'' +
                ", example='" + example + '\'' +
                ", examplelose='" + examplelose + '\'' +
                ", exampleword='" + exampleword + '\'' +
                ", wordclasses='" + wordclasses + '\'' +
                ", symbols='" + symbols + '\'' +
                ", answer='" + answer + '\'' +
                '}';
    }

    public String getSymbols() {
        return symbols;
    }

    public void setSymbols(String symbols) {
        this.symbols = symbols;
    }


}
