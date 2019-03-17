package com.ssm.controller;

import com.ssm.entity.Department;
import com.ssm.mapper.DepartmentMapper;
import com.ssm.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dept")
public class DepartmentController{
    @Autowired
    private IDepartmentService departmentService;

    @RequestMapping("/getDepts")
    @ResponseBody
    public List<Department> getDeptList(){
      return  departmentService.getDeptList();
    }
}
