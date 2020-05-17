/**
 * Copyright (C), 2019, 王飞
 * FileName: DaoTest
 * Author:   wf
 * Date:     19-11-19 下午9:00
 * Description: dao层的方法测试
 * History:
 * <author>          <time>          <version>          <desc>
 * 作者姓名           修改时间           版本号              描述
 */
package com.wf.test;

import com.wf.bean.Employee;
import com.wf.dao.DepartmentMapper;
import com.wf.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 〈一句话功能简述〉<br> 
 * 〈dao层的方法测试〉
 *
 * @author wf
 * @create 19-11-19
 * @since 1.0.0
 */

/**
 * Spring的项目可以使用Spring的单元测试，可以自动注入需要的组件
 * 1. 导入SpringTest模块，pom.xml中引入依赖
 * 2. 使用@ContextConfiguration(locations = {""})指定spring配置文件的位置
 * 3. 直接@Autowired要用的组件即可
 */

/**
 * Spring单元测试,可以自动导入包
 */
@RunWith(SpringJUnit4ClassRunner.class)
/**
 * 指定Spring的配置文件
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class DaoTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testDaoCRUD(){
//        ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml");
//        DepartmentMapper departmentMapper = ac.getBean(DepartmentMapper.class);
          //插入员工信息
//        departmentMapper.insertSelective(new Department(null,"开发"));
//        departmentMapper.insertSelective(new Department(null,"测试"));
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        //插入员工信息
        for (int i=0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        }
        System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1));
    }
}
