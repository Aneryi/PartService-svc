package com.partservice.partservice;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.partservice.partservice.entity.Train;
import com.partservice.partservice.mapper.TestMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@MapperScan("com.partservice.partservice.mapper")
@SpringBootTest
@Slf4j
@RunWith(SpringRunner.class)
class PartServiceSvcApplicationTests {

    @Autowired
    TestMapper testMapper;

    @Test
    void contextLoads() {
    }

    @Test
    @Transactional
    void test01() {
        testMapper.insert(new Train(null, "G2186", "大丰", "上海", new Date(), new Date(), "二等座"));
        List<Train> trainList = testMapper.selectList(Wrappers.query());
        System.out.println("--------------------------------------------");
        for (Train train : trainList) {
            System.out.println(train);
        }
        System.out.println(trainList);
    }

}
