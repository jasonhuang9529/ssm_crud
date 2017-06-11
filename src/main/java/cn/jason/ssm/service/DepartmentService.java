package cn.jason.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.jason.ssm.entity.Department;
import cn.jason.ssm.mapper.DepartmentMapper;
@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper deptMapper;
	
	public List<Department> getAll() {
		return deptMapper.selectByExample(null);
	}

}
