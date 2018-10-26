package com.web.scu.service;

import com.web.scu.common.Result;

public interface UserService {

    Result login(String username, String password);

}
