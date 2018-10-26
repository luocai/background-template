package com.web.scu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.web.scu.common.Constant;
import com.web.scu.common.Result;
import com.web.scu.pojo.Notice;
import com.web.scu.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;


    @RequestMapping(value = "/toAdd")
    public String toAdd(){

        return "addNotice";

    }



    @RequestMapping(value = "/notice",method = RequestMethod.POST)
    @ResponseBody
    public Result addNotice(@RequestParam("title") String title,
                            @RequestParam("content") String content){
        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setClick(0);
        notice.setCreatetime(new Date());

        try {
            noticeService.add(notice);
            return new Result(Constant.RESULT_CODE_SUCCESS);
        }catch (Exception e){
            return new Result(Constant.RESULT_CODE_SERVER_ERROR,"服务器错误");
        }

    }


    @RequestMapping(value = "/notice/list")
    public String listAll( Model model,
                          @RequestParam(required = false,defaultValue = "1") Integer page,
                          @RequestParam(required = false,defaultValue = "4") Integer pageSize){

        PageHelper.startPage(page,pageSize);
        List<Notice> noticeList = noticeService.queryAll();

        PageInfo<Notice> pageInfo = new PageInfo<>(noticeList,5);

        model.addAttribute("noticeList",noticeList);
        model.addAttribute("pageInfo",pageInfo);
        return "listNotice";
    }

    @RequestMapping(value = "/notice/delete",method = RequestMethod.POST)
    @ResponseBody
    public Result delete(Integer noticeId){

        System.out.println(noticeId);
        try {
            noticeService.delete(noticeId);
            return new Result(Constant.RESULT_CODE_SUCCESS);
        }catch (Exception e){

            return new Result(Constant.RESULT_CODE_SERVER_ERROR,"服务器出错");
        }


    }


    @RequestMapping(value = "/notice/deleteSome",method = RequestMethod.POST)
    @ResponseBody
    public Result deleteSome(String checkedList){

        String[] ids = checkedList.split(",");
System.out.println(ids + "nice");
        try {
            for (String id : ids){
                noticeService.delete(Integer.parseInt(id));
            }
            return new Result(Constant.RESULT_CODE_SUCCESS);
        }catch (Exception e){
            return new Result(Constant.RESULT_CODE_SERVER_ERROR, "服务器出错");
        }
    }


    @RequestMapping("/queryByTitle")
    public String queryByTitle(Model model,String words){


        List<Notice> noticeList = noticeService.queryByTitle(words);

        model.addAttribute("noticeList",noticeList);
        model.addAttribute("flag",1);
        model.addAttribute("words",words);

        return "listNotice";
    }


}
