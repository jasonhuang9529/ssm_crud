package cn.jason.ssm.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Employee 控制器
 * @author jason.huang
 */
@Controller
public class EmpHandler {
	
	@RequestMapping("/emps")
	public String emps(){
		return "emps";
	}
}
