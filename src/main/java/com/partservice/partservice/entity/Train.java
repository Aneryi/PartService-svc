package com.partservice.partservice.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("train")
public class Train {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String trainNo;
    private String startStation;
    private String endStation;
    private Date departTime;
    private Date arriveTime;
    private String seatTypes;
}
