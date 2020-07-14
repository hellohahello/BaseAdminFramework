package com.framework.utils;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class BaiDuYun {
    public static boolean isActive(String baiduURL) {

        try {
            Boolean isclosed = true; //标志是否失效，默认不失效
            URL url = new URL(baiduURL);//这里输入你要查询的链接
            try {
                InputStream is = url.openStream();
                InputStreamReader isr = new InputStreamReader(is, "utf-8");
                BufferedReader br = new BufferedReader(isr);
                StringBuilder sb = new StringBuilder();
                String data = br.readLine();
                while (data != null) {
                    data = br.readLine();
                    sb.append(data);
                }
                br.close();
                isr.close();
                is.close();
                String finaldata = sb.toString();
                if (finaldata.contains("分享的文件已经被取消了") || finaldata.contains("此链接分享内容可能因为涉及侵权") || finaldata.contains("你所访问的页面不存在了"))
                    isclosed = false;
                if (isclosed == true) {
                    System.out.println("该链接未失效！");
                    return true;
                } else {
                    System.out.println("该链接已失效！");
                    return false;
                }
            } catch (IOException e) {
                return false;
            }


        } catch (MalformedURLException e) {
           return false;
        }
    }

    public static void main(String[] args) {
        boolean active = BaiDuYun.isActive("https://pan.baidu.com/s/1SxEwkcgZI5p8A7c9dP6d1Q");
        System.out.println(active);
    }
}