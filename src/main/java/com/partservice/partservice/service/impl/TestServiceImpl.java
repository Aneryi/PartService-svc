package com.partservice.partservice.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.partservice.partservice.entity.Train;
import com.partservice.partservice.mapper.TestMapper;
import com.partservice.partservice.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TestServiceImpl implements TestService {

    private final TestMapper testMapper;

    @Autowired
    public TestServiceImpl(TestMapper testMapper) {
        this.testMapper = testMapper;
    }

    @Override
    public String test() {
        testMapper.insert(new Train(null, "G2186", "大丰", "上海", new Date(), new Date(), "二等座"));
        List<Train> trainList = testMapper.selectList(Wrappers.query());
        System.out.println("--------------------------------------------");
        for (Train train : trainList) {
            System.out.println(train);
        }
        System.out.println(trainList);
        return "";
    }
}
