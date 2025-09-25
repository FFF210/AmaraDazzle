package util;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisSqlSessionFactory {
	
	private static SqlSessionFactory sf;
	
	
	static {
		try {
			String resource = "resource/mybatis_config.xml";
			InputStream is = Resources.getResourceAsStream(resource);
			
			//SqlSessionFactoryBuilder 생성 
			SqlSessionFactoryBuilder sb = new SqlSessionFactoryBuilder();
			
			//SqlSessionFactory 생성 
			sf = sb.build(is);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sf;
	}

}
