package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Settlement;
import dto.admin.SearchConditionDTO;
import util.MybatisSqlSessionFactory;

public class SettlementDAOImpl implements SettlementDAO {
	private SqlSessionFactory factory = MybatisSqlSessionFactory.getSqlSessionFactory();
	
	//매달 1일에 전월 정산자료 인서트 
	@Override
	public int monthlyInsertSettle(Map<String, String> map) {
		SqlSession ss = factory.openSession();
		try {
			return ss.insert("mapper.settlement.monthlyInsertSettle", map);
			
		} finally {
			ss.close();
		}
	}
	

	// 환불/교환 반영 처리 (세부 계산만 수행) - 단일세션으로 처리 
	public int settleAdjustment(SqlSession ss, Map<String, String> map) {
	    int r1 = ss.update("mapper.settlement.updateRefundAdjustment", map);
	    int r2 = ss.update("mapper.settlement.updatePureAdjustment", map);
	    int r3 = ss.update("mapper.settlement.updateFeeAdjustment", map);
	    
	    System.out.printf("[정산 반영] refund=%d, pure=%d, fee=%d%n", r1, r2, r3);
	    
	    return r1 + r2 + r3;
	}
	// 전체 정산 완료 처리
	public int settleAllComplete(Map<String, String> map) {
	    SqlSession ss = factory.openSession(false); // 수동 커밋
	    int totalUpdated = 0;
	    int statusUpdate = 0;

	    try {
	        
	    	 totalUpdated = settleAdjustment(ss, map);
	         statusUpdate = ss.update("mapper.settlement.settleCompleted", map);
	         
	         ss.commit();
	         System.out.printf("[🔥정산 완료🔥] 데이터 반영 %d건, 상태 갱신 %d건%n", totalUpdated, statusUpdate);

	    } catch (Exception e) {
	    	 ss.rollback();
	         System.err.println("[❌정산 오류❌] rollback됨: " + e.getMessage());
	         throw new RuntimeException("정산 처리 실패", e);
	         
	    } finally {
	        ss.close();
	    }

	    return totalUpdated + statusUpdate;
	}

	// 자동정산 (로그 출력용)
	public int autoSettle(Map<String, String> map) {
	    int result = settleAllComplete(map);
	    System.out.println("[🔥🔥🔥정산 배치] 실행됨 - 처리된 총 건수: " + result);
	    return result;
	}

	// 미정산 판매자 리스트 조회
	public List<Settlement> getPendingSettlements() {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectList("mapper.settlement.selectWaitingSettle");
			
		} finally {
			ss.close();
		}
	}
	
	//정산처리할 건수 
	@Override
	public Integer settlementCnt(SearchConditionDTO sc_DTO) {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectOne("mapper.settlement.settlementCnt", sc_DTO);
			
		} finally {
			ss.close();
		}
	}

	//정산 리스트
	@Override
	public List<Settlement> settlementAllList(Map<String, Object> listMap) {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectList("mapper.settlement.settlementAllList", listMap);
			
		} finally {
			ss.close();
		}
	}

	//정산 리스트 (검색) 
	@Override
	public List<Settlement> settlementSearchList(SearchConditionDTO sc_DTO) {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectList("mapper.settlement.settlementSearchList", sc_DTO);
			
		} finally {
			ss.close();
		}
	}



}
