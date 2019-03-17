package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.entity.Employee;
import com.ssm.service.IEmployeeService;
import com.ssm.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private IEmployeeService employeeService;

    /**
     * 获取员工分页显示
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Message getEmps(@RequestParam Integer pn){
        //引入分页插件pageHepler 传入当前页，页码显示多少条
        PageHelper.startPage(pn,5);
        //排序规则
        PageHelper.orderBy("emp_id asc");
        List<Employee> emps=employeeService.getAll();
        //封装了详情分页信息，连续传入5页
        PageInfo pageInfo=new PageInfo(emps,5);
        Message Msg=new Message().success().addPage(pageInfo);
        return  Msg;
    }

    /**
     * 员工保存
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Message saveEmp(@RequestBody Employee employee){
        employeeService.saveEmp(employee);
        return Message.success();
    }

}
