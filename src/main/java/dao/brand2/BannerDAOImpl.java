package dao.brand2;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {
	
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public void insertBanner(Banner banner) throws Exception {
		sqlSession.insert("mapper.banner.insert", banner);
		sqlSession.commit();

	}
}
