package com.gdcp.design.utils.ai.utils;


import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

//鉴权机制，获取tok
public class ArrayAuthService {
    public static  String getArrayAuth(){
//        访问百度api
        String apiKey="PVLFr7zojXGGfxc4UMjOnxHP";
        String secretKey="n43Io2qBz0Lw2ql91xwVPpltZNuZGPqk";
        try {
            return  getArrayAuth(apiKey,secretKey);
        } catch (Exception e) {
            System.out.println("获取token失败");
            e.printStackTrace();
        }
        return null;
    }
//调用百度的鉴权机制,百度ai调用时都需要鉴权机制
    /*
    * 地址https://aip.baidubce.com/oauth/2.0/token
    *参数：
    * grant_type： 必须参数，固定为client_credentials；
      client_id： 必须参数，应用的API Key；
      client_secret： 必须参数，应用的Secret Key；
    * */
    private static String getArrayAuth(String apiKey, String secretKey) throws Exception{
//        确定百度获取token的地址
        String authHostUrl="https://openapi.baidu.com/oauth/2.0/token?";
        String getArrayAuthUrl=authHostUrl+"grant_type=client_credentials"+"&client_id="+apiKey+"&client_secret="+secretKey;
//        创建url访问鉴权
        URL arrayUrl=new URL(getArrayAuthUrl);
//        打开链接
        HttpURLConnection con= (HttpURLConnection) arrayUrl.openConnection();
//        设置url的get或post
        con.setRequestMethod("GET");
        con.connect();;
//        获取head
        Map<String, List<String>> map=con.getHeaderFields();
//        获取响应头文件
        for(String key:map.keySet()){
            System.err.print("key="+key+"value="+map.get(key));
        }
//        定义输入流读取响应的url
        BufferedReader in =new BufferedReader(new InputStreamReader(con.getInputStream()));
        String res="";
        String line="";
        while ((line=in.readLine())!=null){
            res+=line;
        }
        System.err.println("res="+res);
//        返回结果res=token
        JSONObject json= new JSONObject(res);
        String access_token=json.getString("access_token");
        System.out.println(access_token);
        return access_token;
    }
}
