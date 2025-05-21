drop table `carriage`;
drop table `order`;
drop table `seat`;
drop table `seat_layout`;
drop table train;
drop table train_calendar;
drop table `user`;
-- 用户表
CREATE TABLE `user` (
                        `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
                        `username` VARCHAR(32) NOT NULL UNIQUE COMMENT '用户名',
                        `password` VARCHAR(128) NOT NULL COMMENT '加密密码',
                        `phone` VARCHAR(20) NOT NULL COMMENT '手机号',
                        `id_card` VARCHAR(20) NOT NULL COMMENT '身份证号',
                        `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 车次表
CREATE TABLE `train` (
                         `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
                         `train_no` VARCHAR(20) NOT NULL UNIQUE COMMENT '车次编号',
                         `start_station` VARCHAR(50) NOT NULL COMMENT '始发站',
                         `end_station` VARCHAR(50) NOT NULL COMMENT '终点站',
                         `depart_time` DATETIME NOT NULL COMMENT '发车时间',
                         `arrive_time` DATETIME NOT NULL COMMENT '到达时间',
                         `seat_types` VARCHAR(20) COMMENT '座位类型'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 座位表
CREATE TABLE `seat` (
                        `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
                        `train_id` BIGINT NOT NULL COMMENT '车次ID',
                        `seat_type` VARCHAR(10) NOT NULL COMMENT '座位类型',
                        `total_seats` INT NOT NULL COMMENT '总座位数'
--                         ,FOREIGN KEY (train_id) REFERENCES train(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 订单表
CREATE TABLE `order` (
                         `id` VARCHAR(32) PRIMARY KEY COMMENT '订单号',
                         `user_id` BIGINT NOT NULL COMMENT '用户ID',
                         `train_id` BIGINT NOT NULL COMMENT '车次ID',
                         `seat_num` VARCHAR(10) NOT NULL COMMENT '座位号',
                         `status` TINYINT DEFAULT 0 COMMENT '0-未支付 1-已支付 2-已取消',
                         `amount` DECIMAL(10,2) NOT NULL COMMENT '金额',
                         `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
--                          ,FOREIGN KEY (user_id) REFERENCES user(id),
--                          FOREIGN KEY (train_id) REFERENCES train(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- 车厢表
CREATE TABLE `carriage` (
                            `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
                            `train_id` BIGINT NOT NULL,
                            `carriage_number` VARCHAR(10) NOT NULL COMMENT '车厢号',
                            `seat_type` VARCHAR(10) NOT NULL COMMENT '座位类型',
                            `total_rows` INT NOT NULL COMMENT '总排数',
                            `seats_per_row` INT NOT NULL COMMENT '每排座位数'
--                             ,FOREIGN KEY (train_id) REFERENCES train(id)
);



-- 座位布局表
CREATE TABLE `seat_layout` (
                               `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
                               `carriage_id` BIGINT NOT NULL,
                               `seat_index` INT NOT NULL COMMENT '全局座位索引',
                               `row_number` INT NOT NULL COMMENT '排号',
                               `seat_position` VARCHAR(2) NOT NULL COMMENT '座位位置（A/B/C/D/F）'
--                                ,FOREIGN KEY (carriage_id) REFERENCES carriage(id)
);



-- 车次日历表
CREATE TABLE `train_calendar` (
                                  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
                                  `train_id` BIGINT NOT NULL COMMENT '关联车次ID',
                                  `run_date` DATE NOT NULL COMMENT '运行日期',
                                  `status` TINYINT DEFAULT 1 COMMENT '状态（1-可售 0-停运）',
--                                   ,FOREIGN KEY (train_id) REFERENCES train(id),
                                  UNIQUE KEY `uniq_train_date` (train_id, run_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `order`
    ADD COLUMN `train_calendar_id` BIGINT NOT NULL COMMENT '关联车次日历ID',
  MODIFY COLUMN `seat_num` VARCHAR(20) NOT NULL COMMENT '可读座位号（如05车12F）',
  ADD FOREIGN KEY (train_calendar_id) REFERENCES train_calendar(id);

-- 示例：车次ID=1的05车厢，二等座，共20排，每排5座
INSERT INTO carriage (train_id, carriage_number, seat_type, total_rows, seats_per_row)
VALUES (1, '05', '二等座', 20, 5);
-- 插入示例数据
INSERT INTO `seat` (train_id, seat_type, total_seats)
VALUES (1, '二等座', 500);
-- 插入示例数据
INSERT INTO `order` (id, user_id, train_id, seat_num, amount)
VALUES ('202403011234567890', 1, 1, '05车12F', 553.00);

INSERT INTO `order` (id, user_id, train_calendar_id, seat_num, amount)
VALUES ('202403011234567890', 1, 1, '05车12F', 553.00);


-- 插入示例数据（车次G1234的05车厢，二等座，共20排，每排5个座位）
INSERT INTO carriage (train_id, carriage_number, seat_type, total_rows, seats_per_row)
VALUES (1, '05', '二等座', 20, 5);

-- 座位布局表（记录每个座位的全局索引和可读位置）
INSERT INTO seat_layout (`carriage_id`, `seat_index`, `row_number`, `seat_position`)
VALUES
    (1, 0, 1, 'A'),  -- 全局索引0 → 05车1A
    (1, 1, 1, 'B'),  -- 全局索引1 → 05车1B
    (1, 99, 20, 'F'); -- 全局索引99 → 05车20F

-- 生成05车厢的座位布局（示例）
-- 假设座位排列为：A(靠窗)、B(过道)、C(过道)、D(过道)、F(靠窗)
INSERT INTO seat_layout (`carriage_id`, `seat_index`, `row_number`, `seat_position`)
VALUES
    (1, 0, 1, 'A'),
    (1, 1, 1, 'B'),
    (1, 2, 1, 'C'),
    (1, 3, 1, 'D'),
    (1, 4, 1, 'F'),
    (1, 95, 20, 'F');

-- 插入示例数据
INSERT INTO `user` (username, password, phone, id_card)
VALUES ('zhangsan', '$2a$10$AbCdEfGhIjKlMnOpQrStUv', '13800138000', '110101199001011234');

-- 插入示例数据
INSERT INTO `train` (train_no, start_station, end_station, depart_time, arrive_time, seat_types)
VALUES ('G1234', '北京南', '上海虹桥', '2024-03-01 08:00:00', '2024-03-01 12:30:00', '一等座,二等座');

-- 假设车次ID=1的G1234在2024-03-01可售
INSERT INTO train_calendar (train_id, run_date, status)
VALUES (1, '2024-03-01', 1);