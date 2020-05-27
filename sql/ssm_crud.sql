/*
Navicat MySQL Data Transfer

Source Server         : mysql01
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : ssm_crud

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2020-05-27 08:17:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_dept
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
  `dept_id` int(32) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------
INSERT INTO `tbl_dept` VALUES ('1', '开发');
INSERT INTO `tbl_dept` VALUES ('2', '测试');
INSERT INTO `tbl_dept` VALUES ('3', '产品经理');
INSERT INTO `tbl_dept` VALUES ('4', '部门长');
INSERT INTO `tbl_dept` VALUES ('5', '人事');

-- ----------------------------
-- Table structure for tbl_emp
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp` (
  `emp_id` int(32) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `d_id` int(32) NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_emp
-- ----------------------------
INSERT INTO `tbl_emp` VALUES ('2', 'wfei', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('3', 'qqqq', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('4', '3322', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('5', 'eeee', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('6', 'eeeeeeee', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('7', 'ffffff', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('8', 'gfdsd', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('9', 'jhgfdgfd', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('10', 'hgfdvcfd', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('11', 'kjhgfd', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('12', 'kjhgfregfd', 'M', '1204088730@qq.com', '1');
INSERT INTO `tbl_emp` VALUES ('13', '王飞', 'M', 'wangfei001@lu.com', '4');
