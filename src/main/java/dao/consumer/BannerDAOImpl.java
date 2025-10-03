package dao.consumer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {

	// 메인페이지 배너 노출 목록
	@Override
	public List<Banner> selectBannerListForMain() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.banner.selectBannerListForMain");
		}
	}

}
