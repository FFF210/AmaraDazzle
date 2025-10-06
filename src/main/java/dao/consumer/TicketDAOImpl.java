package dao.consumer;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Orders;
import dto.Ticket;
import util.MybatisSqlSessionFactory;

public class TicketDAOImpl implements TicketDAO {

	// 문의 생성
	@Override
	public void insertTicket(Ticket ticket) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.ticket.insertTicket", ticket);
			sqlSession.commit();
		}
	}

	// 문의 목록 조회
	@Override
	public List<Ticket> selectTicketsBySenderId(Long senderId, String senderType, Timestamp startDate,
			Timestamp endDate) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> params = new HashMap<>();
			params.put("senderId", senderId);
			params.put("senderType", senderType);
			params.put("startDate", startDate);
			params.put("endDate", endDate);

			return sqlSession.selectList("mapper.ticket.selectTicketsBySenderId", params);
		}
	}

	// 문의 상세 조회
	@Override
	public Ticket selectTicketById(Long ticketId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.ticket.selectTicketById", ticketId);
		}
	}

	//문의 수정 (사용 x)
	@Override
	public void updateTicket(Ticket ticket) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.ticket.updateTicket", ticket);
			sqlSession.commit();
		}
	}

	//문의 삭제(사용 x)
	@Override
	public void deleteTicket(Long ticketId, Long senderId, String senderType) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("ticketId", ticketId);
            params.put("senderId", senderId);
            params.put("senderType", senderType);
            
            sqlSession.delete("mapper.ticket.deleteTicket", params);
            sqlSession.commit();
        }
	}

	//주문번호로 주문 ID 조회
	@Override
	public Long selectOrderIdByOrderCode(String orderCode) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.ticket.selectOrderIdByOrderCode", orderCode);
        } // 자동 close()
	}

	//주문번호로 주문 정보 전체 조회 (검증용)
	@Override
	public Orders selectOrderByOrderCode(String orderCode) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.ticket.selectOrderByOrderCode", orderCode);
        }
	}

}
