package dao.consumer;

import java.sql.Timestamp;
import java.util.List;


import dto.Ticket;
import dto.Orders;

public interface TicketDAO {
	/**
     * 문의 등록
     * @param ticket 문의 정보
     */
    void insertTicket(Ticket ticket);
    
    /**
     * 내 문의 목록 조회 (기간 필터링 가능)
     * @param senderId 작성자 ID, senderType 작성자 타입 (CONSUMER, BRAND_ADMIN)
     * @param startDate 시작일 (null 가능), endDate 종료일 (null 가능)
     * @return 문의 목록
     */
    List<Ticket> selectTicketsBySenderId(Long senderId, String senderType, 
                                         Timestamp startDate, Timestamp endDate);
    
    /**
     * 문의 상세 조회
     * @param ticketId 문의 ID
     * @return 문의 정보
     */
    Ticket selectTicketById(Long ticketId);
    
    /**
     * 문의 수정 (답변 전에만 가능)
     * @param ticket 수정할 문의 정보
     * @return 수정된 행 개수 (0이면 답변이 이미 있거나 실패)
     */
    void updateTicket(Ticket ticket);
    
    /**
     * 문의 삭제
     * @param ticketId 문의 ID, senderId 작성자 ID, senderType 작성자 타입
     * @return 삭제된 행 개수
     */
    void deleteTicket(Long ticketId, Long senderId, String senderType);
    
    /**
     * 주문번호로 주문 ID 조회
     * @param orderCode 주문번호 (예: 20251004-010001)
     * @return 주문 ID
     */
    Long selectOrderIdByOrderCode(String orderCode);
    
    /**
     * 주문번호로 주문 정보 전체 조회 (검증용)
     * @param orderCode 주문번호
     * @return 주문 정보
     */
    Orders selectOrderByOrderCode(String orderCode);
}
