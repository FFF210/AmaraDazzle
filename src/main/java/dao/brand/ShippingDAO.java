package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.ShippingDetailItem;
import dto.brand.ShippingList;

public interface ShippingDAO {
	// 배송 목록 조회
	List<ShippingList> selectShippingListForBrand(Map<String, Object> params) throws Exception;

	// 배송 목록 개수
	Integer selectShippingCountForBrand(Map<String, Object> params) throws Exception;

	// 배송 단일 조회
	ShippingList selectShippinDetailForBrand(Map<String, Object> params) throws Exception;

	// 배송 상품 상세 조회
	List<ShippingDetailItem> selectShippingDetailItemsForBrand(Map<String, Object> params) throws Exception;

}
