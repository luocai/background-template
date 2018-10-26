package com.web.scu.service.Impl;

import com.web.scu.common.Constant;
import com.web.scu.common.Result;
import com.web.scu.mapper.UserMapper;
import com.web.scu.pojo.User;
import com.web.scu.pojo.UserExample;
import com.web.scu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;


    @Override
    public Result login(String username, String password) {

        User user = userMapper.selectByUsername(username);

        if(user == null){
            return new Result(Constant.RESULT_CODE_SERVER_ERROR,"用户不存在");
        }
        if(!user.getPassword().equals(password)){
            return new Result(Constant.RESULT_CODE_SERVER_ERROR,"密码错误");
        }

        return new Result(Constant.RESULT_CODE_SUCCESS);
    }
}
