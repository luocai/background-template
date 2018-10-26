package com.web.scu.service;

import com.web.scu.pojo.Notice;

import java.util.List;

public interface NoticeService {

    void add(Notice notice);

    void delete(Integer id);

    void update(Notice notice);

    Notice queryById(Integer id);

    List<Notice> queryByTitle(String title);

    List<Notice> queryAll();
}
