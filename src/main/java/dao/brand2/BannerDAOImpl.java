package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Banner;
import util.MybatisSqlSessionFactory;

public class BannerDAOImpl implements BannerDAO {

	// 배너 신청
	@Override
	public int insertBannerForm(Banner banner) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.insert("mapper.banner.insertBannerForm", banner);
			sqlSession.commit();
			return result;
		}
	}

	// 배너 신청 목록 조회
	@Override
	public List<Banner> selectAdbannerList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.banner.selectAdbannerList", params);
		}
	}

	// 신청 개수 조회
	@Override
	public Integer selectAdbannerCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.banner.selectAdbannerCount", params);
		}
	}

	// 배너 상세보기 버튼
	@Override
	public Banner selectBannerById(long bannerId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.banner.selectBannerById", bannerId);
		}
	}

	// 배너 (결제or취소) 상태 변경
	@Override
	public int updateBannerStatus(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.update("mapper.banner.updateBannerStatus", params);
			sqlSession.commit();
			return result;
		}
	}

	// 디버깅
//	@Override
//	public boolean existsByBannerId(Long bannerId) {
//	    Integer count = sqlSession.selectOne("mapper.adminPayment.existsByBannerId", bannerId);
//	    System.out.println("[DEBUG] existsByBannerId: bannerId=" + bannerId + ", count=" + count);
//	    return count != null && count > 0;
//	}
}
