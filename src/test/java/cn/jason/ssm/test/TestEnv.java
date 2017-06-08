package cn.jason.ssm.test;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 测试环境搭建
 * @author jason.huang
 */
public class TestEnv {

	@SuppressWarnings("resource")
	@Test
	public void testDataSource() throws SQLException{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		DataSource ds = ctx.getBean(DataSource.class);
		System.out.println(ds.getConnection());
	}
}
