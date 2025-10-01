package dao.brand;

import java.util.List;
import java.util.Map;

import dto.Settlement;

public interface SettlementDAO {
	// 정산 목록 조회
	List<Settlement> selectSettlementListForBrand(Map<String, Object> params) throws Exception;

	// 정산 목록 개수 조회
	Integer selectSettlementCountForBrand(Long brandId) throws Exception;

}
