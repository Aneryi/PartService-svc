package com.partservice.partservice.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.*;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Train {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String train_no;
    private String start_station;
    private String end_station;
    private Date depart_time;
    private Date arrive_time;
    private String seat_types;
}
