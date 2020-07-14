package com.framework.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/14 19:03
 * @desc: //TODO
 */
public class DateUtil {
    public static String date2String(Date date){
        //Date指定格式：yyyy-MM-dd HH:mm:ss
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//        Date date = new Date();//创建一个date对象保存当前时间
        String formatResult = simpleDateFormat.format(date);//format()方法将Date转换成指定格式的String
//        System.out.println(formatResult);//2018-08-24 15:37:47

//        String string = "2018-8-24 12:50:20:545";
        //调用parse()方法时 注意 传入的格式必须符合simpleDateFormat对象的格式，即"yyyy-MM-dd HH:mm:ss" 否则会报错！
//        Date date2 = simpleDateFormat.parse(string);
//        System.out.println(date2);//Fri Aug 24 12:50:20 CST 2018
        return formatResult;
    }


    //只要日期
    public static String onlyDate(Date date){
        //Date指定格式：yyyy-MM-dd HH:mm:ss
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        Date date = new Date();//创建一个date对象保存当前时间
        String formatResult = simpleDateFormat.format(date);//format()方法将Date转换成指定格式的String
//        System.out.println(formatResult);//2018-08-24 15:37:47

//        String string = "2018-8-24 12:50:20:545";
        //调用parse()方法时 注意 传入的格式必须符合simpleDateFormat对象的格式，即"yyyy-MM-dd HH:mm:ss" 否则会报错！
//        Date date2 = simpleDateFormat.parse(string);
//        System.out.println(date2);//Fri Aug 24 12:50:20 CST 2018
        return formatResult;
    }


//    获取日期差===返回d2-d1相差的天数
    public static int differentDaysByMillisecond(Date date1,Date date2)
    {
        int days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
        return days;
    }
}
