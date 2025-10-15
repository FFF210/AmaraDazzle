package dao.consumer;

import dto.Payment;

public interface PaymentDAO {
	void insertPayment(Payment payment) throws Exception;
}
