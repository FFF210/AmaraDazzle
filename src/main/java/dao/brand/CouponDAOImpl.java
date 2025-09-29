package dao.brand;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.brand.OrdersCoupon;
import util.MybatisSqlSessionFactory;

public class CouponDAOImpl implements CouponDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 주문 사용 쿠폰 조회
	@Override
	public List<OrdersCoupon> selectOrdersCouponForBrand(Long orderId) {
		return sqlSession.selectList("mapper.coupon.selectOrdersCouponForBrand", orderId);
	}

}
