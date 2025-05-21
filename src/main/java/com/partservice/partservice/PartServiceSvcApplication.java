package com.partservice.partservice;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.partservice.partservice.mapper")
@SpringBootApplication
public class PartServiceSvcApplication {

    public static void main(String[] args) {
        SpringApplication.run(PartServiceSvcApplication.class, args);
    }

}
