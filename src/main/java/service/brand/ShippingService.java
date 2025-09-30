package service.brand;

import java.util.Map;

public interface ShippingService {
	// 배송 목록 조회
	Map<String, Object> shippingListByPage(Map<String, Object> params) throws Exception;

	// 배송 상세 조회
	Map<String, Object> shippingDetail(Long brandId, Long orderId, String status) throws Exception;
}
