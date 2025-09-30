package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.ShippingDAO;
import dao.brand.ShippingDAOImpl;
import dto.brand.ShippingDetailItem;
import dto.brand.ShippingList;

public class ShippingServiceImpl implements ShippingService {

	private ShippingDAO shippingDAO;

	public ShippingServiceImpl() {
		shippingDAO = new ShippingDAOImpl();
	}

	// 배송 목록 조회
	@Override
	public Map<String, Object> shippingListByPage(Map<String, Object> params) throws Exception {
		List<ShippingList> shippingList = shippingDAO.selectShippingListForBrand(params);

		// 총 상품 개수 조회
		int totalCount = shippingDAO.selectShippingCountForBrand(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("shippingList", shippingList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 배송 상세 조회
	@Override
	public Map<String, Object> shippingDetail(Long brandId, Long orderId, String status) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		params.put("orderId", orderId);
		params.put("status", status);

		ShippingList summary = shippingDAO.selectShippinDetailForBrand(params);
		List<ShippingDetailItem> items = shippingDAO.selectShippingDetailItemsForBrand(params);

		Map<String, Object> result = new HashMap<>();

		result.put("summary", summary);
		result.put("items", items);

		return result;
	}

}
