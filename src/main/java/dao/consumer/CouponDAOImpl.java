package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.consumer.CouponList;
import util.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO {

	// ======================= [소비자] 다운 가능한 쿠폰 목록 조회 =======================
	@Override
	public List<CouponList> selectAvailableCoupons(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.coupon.selectAvailableCoupons", params);
		}
	}

	// ======================= [소비자] 쿠폰 다운로드 =======================
	@Override
	public void insertMemberCoupon(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.coupon.insertMemberCoupon", params);
			sqlSession.commit();
		}
	}

	// ======================= [소비자] 쿠폰 제한 수량 감소 =======================
	@Override
	public void decreaseCouponLimit(Long couponId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.coupon.decreaseCouponLimit", couponId);
			sqlSession.commit();
		}

	}

}
