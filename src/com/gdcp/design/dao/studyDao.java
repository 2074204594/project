package com.gdcp.design.dao;

import com.gdcp.design.entity.BookDetail;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface studyDao {
    @Select("select * from ${arg0} where id=#{arg1}")
    public BookDetail getGame(String listname, int num);

//    @Insert("INSERT INTO daily(id,word,bookid,english,example,examplelose,exampleword,wordclasses,symbols,answer) VALUES(0,#{word},#{bookid},#{english},#{example},#{examplelose},#{exampleword},#{wordclasses},#{symbols},#{answer})")
//    public void add(BookDetail bookDetail);
    @Update("UPDATE userdata SET word=word+${arg1} where userid=#{arg0}")
    public int editUserdataWord(int userid,int memory);

    @Update("UPDATE user SET study=1 where username=#{arg0}")
    public int updateStudyCompleteed(String username);
}
