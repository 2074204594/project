package com.gdcp.design.controller;

import com.gdcp.design.utils.ai.sps.SpSth;
import com.gdcp.design.utils.mp3.MP3Player;
import com.gdcp.design.utils.translate.Main;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ai")
public class AiController {

//    翻译部分
    @RequestMapping(value="/translate.do",produces ="text/html; charset=UTF-8")
    @ResponseBody
    public String translate(String word) throws Exception {
        String language="";//判断中英互译
        if(word.matches("[a-zA-Z]+")){
            language="zh";
        }else {
            language="en";
        }
        Main main=new Main();//翻译
        String str=main.Main(word,language);
        try{
            SpSth spSth=new SpSth(str,"first");//语音合成
            SpSth spSth01=new SpSth(word,"second");
        }catch (Exception e){
            SpSth spSth=new SpSth("失败","first");//语音合成
            SpSth spSth01=new SpSth("生成的单词超过两句","second");
            return str;
        }
        return str;
    }

    @RequestMapping("/playMP3.do")
    public void PlayMP3(){
        MP3Player mp3 = new MP3Player("I:\\Java01\\designIntegration\\design_03\\src\\com\\gdcp\\design\\utils\\mp3\\first.mp3");
        MP3Player mp4 = new MP3Player("I:\\Java01\\designIntegration\\design_03\\src\\com\\gdcp\\design\\utils\\mp3\\second.mp3");
        mp4.play();
        mp3.play();
    }
}
