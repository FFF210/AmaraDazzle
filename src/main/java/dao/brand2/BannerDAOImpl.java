package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	/*
	 * @Override public void insertBanner(Banner banner) throws Exception {
	 * sqlSession.insert("mapper.banner.insert", banner); sqlSession.commit();
	 * 
	 * }
	 */

	// 배너 신청 목록 조회
	@Override
	public List<Banner> selectAdbannerList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.banner.selectAdbannerList", params);
	}

	// 신청 개수 조회
	@Override
	public Integer selectAdbannerCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.banner.selectAdbannerCount", params);
	}
}
