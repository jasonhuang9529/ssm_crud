package cn.jason.ssm.test;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * 通过Mybatis 逆向工程，生成 JavaBean、Mapper 及 xml 映射文件
 * @author jason.huang
 */
public class TestMBG {

	@Test
	public void mgb() throws Exception{
		List<String> warnings = new ArrayList<String>();
	   boolean overwrite = true;
	   File configFile = new File("generatorConfig.xml");
	   ConfigurationParser cp = new ConfigurationParser(warnings);
	   Configuration config = cp.parseConfiguration(configFile);
	   DefaultShellCallback callback = new DefaultShellCallback(overwrite);
	   MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
	   myBatisGenerator.generate(null);
	}
}
