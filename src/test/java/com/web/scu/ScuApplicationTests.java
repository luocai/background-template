package com.web.scu;

import com.web.scu.mapper.NoticeMapper;
import com.web.scu.pojo.Notice;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;
import java.util.Random;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ScuApplicationTests {

	@Autowired
	private NoticeMapper noticeMapper;



	@Test
	public void contextLoads() {

		for(int i = 0; i < 30 ; i++){

			Notice notice = new Notice();
			notice.setCreatetime(new Date());
			notice.setClick(0);
			notice.setContent("d你的高科技刚接个空格分级分类费劲儿");
			notice.setTitle("测试室" + i);

			noticeMapper.insert(notice);
		}
	}

}
