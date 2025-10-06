package service.consumer;

import java.sql.Timestamp;
import java.util.List;

import dao.consumer.TicketDAO;
import dao.consumer.TicketDAOImpl;
import dto.Ticket;

public class TicketServiceImpl implements TicketService {
	private TicketDAO ticketDAO;

	public TicketServiceImpl() {
		ticketDAO = new TicketDAOImpl();
	}

	@Override
	public void createTicket(Ticket ticket, String orderCode) throws Exception {
		// 1. 주문 관련 카테고리면 주문번호로 orderId 찾기
        if (isOrderRelatedCategory(ticket.getCategory())) {
            if (orderCode != null && !orderCode.trim().isEmpty()) {
                Long orderId = ticketDAO.selectOrderIdByOrderCode(orderCode);
                ticket.setOrderId(orderId);
            }
        }
        
        // 2. 기본값 설정
        if (ticket.getExposureStatus() == null) {
            ticket.setExposureStatus("PUBLISHED");
        }
        
        // 3. DAO 호출
        ticketDAO.insertTicket(ticket);
	}

	@Override
	public List<Ticket> getMyTickets(Long senderId, String senderType, Timestamp startDate, Timestamp endDate)
			throws Exception {
		 return ticketDAO.selectTicketsBySenderId(senderId, senderType, startDate, endDate);
	}

	@Override
	public Ticket getTicketDetail(Long ticketId) throws Exception {
		return ticketDAO.selectTicketById(ticketId);
	}
	
	// 주문 관련 카테고리 체크
	private boolean isOrderRelatedCategory(String category) {
	        return "ORDER".equals(category) || 
	               "CANCEL".equals(category) || 
	               "REFUND".equals(category) || 
	               "EXCHANGE".equals(category) ||
	               "DELIVERY".equals(category) || 
	               "PAYMENT".equals(category);
	    }
}
