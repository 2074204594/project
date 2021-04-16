package com.gdcp.design.utils.translate;

import com.alibaba.fastjson.JSON;

import java.io.UnsupportedEncodingException;

public class Main {

    // 在平台申请的APP_ID 详见 http://api.fanyi.baidu.com/api/trans/product/desktop?req=developer
    private static final String APP_ID = "20201020000593984";
    private static final String SECURITY_KEY = "7mDLz0CRnfm46Q18tCBC";

    public String Main(String word,String language) throws UnsupportedEncodingException {
        TransApi api = new TransApi(APP_ID, SECURITY_KEY);
        String query = word;
//        将翻译的值转化为str
        String str=api.getTransResult(query, "auto", language);
//        将json格式的返回值转化为string
        String str1= String.valueOf(JSON.parse(str));
//        以,分割字符串
        String resu[] = str1.split("\\,");
//        获取包含翻译结果的那一部分
        String str2=resu[2];
//        再以:为分割
        String resu1[] = str2.split("\\:");
//        获取包含双引号的翻译
        String str3=resu1[2];
//        去除双引号
        String str4=str3.substring(1,str3.length()-1);
        System.out.println(str4);
        return str4;
    }
}
