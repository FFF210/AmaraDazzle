package dao.brand;

import java.util.List;

import dto.brand.OrdersCoupon;

public interface CouponDAO {
	// 주문 사용 쿠폰 조회
	List<OrdersCoupon> selectOrdersCouponForBrand(Long orderId);
}
