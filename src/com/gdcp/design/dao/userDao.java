package com.gdcp.design.dao;

import com.gdcp.design.entity.Book;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.entity.User;
import com.gdcp.design.entity.Userdata;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface userDao {

    @Select("select * from user where username=#{username}")
    public User getUserDetail(String username);

    @Select("select * from userdata where userid=#{userid}")
    public Userdata getuserDetailUserData(int userid);

    @Select("select * from book where bookid=#{bookid}")
    public Book getuserDetailBook(int bookid);

    @Select("select * from ${arg0} limit #{arg1},#{arg2}")//多个的时候得使用#{arg0} 使用表的时候得用${}   #{}会个''  ${}直接导入
    public List<BookDetail> getUserDetailTodayWord(String listname, int word, int memory);

    @Select("select * from user where username=#{username}")
    public User getUserByUsername(String username);

    @Update("UPDATE user SET username=#{arg1} where id=#{arg0}")
    public int editUserUsername(int userid,String newname);

    @Update("UPDATE userdata SET memory=#{arg1} where userid=#{arg0}")
    public int editUserMemory(int userid,String newmemory);

    @Select("select * from user where username=#{arg0} and password=#{arg1}")
    public User getUserByUsernameANDPassword(String username,String oldpassword);

    @Update("UPDATE user SET password=#{arg1} where username=#{arg0}")
    public int editUserPassword(String username,String newpassword);

    @Update("UPDATE user SET study=1 where username=#{arg0}")
    public int updateStudyComplete(String username);

    @Select("select * from book where bookname=#{newbook}")
    public Book getBookId(String newbook);

    @Update("UPDATE userdata SET bookid=#{arg1} where userid=#{arg0}")
    public int editUserBook(int userid,int bookid);

    @Update("UPDATE userdata SET word=0 where userid=#{arg0}")
    public int resetUserdata(int userid);


    @Select("select username from user where study=1  limit #{arg0},#{arg1}")
    public List<String> getReadedUsername(int limit,int limited);

    @Select("select * from user where study=1")
    public List<User> getAllUser();

    @Update("UPDATE book SET bookhot=bookhot+1 where bookid=#{arg0}")
    public void updateBookHot(int bookid);
}
