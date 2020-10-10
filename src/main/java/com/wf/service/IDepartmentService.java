/**
 * Copyright (C), 2015-2020, 王飞
 * FileName: IDepartmentService
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

import com.wf.bean.Department;

import java.util.List;

/**
 * 〈一句话功能简述〉<br> 
 * 〈〉
 *
 * @author WF
 * @create 2020/10/10
 * @since 1.0.0
 */
public interface IDepartmentService {
    List<Department> getDepts();
}
