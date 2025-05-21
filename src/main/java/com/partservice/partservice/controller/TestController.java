package com.partservice.partservice.controller;

import com.partservice.partservice.common.ResponseData;
import com.partservice.partservice.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    public ResponseData<String> test () {
        String result = testService.test();
        return ResponseData.success("success");
    }
}
