package com.web.scu.mapper;

import com.web.scu.pojo.IndexImg;
import com.web.scu.pojo.IndexImgExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IndexImgMapper {
    long countByExample(IndexImgExample example);

    int deleteByExample(IndexImgExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(IndexImg record);

    int insertSelective(IndexImg record);

    List<IndexImg> selectByExample(IndexImgExample example);

    IndexImg selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") IndexImg record, @Param("example") IndexImgExample example);

    int updateByExample(@Param("record") IndexImg record, @Param("example") IndexImgExample example);

    int updateByPrimaryKeySelective(IndexImg record);

    int updateByPrimaryKey(IndexImg record);
}