package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class MemberCouponDAOImpl implements MemberCouponDAO {
	// 회원의 사용 가능한 쿠폰 개수 조회
	@Override
	public int getAvailableCouponCount(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Integer count = sqlSession.selectOne("mapper.memberCoupon.getAvailableCouponCount", memberId);
			return count != null ? count : 0;
		}
	}

	// 쿠폰 목록 개수 조회 (페이지네이션용)
	@Override
	public int countMemberCouponList(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Integer count = sqlSession.selectOne("mapper.memberCoupon.countMemberCouponList", memberId);
			return count != null ? count : 0;
		}
	}

	// 회원의 쿠폰 목록 조회
	@Override
	public List<Map<String, Object>> selectMemberCouponList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.memberCoupon.selectMemberCouponList", params);
		}
	}

	// 사용한 쿠폰 조회 (orderDetail 용도)
	@Override
	public Map<String, Object> getCouponInfoByMemberCouponId(Long memberCouponId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.memberCoupon.getCouponInfoByMemberCouponId", memberCouponId);
		}
	}

	// 쿠폰 사용 가능 여부 체크 (조건 포함)
	@Override
	public Map<String, Object> checkCouponAvailable(Long memberId, Long memberCouponId) throws Exception {

		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberCouponId", memberCouponId);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.memberCoupon.checkCouponAvailable", params);
		}
	}

	// 쿠폰 사용 처리
	@Override
	public boolean useCoupon(Long memberId, Long memberCouponId, Long orderId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberCouponId", memberCouponId);
		params.put("orderId", orderId);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.update("mapper.memberCoupon.useCoupon", params);
			sqlSession.commit();

			return result > 0; // true: 성공, false: 실패
		}
	}

	// 회원가입 축하 쿠폰 ID 조회
	@Override
	public Long getWelcomeCouponId() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.memberCoupon.getWelcomeCouponId");
		}
	}

	// 축하 쿠폰 발급
	@Override
	public void issueCoupon(Long memberId, Long couponId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("couponId", couponId);

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.memberCoupon.issueCoupon", params);
			sqlSession.commit();
		}
	}
}
