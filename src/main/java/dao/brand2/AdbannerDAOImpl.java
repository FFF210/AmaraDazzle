package dao.brand2;

import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;
import dto.Banner;

public class AdbannerDAOImpl implements AdbannerDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public void insertEmployee(Banner bn) throws Exception {
		sqlSession.insert("mapper.banner.insert", bn);
		sqlSession.commit();

	}
	
}
