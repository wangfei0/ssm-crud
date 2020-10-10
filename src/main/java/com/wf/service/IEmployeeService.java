/**
 * Copyright (C), 2015-2020, 王飞
 * FileName: IEmployeeService
 * Author:   WF
 * Date:     2020/10/10 13:28
 * Description:
 * History:
 * <author>          <time>          <version>          <desc>
 * 作者姓名           修改时间           版本号              描述
 */
package com.wf.service;/**
 * 〈一句话功能简述〉<br> 
 *
 * @author WF
 * @create 2020/10/10
 * @since 1.0.0
 */

import com.wf.bean.Employee;

import java.util.List;

/**
 * 〈一句话功能简述〉<br> 
 * 〈〉
 *
 * @author WF
 * @create 2020/10/10
 * @since 1.0.0
 */
public interface IEmployeeService {
    List<Employee> getAll();
    void saveEmp(Employee employee);
    boolean checkUser(String empName);
    Employee getEmp(Integer id);
    void updateEmp(Employee employee);
    void deleteEmp(Integer id);
    void deleteBath(List<Integer> ids);
}
