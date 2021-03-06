package com.framework.utils;

import java.util.Properties;
 
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
 
 
public class SendMail {
	/**
	 *
	 * @param subject  邮件标题
	 * @param text  邮件正文
	 * @param sendToWho  发给谁    QQ/163用户均可
	 * @throws MessagingException
	 */
    public static void sendEmail(String subject,String text,String sendToWho) throws MessagingException {
		 Properties properties = new Properties();
		//设置访问smtp服务器需要认证
	        properties.setProperty("mail.smtp.auth", "true");
		//设置访问服务器的协议
	        properties.setProperty("mail.transport.protocol", "smtp");
	          
	        Session session = Session.getDefaultInstance(properties);
		//打开debug功能
	        session.setDebug(true);
	          
	        Message msg = new MimeMessage(session);  
	        //这里填你登录163邮箱所用的用户名
		//设置发件人，163邮箱要求发件人与登录用户必须一致（必填），其它邮箱不了解
	        msg.setFrom(new InternetAddress("beixin666666@163.com"));
	        msg.setSubject(subject); //设置邮件主题  
	        msg.setText(text); //设置邮件内容  
	        
	          
	        Transport trans = session.getTransport();  
	        //下面四个参数，前两个可以认为是固定的，不用变，后两个参数分别是登录163邮箱的用户名以及客户端授权密码（注意，不是登录密码）
	        trans.connect("smtp.163.com", 25, "beixin666666@163.com", "1291482971a"); //连接邮箱smtp服务器，25为默认端口

		//要发送到哪个邮箱，这里以qq邮箱为例
	        trans.sendMessage(msg, new Address[]{new InternetAddress(sendToWho)}); //发送邮件
	          
	        trans.close(); //关闭连接  
	}
}