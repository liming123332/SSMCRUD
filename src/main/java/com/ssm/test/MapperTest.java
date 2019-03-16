package com.ssm.test;

import com.ssm.entity.Department;
import com.ssm.entity.Employee;
import com.ssm.mapper.DepartmentMapper;
import com.ssm.mapper.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;
    @Test
    public void testCrud(){
        //System.out.println(departmentMapper);
        //插入几个部门
        // departmentMapper.insertSelective(new Department(null,"开发部"));
        // departmentMapper.insertSelective(new Department(null,"测试部"));
        //employeeMapper.insertSelective(new Employee(null,"aa","M","aa@qq.com",1));
        //employeeMapper.insertSelective(new Employee(null,"bb","F","bb@qq.com",2));
//        EmployeeMapper batchmapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=0;i<1000;i++){
//            String empName= UUID.randomUUID().toString().substring(0,5)+i;
//            batchmapper.insertSelective(new Employee(null,empName,"M",empName+"@qq.com",1));
//        }
            Employee employee = employeeMapper.selectByPrimaryKeyWithDept(15);
            System.out.println(employee.getDepartment().getDeptName());
            System.out.println(employee.getDepartment().getDeptId());
    }

}
