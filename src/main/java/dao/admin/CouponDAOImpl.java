package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Coupon;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO{
	SqlSession ss = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	//쿠폰 발행 수 
	@Override
	public Integer pCouponCnt(SearchConditionDTO sc_DTO) {
		return ss.selectOne("mapper.coupon.pCouponCnt", sc_DTO);
	}

	//쿠폰 발행 리스트 보기 
	@Override
	public List<Coupon> pCouponAllList(Map<String, Object> listMap) {
		return ss.selectList("mapper.coupon.pCouponAllList",listMap);
	}

	//검색된 발행쿠폰 리스트
	@Override
	public List<Coupon> pCouponSearchList(SearchConditionDTO sc_DTO ) {
		return ss.selectList("mapper.coupon.pCouponSearchList",sc_DTO);
	}
	

}
