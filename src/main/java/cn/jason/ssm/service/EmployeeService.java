package cn.jason.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.jason.ssm.entity.Employee;
import cn.jason.ssm.entity.EmployeeExample;
import cn.jason.ssm.entity.EmployeeExample.Criteria;
import cn.jason.ssm.mapper.EmployeeMapper;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;

	@Transactional(readOnly=true)
	public List<Employee> getAll() {
		List<Employee> emps = employeeMapper.selectWithDeptByExample(null);
		return emps;
	}

	public void save(Employee emp) {
		employeeMapper.insertSelective(emp);
	}

	public void batchDelByIds(List<Integer> del_ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(del_ids);
		employeeMapper.deleteByExample(example);
	}

	public void delById(int empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	@Transactional(readOnly=true)
	public Employee getEmpById(Integer id) {
		return employeeMapper.selectWithDeptByPrimaryKey(id);
	}
	
	public void updateById(Employee emp) {
		employeeMapper.updateByPrimaryKeySelective(emp);
	}
	
	
}
