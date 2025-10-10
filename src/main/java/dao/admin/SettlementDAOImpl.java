package dao.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Settlement;
import util.MybatisSqlSessionFactory;

public class SettlementDAOImpl implements SettlementDAO {
	private SqlSessionFactory factory = MybatisSqlSessionFactory.getSqlSessionFactory();

	// 미정산 판매자 리스트 조회
	public List<Settlement> getPendingSettlements() {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectList("mapper.settlement.selectPending");
			
		} finally {
			ss.close();
		}
	}

	// 정산 처리 (정산 완료 상태로 업데이트)
	public int settleAll() {
		SqlSession ss = factory.openSession(false); // 수동 커밋
		int result = 0;
		try {
			result = ss.update("mapper.settlement.updateSettleAll");

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
	public int autoSettle() {
		int result = settleAll();
		System.out.println("[정산 배치] 실행됨 - 처리된 건수: " + result);
		return result;
	}

}
