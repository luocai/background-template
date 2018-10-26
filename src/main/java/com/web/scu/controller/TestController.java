package com.web.scu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {



    @Autowired
    JavaMailSender jms;


    @RequestMapping("/scu")
    public String write(){

        return "index-intro";
    }

    @RequestMapping("/logining")
    public String test1(){

        return "base/framework1";

    }

    @RequestMapping("/write")
    public String test2(){

        return "addArticle";

    }


    @RequestMapping("/list")
    public String test3(){

        return "article/listNotice";
    }


    @RequestMapping("/toLogin")
    public String test4(){

        return "test";
    }




    @RequestMapping("/send")
    public String send(){
        //建立邮件消息
        SimpleMailMessage mainMessage = new SimpleMailMessage();
        //发送者
        mainMessage.setFrom("15958038249@163.com");
        //接收者
        mainMessage.setTo("1146723697@qq.com");
        //发送的标题
        mainMessage.setSubject("嗨喽");

        //发送的内容
        mainMessage.setText("hello world");
        jms.send(mainMessage);
        return "1";
    }





}
