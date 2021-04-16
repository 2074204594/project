package com.gdcp.design.controller;

import com.gdcp.design.entity.Book;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.entity.User;
import com.gdcp.design.entity.Userdata;
import com.gdcp.design.service.registerService;
import com.gdcp.design.service.studyService;
import com.gdcp.design.service.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private userService userService;
    @Autowired
    private registerService registerService;
    @Autowired
    private com.gdcp.design.service.studyService studyService;

//    获得用户的userdata
    @RequestMapping("/getUserDetailMemory.do")
    @ResponseBody
    public Userdata getuserDetailUserData(String username){
//        利用传递进来的用户名获取userid，再利用userid获得userdata
        User user=userService.getUserDetail(username);
        int userid=user.getId();
        return userService.getuserDetailUserData(userid);
    }

    //    获得用户的现在使用的词库
    @RequestMapping(value = "/getUserDetailBookname.do",produces ="text/html; charset=UTF-8")
    @ResponseBody
    public String getuserDetailBook(String username){
//        利用传递进来的用户名获取userid，再利用userid获得userdata,再使用userdata里的bookid，去book里找bookname
        User user=userService.getUserDetail(username);
        Userdata userdata=userService.getuserDetailUserData(user.getId());
        Book book=userService.getuserDetailBook(userdata.getBookid());
        return book.getBookname();
    }

//    获取进度条
    @RequestMapping("/getUserDetailProgress.do")
    @ResponseBody
    public String getUserDetailProgress(String username){
    //        利用传递进来的用户名获取userid，再利用userid获得userdata,取得已背单词量，再利用bookid获取book，取到总单词量
        User user=userService.getUserDetail(username);
        Userdata userdata=userService.getuserDetailUserData(user.getId());
        int word1=userdata.getWord();
        Book book=userService.getuserDetailBook(userdata.getBookid());
        int word2=book.getWord();
        String str=word1+","+word2;
        return str;
    }

//    获取今天的单词
    @RequestMapping("/getUserDetailTodayWord.do")
    @ResponseBody
    public List<BookDetail> getUserDetailTodayWord(String username){
        List<BookDetail> bookDetail=new ArrayList<>();
//        判断今天是否已经背诵了,使用用户名到user查询今天是否背诵了
        User user=userService.getUserDetail(username);
        if(user.getStudy()==1){//今天已经背诵，返回空
            return bookDetail;
        }
//        if(user.getStudy()==2){
//            //        增加已被单词
//            int userid=userService.getUserDetail(username).getId();//获取userid
//            int memory=userService.getuserDetailUserData(userid).getMemory();//获取memory
//            int myword=userService.getuserDetailUserData(userid).getWord();//获取我已经背诵的词汇
//            int bookid=userService.getuserDetailUserData(userid).getBookid();//获取bookid
//            int word=userService.getuserDetailBook(bookid).getWord();//获取总词量
//            if(word<=myword+memory){
//                studyService.editUserdataWord(userid,memory);
//                System.out.println(userid+memory);
//            }else{//当最后时，所加的不应超过总词汇量
//                int add=word-myword;
//                studyService.editUserdataWord(userid,add);
//                System.out.println(userid+add);
//            }
//            studyService.updateStudyCompleteed(username);
//            return bookDetail;
//        }
        Userdata userdata=userService.getuserDetailUserData(user.getId());//获取用户的使用库，从中获取记忆模式和已背单词和词表
        int memory=userdata.getMemory();//记忆模式
        int word=userdata.getWord();//已背单词
        int bookid=userdata.getBookid();//词表
        //使用bookid获取book里的数据库名
        Book book=userService.getuserDetailBook(bookid);
        String listname=book.getListname();
        bookDetail=userService.getUserDetailTodayWord(listname,word,memory);
        return bookDetail;
    }

//    修改用户账号信息
    @RequestMapping("/editUserUsername.do")
    @ResponseBody
    public int editUserUsername(String newname,String username){
//        判断修改的姓名是否存在，存在就返回修改失败
        User newuser=userService.getUserByUsername(newname);
        if(newuser!=null){
            return 0;
        }
        //查不到相同名字的，则user为null，使用username去查询到要修改的id，进行修改
        User olduser=userService.getUserByUsername(username);
        return 1;
    }

//    修改用户记忆模式
    @RequestMapping("/editUserMemory.do")
    @ResponseBody
    public int editUserMemory(String newmemory,String username){
//        通过username查找user中的userid，使用userid去修改userdata中的记忆模式
        User user=userService.getUserByUsername(username);
        int userid=user.getId();
        return userService.editUserMemory(userid,newmemory);
    }


//    修改用户密码
    @RequestMapping("/editUserPassword.do")
    @ResponseBody
    public int editUserPassword(String username,String oldpassword,String newpassword){
//        使用用户名和密码查询，如果查询得到就表示旧密码正确，可以修改密码
        User user=userService.getUserByUsernameANDPassword(username,oldpassword);
        if(user==null){//查询不到，返回0
            return 0;
        }
        return userService.editUserPassword(username,newpassword);
    }

    //    修改用户书库
    @RequestMapping("/editUserBook.do")
    @ResponseBody
    public int editUserBook(String username,String newbook){
//        使用newbook查询到bookid
        Book book=userService.getBookId(newbook);
        int bookid=book.getBookid();
        User user=userService.getUserDetail(username);//使用username获取userid
        int userid=user.getId();
        Userdata userdata=userService.getuserDetailUserData(userid);//使用userid获取userdata
        //       修改名字问username的bookid，并重置学习进度
        userService.editUserBook(userid,bookid);
        userService.resetUserdata(userid);
//        修改热度
        userService.updateBookHot(bookid);
        return 1;
    }


    @RequestMapping("/getReadedUsername.do")
    @ResponseBody
    public List<String> getReadedUsername(int limit,int limited){
//        获取所有study=1的用户
        List<String> list=userService.getReadedUsername(limit,limited);
        System.out.println(list);
        return list;
    }

//    getAllUser

    @RequestMapping("/getAllUser.do")
    @ResponseBody
    public int getAllUser(){
        System.out.println(userService.getAllUser());
        int num=0;
        for(int i=0;i<userService.getAllUser().size();i++){
            num++;
        }
        return num;
    }
}
