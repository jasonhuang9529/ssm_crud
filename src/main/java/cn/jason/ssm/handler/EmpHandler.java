package cn.jason.ssm.handler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.jason.ssm.entity.Employee;
import cn.jason.ssm.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * Employee 控制器
 * @author jason.huang
 */
@Controller
public class EmpHandler {
	
	@Autowired
	private EmployeeService empService;
	
	/**
	 * 获取 Employee 列表
	 */
	@RequestMapping("/emps")
	public String emps(@RequestParam(name="pageNum",defaultValue="1") Integer pageNum, 
				Map<String, Object> map){
		PageHelper.startPage(pageNum, 5);
		List<Employee> emps = empService.getAll();
		PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
		map.put("pageInfo", pageInfo);
		return "emps";
	}
}
