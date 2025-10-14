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

	

	// 정산 처리 (정산 완료 상태로 업데이트)
	public int settleAllCompleted(Map<String, String> map) {
		SqlSession ss = factory.openSession(false); // 수동 커밋
		int result = 0;
		try {
			result = ss.update("mapper.settlement.settleAllCompleted",map);

			if (result > 0) {
				ss.commit();

			} else {
				ss.rollback();
			}

		} catch (Exception e) {
			ss.rollback(); // SQL 실행 중 예외 발생 시 롤백
			System.err.println("[정산 배치 오류] updateSettleAll 실패: " + e.getMessage());
			throw new RuntimeException("정산 처리 중 오류 발생", e);

		} finally {
			ss.close(); // 세션 닫기
		}

		return result;
	}

	// 자동정산 (로그 출력용)
	public int autoSettle(Map<String, String> map) {
		int result = settleAllCompleted(map);
		System.out.println("[정산 배치] 실행됨 - 처리된 건수: " + result);
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
