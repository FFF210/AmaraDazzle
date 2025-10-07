package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.ReturnDAO;
import dao.consumer.ReturnDAOImpl;
import dto.Returns;

public class ReturnServiceImpl implements ReturnService {
	
	private ReturnDAO returnDAO = new ReturnDAOImpl();
	
	// ================[소비자] 반품 신청 ===================
	@Override
	public void applyReturns(Returns returns) throws Exception {
		 // 1. 중복 신청 체크
        if (!canApplyReturns(returns.getOrderItemId())) {
            throw new Exception("이미 반품 신청된 상품입니다.");
        }
        
        // 2. 반품 신청 등록
        returnDAO.insertReturns(returns);
        
        // 3. 주문 상품 상태를 RETURN_REQUESTED로 변경
        Map<String, Object> params = new HashMap<>();
        params.put("orderItemId", returns.getOrderItemId());
        params.put("status", "RETURN_REQUESTED");
        returnDAO.updateOrderItemStatus(params);
		
	}

	// ================[소비자] 반품 목록 조회 ===================
	@Override
	public List<Map<String, Object>> getReturnsListByMemberId(Long memberId) throws Exception {
		 return returnDAO.selectReturnsListByMemberId(memberId);
	}

	// ================[소비자] 반품 상세 조회 ===================
	@Override
	public Returns getReturnsById(Long returnsId) throws Exception {
		 Returns returns = returnDAO.selectReturnsById(returnsId);
	        if (returns == null) {
	            throw new Exception("반품 정보를 찾을 수 없습니다.");
	        }
	        return returns;
	}

	// ================[소비자] 반품 신청 가능 여부 확인 (중복 체크) ===================
	@Override
	public boolean canApplyReturns(Long orderItemId) throws Exception {
		Returns existingReturns = returnDAO.selectReturnsByOrderItemId(orderItemId);
        // 기존 반품 신청이 없으면 true (신청 가능)
        return existingReturns == null;
	}

}
