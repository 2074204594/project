package com.gdcp.design.controller;

import com.gdcp.design.entity.Book;
import com.gdcp.design.entity.BookDetail;
import com.gdcp.design.entity.User;
import com.gdcp.design.entity.Userdata;
import com.gdcp.design.service.studyService;
import com.gdcp.design.service.userService;
import com.gdcp.design.utils.ai.sps.SpSth;
import com.gdcp.design.utils.mp3.MP3Player;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/study")
public class StudyController {
    @Autowired
    private userService userService;
    @Autowired
    private studyService studyService;

    @RequestMapping("/getVoice.do")
    @ResponseBody
    public int getVoiceByUsername(String username) throws Exception {
        List<BookDetail> bookDetail=new ArrayList<>();
//        判断今天是否已经背诵了,使用用户名到user查询今天是否背诵了
        User user=userService.getUserDetail(username);
        if(user.getStudy()==1){//今天已经背诵，返回空
            return 0;
        }
        Userdata userdata=userService.getuserDetailUserData(user.getId());//获取用户的使用库，从中获取记忆模式和已背单词和词表
        int memory=userdata.getMemory();//记忆模式
        int word=userdata.getWord();//已背单词
        int bookid=userdata.getBookid();//词表
        //使用bookid获取book里的数据库名
        Book book=userService.getuserDetailBook(bookid);
        String listname=book.getListname();
        bookDetail=userService.getUserDetailTodayWord(listname,word,memory);
        SpSth spSth;
        SpSth spSth01;
        for(int i=0;i<bookDetail.size();i++){
            try {
                File file = new File("I:\\Java01\\designIntegration\\design_03\\src\\com\\gdcp\\design\\utils\\mp3\\"+bookDetail.get(i).getEnglish()+"en"+".mp3");
                if(file.isFile() && file.exists()) {
                } else {
                    //            语音合成
                    spSth=new SpSth(bookDetail.get(i).getEnglish(),bookDetail.get(i).getEnglish()+"en");//英文
                    System.out.println("文件不存在就生成文件");
                }
            } catch (Exception e) {
                System.out.println("文件读取错误!");
            }
        }
        return 1;
    }

//    获取今天的单词
    @RequestMapping("/getStudyMyWord.do")
    @ResponseBody
    public List<BookDetail> getStudyMyWord(String username){//获取学习的单词
        //获取到记忆模式和已记忆的单词量，及记忆的书库
        User user =userService.getUserByUsername(username);//获取user
        Userdata userdata=userService.getuserDetailUserData(user.getId());//获取到userdata
        Book book=userService.getuserDetailBook(userdata.getBookid());//获取book
        List<BookDetail> list=userService.getUserDetailTodayWord(book.getListname(),userdata.getWord(),userdata.getMemory());//获取返回的值
        System.out.println("getStudyMyWord="+list);
        return list;
    }

//  修改完成学习
    @RequestMapping("/studyComplete.do")
   public void studyComplete(String username){
        userService.updateStudyComplete(username);
   }

//   点击播放MP3
    @RequestMapping("/PlayMP3.do")
    public void PlayMP3(String MP3Name){
        MP3Player mp3 = new MP3Player("I:\\Java01\\designIntegration\\design_03\\src\\com\\gdcp\\design\\utils\\mp3\\"+MP3Name+".mp3");
        mp3.play();
    }

    //    获取游戏单词
    @RequestMapping("/getGame.do")
    @ResponseBody
    public List<BookDetail> getGame(String username){//获取学习的单词
        List<BookDetail> listBookDetail=new ArrayList();
        //获取到记忆模式和已记忆的单词量，及记忆的书库
        User user =userService.getUserByUsername(username);//获取user
        Userdata userdata=userService.getuserDetailUserData(user.getId());//获取到userdata
        int bookid=userdata.getBookid();//获取bookid，以来查询数据表名字
        String listname=userService.getuserDetailBook(bookid).getListname();
        Book book=userService.getuserDetailBook(bookid);//当背诵单词少于10时获取book
//        如果已经背诵了超过10个单词，会从已经背诵的单词里随机抽取当游戏单词
        List list=new ArrayList();
        if(userdata.getWord()>=10){
            for(int i=0;i<2;i++){
                boolean flag=true;
                int num=(int)(Math.random()*(userdata.getWord())+1);//生成随机数并获取指定单词
                    if (list.size()==0){//判断是否为数组的第一个，若是则直接使用
                        list.add(num);
                        BookDetail bookDetail=studyService.getGame(listname,num);
                        listBookDetail.add(bookDetail);
                    }else{
                        while(flag){//判断不是数组的第一个，则进行比较看是否已经存在
                            for(int j=0;j<list.size();j++){
                                if (list.get(j).equals(num)){//若是已经存在，则需要重新生成随机数并重新进行for循环进行比较
                                    num=(int)(Math.random()*(userdata.getWord())+1);//生成随机数并获取指定单词
                                    j=-1;
                                }
                            }
                            BookDetail bookDetail=studyService.getGame(listname,num);
                            listBookDetail.add(bookDetail);
                            list.add(num);
                            flag=false;

                        }
                    }
            }
        }else{
            for(int i=0;i<10;i++){
                boolean flag=true;
                int num=(int)(Math.random()*(book.getWord())+1);//生成随机数并获取指定单词
                if (list.size()==0){//判断是否为数组的第一个，若是则直接使用
                    list.add(num);
                    BookDetail bookDetail=studyService.getGame(listname,num);
                    listBookDetail.add(bookDetail);
                }else{
                    while(flag){//判断不是数组的第一个，则进行比较看是否已经存在
                        for(int j=0;j<list.size();j++){
                            if (list.get(j).equals(num)){//若是已经存在，则需要重新生成随机数并重新进行for循环进行比较
                                num=(int)(Math.random()*(book.getWord())+1);//生成随机数并获取指定单词
                                j=-1;
                            }
                        }
                        BookDetail bookDetail=studyService.getGame(listname,num);
                        listBookDetail.add(bookDetail);
                        list.add(num);
                        flag=false;
                        System.out.println("list="+list);
                    }
                }
            }
        }
        System.out.println(list);
        return listBookDetail;
    }

//    @RequestMapping("/add.do")
//    @ResponseBody
//    public void add(String username){
//
//        for(int i=0;i<10;i++){
//            BookDetail bookDetail=new BookDetail();
//            BookDetail bookDetail1=new BookDetail();
//            BookDetail bookDetai2=new BookDetail();
//            BookDetail bookDetail3=new BookDetail();
////        0,"网状物",4,"web","A spider had spun a perfect web outside the window.","A spider had spun a perfect _____ outside the window.","蜘蛛在窗外结了一张完整的网.","n","[web]","web"
//            bookDetail.setId(0);
//            bookDetail.setWord("网状物");
//            bookDetail.setEnglish("web");
//            bookDetail.setBookid(4);
//            bookDetail.setExample("A spider had spun a perfect web outside the window.");
//            bookDetail.setExamplelose("A spider had spun a perfect _____ outside the window.");
//            bookDetail.setExampleword("蜘蛛在窗外结了一张完整的网.");
//            bookDetail.setWordclasses("n");
//            bookDetail.setSymbols("[web]");
//            bookDetail.setAnswer("web");
//
//            bookDetail1.setId(0);
//            bookDetail1.setWord("玻璃");
//            bookDetail1.setEnglish("glass");
//            bookDetail1.setBookid(4);
//            bookDetail1.setExample("The windowpane is broken.");
//            bookDetail1.setExamplelose("The windowpane is _____.");
//            bookDetail1.setExampleword("窗玻璃被打了");
//            bookDetail1.setWordclasses("n");
//            bookDetail1.setSymbols("[[ɡlɑːs]");
//            bookDetail1.setAnswer("glass");
//
////            3	手机	4	mobile	He forgot the charger for his mobile phone.	He forgot the charger for his _____.	忘了带手机充电器	n	[ˌməʊbaɪl ˈfəʊn]	mobile
//            bookDetai2.setId(0);
//            bookDetai2.setWord("手机");
//            bookDetai2.setEnglish("web");
//            bookDetai2.setBookid(4);
//            bookDetai2.setExample("He forgot the charger for his mobile phone.");
//            bookDetai2.setExamplelose("He forgot the charger for his _____.");
//            bookDetai2.setExampleword("忘了带手机充电器.");
//            bookDetai2.setWordclasses("n");
//            bookDetai2.setSymbols("[ˌməʊbaɪl ˈfəʊn]");
//            bookDetai2.setAnswer("mobile");
////6	商店	4	Shop	I recognize the shop. 	I recognize the _____. 	我认得那家商店。	n	[ʃɒp]	shop
//            bookDetail3.setId(0);
//            bookDetail3.setWord("商店");
//            bookDetail3.setEnglish("Shop");
//            bookDetail3.setBookid(4);
//            bookDetail3.setExample("I recognize the shop.");
//            bookDetail3.setExamplelose("I recognize the _____.");
//            bookDetail3.setExampleword("我认得那家商店。");
//            bookDetail3.setWordclasses("n");
//            bookDetail3.setSymbols("[ʃɒp]");
//            bookDetail3.setAnswer("shop");
//            studyService.add(bookDetail3);
//            studyService.add(bookDetai2);
//            studyService.add(bookDetail1);
//            studyService.add(bookDetail);
//        }
//
//    }

}
