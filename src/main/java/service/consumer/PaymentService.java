package service.consumer;

import dto.Payment;

public interface PaymentService {
	//결제 정보 저장
	void savePayment(Payment payment) throws Exception;
}
