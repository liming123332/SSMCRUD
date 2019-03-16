package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.entity.Employee;
import com.ssm.service.IEmployeeService;
import com.ssm.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private IEmployeeService employeeService;
    @RequestMapping("/emps")
    @ResponseBody
    public Message getEmps(@RequestParam Integer pn){
        //引入分页插件pageHepler 传入当前页，页码显示多少条
        PageHelper.startPage(pn,5);
        List<Employee> emps=employeeService.getAll();
        //封装了详情分页信息，连续传入5页
        PageInfo pageInfo=new PageInfo(emps,5);
        Message Msg=new Message().success().addPage(pageInfo);
        return  Msg;
    }

}
