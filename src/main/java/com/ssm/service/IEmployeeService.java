package com.ssm.service;

import com.ssm.entity.Employee;

import java.util.List;

public interface IEmployeeService {
    List<Employee> getAll();

    void saveEmp(Employee employee);

    Employee getEmpById(int id);
}
