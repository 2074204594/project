package com.gdcp.design.utils.ai.sps;
import com.gdcp.design.utils.ai.utils.ArrayAuthService;
import com.gdcp.design.utils.ai.utils.GetMacAddress;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.*;


public class SpSth {
    public SpSth(String word,String name) throws Exception{
//        获取cuid
        String ip="192.168.137.220";
        String cuid= GetMacAddress.getMacAddress(ip);
        System.out.println(cuid);

//        获取tok
//        鉴权机制token
        String tok= tok = ArrayAuthService.getArrayAuth();;
        System.out.println(tok);

//        定义转换的文字
        String tex=word;
//        组装语音合成url，开始语音合成
        String allUrl="http://tsn.baidu.com/text2audio?tex="+tex+"&lan=zh"+"&tok="+tok+"&ctp=1&cuid="+cuid;
        System.out.println("url="+allUrl);
//        通过get的方式调用百度合成语音
        CloseableHttpClient httpClient= HttpClients.createDefault();
        HttpGet httpGet=new HttpGet(allUrl);
        OutputStream outputStream=null;
        InputStream inputStream=null;
        try {
            CloseableHttpResponse response=httpClient.execute(httpGet);
//            打印状态
            System.out.println(response.getStatusLine());
//            解析内容
            HttpEntity entity=response.getEntity();
//            将成功获取的音频文件写入磁盘
            String newPath="I:\\Java01\\designIntegration\\design_03\\src\\com\\gdcp\\design\\utils\\mp3\\"+name+".mp3";
            File f=new File(newPath);

            outputStream=new FileOutputStream(f);
            if(entity!=null){
                inputStream=entity.getContent();//获取返回的内容
//                获取请求头的信息,有利于排查错误,与生成mp3无关
                Header headers[]=response.getAllHeaders();
                int m=0;
                while (m<headers.length){
                    System.out.println(headers[m].getName()+headers[m].getValue());
                    ++m;
                }
//                将流写入mp3中
                int ch=0;
                while ((ch=inputStream.read())!=-1){
                    outputStream.write(ch);

                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(inputStream!=null){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream!=null){
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
