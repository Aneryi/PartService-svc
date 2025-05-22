package com.partservice.partservice.controller;

import com.partservice.partservice.common.ResponseData;
import com.partservice.partservice.entity.Train;
import com.partservice.partservice.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/test")
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    @ResponseBody
    @GetMapping("/testList")
    public ResponseData<List<Train>> test () {
        List<Train> result = testService.test();
        return ResponseData.success(result);
    }
}
