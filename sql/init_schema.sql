-- 用户表 (游客及管理员)
CREATE TABLE `sys_user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '登录名/手机号',
  `password` VARCHAR(100) NOT NULL,
  `nickname` VARCHAR(50) COMMENT '姓名',
  `id_card` VARCHAR(18) COMMENT '身份证号',
  `email` VARCHAR(50),
  `phone` VARCHAR(20),
  `role` VARCHAR(20) DEFAULT 'VISITOR' COMMENT '角色: VISITOR, ADMIN, STAFF',
  `status` TINYINT DEFAULT 1 COMMENT '1:正常, 0:冻结',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 票种策略表
CREATE TABLE `ticket_category` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL COMMENT '如: 普通票, 学生票, 老年票',
  `price` DECIMAL(10, 2) NOT NULL,
  `description` TEXT,
  `is_active` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 分时段预约配置表
CREATE TABLE `ticket_inventory` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `category_id` INT,
  `booking_date` DATE NOT NULL,
  `time_slot` VARCHAR(20) NOT NULL COMMENT '如: 08:00-12:00',
  `max_capacity` INT NOT NULL COMMENT '最大预约量',
  `current_count` INT DEFAULT 0 COMMENT '已预约人数',
  UNIQUE KEY `uk_ticket_date_slot` (`category_id`, `booking_date`, `time_slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 订单表
CREATE TABLE `ticket_order` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `order_no` VARCHAR(50) UNIQUE NOT NULL,
  `user_id` BIGINT NOT NULL,
  `ticket_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `time_slot` VARCHAR(20),
  `total_amount` DECIMAL(10, 2),
  `status` TINYINT DEFAULT 0 COMMENT '0:待支付, 1:待入园, 2:已入园, 3:已过期, 4:已退款',
  `qr_code` VARCHAR(255) COMMENT '二维码路径或内容',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 园区公告表
CREATE TABLE `sys_announcement` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT,
  `admin_id` BIGINT,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
