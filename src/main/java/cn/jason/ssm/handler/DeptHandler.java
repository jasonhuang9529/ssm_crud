package cn.jason.ssm.handler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.jason.ssm.entity.Department;
import cn.jason.ssm.service.DepartmentService;

/**
 * Department 控制器
 * @author jason.huang
 */
@Controller
public class DeptHandler {
	
	@Autowired
	private DepartmentService deptService;
	
	/**
	 * 获取所有的 Department 信息，并以 json 格式返回
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public List<Department> getAll(){
		List<Department> depts = deptService.getAll();
		return depts;
	}
}
