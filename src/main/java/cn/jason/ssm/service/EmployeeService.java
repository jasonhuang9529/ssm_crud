package cn.jason.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.jason.ssm.entity.Employee;
import cn.jason.ssm.mapper.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;

	@Transactional(readOnly=true)
	public List<Employee> getAll() {
		List<Employee> emps = employeeMapper.selectWithDeptByExample(null);
		return emps;
	}
	
	
}
