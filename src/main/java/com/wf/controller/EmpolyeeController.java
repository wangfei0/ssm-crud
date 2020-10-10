/**
 * Copyright (C), 2019, 王飞
 * FileName: EmpolyeeController
 * Author:   wf
 * Date:     19-11-20 上午10:37
 * Description: 处理员工CRUD请求
 * History:
 * <author>          <time>          <version>          <desc>
 * 作者姓名           修改时间           版本号              描述
 */
package com.wf.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wf.bean.Employee;
import com.wf.bean.Msg;
import com.wf.service.EmpolyeeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 〈一句话功能简述〉<br>
 * 〈处理员工CRUD请求〉
 *
 * @author wf
 * @create 19-11-20
 * @since 1.0.0
 */
@Controller
public class EmpolyeeController {

    @Autowired
    EmpolyeeServiceImpl empolyeeServiceImpl;

    /**
     * 删除员工,可单个1，可多个1-2-3
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if (!ids.contains("-")){
            //单个
            Integer id = Integer.parseInt(ids);
            empolyeeServiceImpl.deleteEmp(id);
        }else {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            empolyeeServiceImpl.deleteBath(del_ids);
        }
        return Msg.success();
    }

    /**
     * 员工更新方法
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
        empolyeeServiceImpl.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 按照员工id查询
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = empolyeeServiceImpl.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 从数据库校验用户名
     *
     * @param empName
     * @return true
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName) {
        //先校验用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字组合");
        }
        //数据库用户名重复校验
        boolean b = empolyeeServiceImpl.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名已存在");
        }
    }

    /**
     * 员工保存
     * 新增员工
     *
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，应该返回失败,在模态框中显示校验失败的信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误的字段名:" + error.getField());
                System.out.println("错误信息：" + error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            empolyeeServiceImpl.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 查询所有员工
     * 导入jackson包
     * 自动将返回的对象转换为字符串
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getWmpsWithJson(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber) {
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入页码以及每一页的大小
        PageHelper.startPage(pageNumber, 10);
        //后面紧跟的查询就是一个分页查询
        List<Employee> emps = empolyeeServiceImpl.getAll();
        //用PageInfo对结果进行包装,PageInfo包含了非常全面的分页属性,只需要将此对象传给页面
        //可以设置连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    //@RequestMapping("/emps")
    public String getEmpls(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber,
                           Model model) {
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入开始页码以及每一页的大小
        PageHelper.startPage(pageNumber, 10);
        //后面紧跟的查询就是一个分页查询
        List<Employee> emps = empolyeeServiceImpl.getAll();
        //用PageInfo对结果进行包装,PageInfo包含了非常全面的分页属性,只需要将此对象传给页面
        //可以设置连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        //model能够返回到页面中
        model.addAttribute("pageInfo", page);

        return "list";
    }
}
