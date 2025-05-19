## 用户模块
### 用户注册/登录（JWT鉴权）
URL: /api/auth/login  
Method: POST  
Request:
```json 
{ 
    "username": "testuser",
    "password": "123456"
}
```

Response:
```json
{
  "code": 200,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 实名认证（身份证验证）

### 乘车人管理

--- 
## 车票模块
### 车次查询（支持日期、站点筛选）
URL: /api/train/search  
Method: GET  
Params:
> startStation: 北京  
endStation: 上海  
date: 2024-03-01

Response:

```json
{
  "code": 200,
  "data": [
    {
        "trainNo": "G123",
        "departTime": "08:00",
        "arriveTime": "12:30",
        "seatTypes": ["一等座", "二等座"]
    }
  ]
}
```
### 余票实时展示（Redis缓存）

### 座位选择（SVG可视化选座）

### 区间购票（基于Bitmap的并发控制）


--- 
## 订单模块
### 订单创建（Redis分布式锁）
URL: /api/order/create  
Method: POST  
Headers: Authorization: Bearer {token}  
Request:

```json
{
    "trainNo": "G123",
    "seatType": "二等座",
    "passengers": [
      {
        "name": "张三",
        "idCard": "110101199001011234"
      }
    ]
}
```
### 订单支付（对接第三方支付）

### 订单取消（超时自动取消）

### 订单查询（分页+状态过滤）


--- 

## 后台管理
### 车次管理（CRUD）

### 座位库存管理

### 订单统计报表

### 用户行为分析


--- 