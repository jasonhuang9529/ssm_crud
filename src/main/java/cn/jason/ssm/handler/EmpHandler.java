package cn.jason.ssm.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	/**
	 * 保存 Employee 信息
	 * @param emp
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	public String emp(Employee emp){
		empService.save(emp);
		return "redirect:/emps";
	}
	
	/**
	 * 根据 id 删除 Employee （一个或多个，id 使用"-"拼接） 
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}", method=RequestMethod.DELETE)
	public String emp(@PathVariable("ids") String ids){
		if(ids.contains("-")){
			//批量删除
			String[] idsStr = ids.split("-");
			List<Integer> del_ids = new ArrayList<>();
			for (String id : idsStr) {
				del_ids.add(Integer.parseInt(id));
			}
			empService.batchDelByIds(del_ids);
		}else{
			//单个删除
			empService.delById(Integer.parseInt(ids));
		}
		return "redirect:/emps";
	}
}
