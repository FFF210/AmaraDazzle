package service.consumer;

import java.sql.Timestamp;
import java.util.List;

import dto.Ticket;

public interface TicketService {
	/**
     * 문의 등록 (주문번호 포함)
     * @param ticket 문의 정보, orderCode 주문번호 (주문 관련 문의일 때)
     * @return 등록 성공 여부
     */
    void createTicket(Ticket ticket, String orderCode) throws Exception;
    
    /**
     * 내 문의 목록 조회 (기간 필터링 가능)
     * @param senderId 작성자 ID, senderType 작성자 타입 (CONSUMER, BRAND_ADMIN)
     * @param startDate 시작일 (null 가능), endDate 종료일 (null 가능)
     * @return 문의 목록
     */
    List<Ticket> getMyTickets(Long senderId, String senderType, 
                              Timestamp startDate, Timestamp endDate) throws Exception;
    
    /**
     * 문의 상세 조회
     * @param ticketId 문의 ID
     * @return 문의 정보
     */
    Ticket getTicketDetail(Long ticketId) throws Exception;
    
}
