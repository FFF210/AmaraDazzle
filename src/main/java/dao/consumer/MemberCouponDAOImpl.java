package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class MemberCouponDAOImpl implements MemberCouponDAO {

	private SqlSession sqlSession;

	public MemberCouponDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// 회원의 사용 가능한 쿠폰 개수 조회
	@Override
	public int getAvailableCouponCount(Long memberId) throws Exception {
		Integer count = sqlSession.selectOne("mapper.memberCoupon.getAvailableCouponCount", memberId);
		return count != null ? count : 0;
	}

	// 쿠폰 목록 개수 조회 (페이지네이션용)
	@Override
	public int countMemberCouponList(Long memberId) throws Exception {
		Integer count = sqlSession.selectOne("mapper.memberCoupon.countMemberCouponList", memberId);
		return count != null ? count : 0;
	}

	// 회원의 쿠폰 목록 조회
	@Override
	public List<Map<String, Object>> selectMemberCouponList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.memberCoupon.selectMemberCouponList", params);
	}

	// 사용한 쿠폰 조회 (orderDetail 용도)
	@Override
	public Map<String, Object> getCouponInfoByMemberCouponId(Long memberCouponId) throws Exception {
		return sqlSession.selectOne("mapper.memberCoupon.getCouponInfoByMemberCouponId", memberCouponId);
	}

	// 회원가입 축하 쿠폰 ID 조회
	@Override
	public Long getWelcomeCouponId() throws Exception {
		return sqlSession.selectOne("mapper.memberCoupon.getWelcomeCouponId");
	}

	// 축하 쿠폰 발급
	@Override
	public void issueCoupon(Long memberId, Long couponId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("couponId", couponId);
		sqlSession.insert("mapper.memberCoupon.issueCoupon", params);
		sqlSession.commit();
	}
}
