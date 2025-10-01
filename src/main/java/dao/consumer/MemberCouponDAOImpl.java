package dao.consumer;

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

	// 회원의 쿠폰 목록 조회
	@Override
	public List<Map<String, Object>> selectMemberCouponList(Long memberId) throws Exception {
	    return sqlSession.selectList("mapper.memberCoupon.selectMemberCouponList", memberId);
	}

	//사용한 쿠폰 조회 (orderDetail 용도)
	@Override
	public Map<String, Object> getCouponInfoByMemberCouponId(Long memberCouponId) throws Exception {
		 return sqlSession.selectOne("mapper.memberCoupon.getCouponInfoByMemberCouponId", memberCouponId);
	}
}
