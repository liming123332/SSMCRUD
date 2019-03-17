package com.ssm.service.impl;

import com.ssm.entity.Department;
import com.ssm.mapper.DepartmentMapper;
import com.ssm.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentServiceImpl implements IDepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDeptList(){
      return  departmentMapper.selectByExample(null);
    }
}
