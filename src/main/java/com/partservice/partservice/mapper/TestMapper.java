package com.partservice.partservice.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.partservice.partservice.entity.Train;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TestMapper extends BaseMapper<Train> {

}
