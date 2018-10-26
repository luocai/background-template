package com.web.scu.service.Impl;

import com.web.scu.mapper.NoticeMapper;
import com.web.scu.pojo.Notice;
import com.web.scu.pojo.NoticeExample;
import com.web.scu.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService{


    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public void add(Notice notice) {
        noticeMapper.insert(notice);
    }

    @Override
    public void delete(Integer id) {
        noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Notice notice) {
        noticeMapper.updateByPrimaryKeySelective(notice);
    }

    @Override
    public Notice queryById(Integer id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Notice> queryByTitle(String title) {

        NoticeExample noticeExample = new NoticeExample();
        NoticeExample.Criteria criteria = noticeExample.createCriteria();

        criteria.andTitleLike("%" + title + "%");

        List<Notice> noticeList = noticeMapper.selectByExampleWithBLOBs(noticeExample);

        return noticeList;
    }

    @Override
    public List<Notice> queryAll() {
        return noticeMapper.selectAll();
    }
}
