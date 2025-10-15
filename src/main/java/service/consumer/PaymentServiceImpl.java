package service.consumer;

import dao.consumer.PaymentDAO;
import dao.consumer.PaymentDAOImpl;
import dto.Payment;

public class PaymentServiceImpl implements PaymentService {
	
	private PaymentDAO paymentDAO;

	public PaymentServiceImpl() {
		this.paymentDAO = new PaymentDAOImpl();
	}

	@Override
    public void savePayment(Payment payment) throws Exception {
        if (payment == null) {
            throw new Exception("결제 정보가 없습니다.");
        }
        if (payment.getOrderId() == null) {
            throw new Exception("주문 ID가 필요합니다.");
        }
        if (payment.getPaymentKey() == null || payment.getPaymentKey().isEmpty()) {
            throw new Exception("결제 키가 필요합니다.");
        }
        
        paymentDAO.insertPayment(payment);
	}
}
