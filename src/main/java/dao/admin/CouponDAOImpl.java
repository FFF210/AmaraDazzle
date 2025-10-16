package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Coupon;
import dto.MemberCoupon;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO {

	// 쿠폰 발행 수
	@Override
	public Integer pCouponCnt(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectOne("mapper.coupon.pCouponCnt", sc_DTO);
		}
	}

	// 쿠폰 발행 리스트 보기
	@Override
	public List<Coupon> pCouponAllList(Map<String, Object> listMap) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.coupon.pCouponAllList", listMap);
		}
	}

	// 검색된 발행쿠폰 리스트
	@Override
	public List<Coupon> pCouponSearchList(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.coupon.pCouponSearchList", sc_DTO);
		}
	}

	// 쿠폰 발행
	@Override
	public int insertPublCoupon(Coupon pCoupon) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.insert("mapper.coupon.insertPublCoupon", pCoupon);
			if (result > 0) {
				ss.commit();
			} else {
				ss.rollback();
			}
			return result;
		}
	}

	// 발행 쿠폰 상세보기
	@Override
	public Coupon publCouponDetail(int num) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectOne("mapper.coupon.publCouponDetail", num);
		}
	}

	// 개별지급 쿠폰 전체 수
	@Override
	public Integer iCouponCnt(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectOne("mapper.coupon.iCouponCnt", sc_DTO);
		}
	}

	// 개별지급 쿠폰 전체 목록
	@Override
	public List<MemberCoupon> iCouponAllList(Map<String, Object> listMap) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.coupon.iCouponAllList", listMap);
		}
	}

	// 개별지급 쿠폰 검색 목록
	@Override
	public List<MemberCoupon> iCouponSearchList(SearchConditionDTO sc_DTO) {
		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return ss.selectList("mapper.coupon.iCouponSearchList", sc_DTO);
		}
	}

	// 쿠폰 지급
	@Override
	public int provisionCoupon(Map<String, Object> map) {

		try (SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = ss.insert("mapper.coupon.provisionCoupon", map);

			System.out.println("DAO result : " + result);

			if (result > 0) {
				ss.commit();
			} else {
				ss.rollback();
			}
			return result;
		}
	}

}
